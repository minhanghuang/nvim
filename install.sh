#!/usr/bin/env bash
#
# install.sh — Neovim 配置一键安装脚本
#
# 根据 README.md 的指示, 自动完成以下步骤:
#   1. 安装 / 升级 Neovim (最低 0.12.2)
#   2. 安装 Nerd Fonts 字体
#   3. 安装第三方依赖 (ctags / ripgrep / llvm / tig / sqlite / imagemagick / lazygit 等)
#   4. 通过 nvm 安装 Node.js
#   5. 安装 Python + Protobuf 相关依赖
#   6. 克隆配置到 ~/.config/nvim (若尚未存在)
#   7. 输出 Copilot / Codeium 等手动认证步骤
#
# 用法:
#   ./install.sh             # 交互式安装
#   ./install.sh --yes       # 跳过确认, 非交互安装
#   ./install.sh --help      # 查看帮助
#
# 可选环境变量:
#   CONFIG_DIR   配置目录 (默认 ~/.config/nvim)
#   NVIM_VERSION Neovim 版本 (默认 v0.12.2)
#   NODE_VERSION Node.js 版本 (默认 v22.22.2)

set -euo pipefail

# ---------------------------------------------------------------------------
# 常量
# ---------------------------------------------------------------------------
readonly NVIM_VERSION="${NVIM_VERSION:-v0.12.2}"
readonly NODE_VERSION="${NODE_VERSION:-v22.22.2}"
readonly NVM_VERSION="v0.39.1"
readonly NERD_FONT="DejaVuSansMono"
readonly CONFIG_REPO="https://github.com/minhanghuang/nvim.git"
readonly CONFIG_DIR="${CONFIG_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/nvim}"

# ---------------------------------------------------------------------------
# 颜色输出
# ---------------------------------------------------------------------------
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[0;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

info()  { printf "${BLUE}[INFO]${NC} %s\n" "$*"; }
ok()    { printf "${GREEN}[ OK ]${NC} %s\n" "$*"; }
warn()  { printf "${YELLOW}[WARN]${NC} %s\n" "$*"; }
error() { printf "${RED}[ERROR]${NC} %s\n" "$*" >&2; }
die()   { error "$*"; exit 1; }

# ---------------------------------------------------------------------------
# 全局状态
# ---------------------------------------------------------------------------
OS=""             # linux / macos / unknown
ARCH=""           # x86_64 / arm64 / aarch64
UBUNTU_VERSION="" # Ubuntu 主版本号 (如 20.04), 仅 Ubuntu 有效
YES=0             # 是否跳过确认
WORKDIR=""        # 全局临时目录 (main 中初始化, EXIT 时清理)

# ---------------------------------------------------------------------------
# 基础工具函数
# ---------------------------------------------------------------------------

# 判断命令是否存在
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# 版本比较: 当前版本 >= 期望版本 返回 0 (纯 bash 实现, 兼容 macOS/BSD, 不依赖 GNU sort)
version_at_least() {
  local a="${1#v}" b="${2#v}" a_part b_part i
  local -a a_parts b_parts
  local IFS='.'
  read -r -a a_parts <<< "$a"
  read -r -a b_parts <<< "$b"
  for i in 0 1 2; do
    a_part="${a_parts[$i]:-0}"; a_part="${a_part%%[!0-9]*}"; a_part="${a_part:-0}"
    b_part="${b_parts[$i]:-0}"; b_part="${b_part%%[!0-9]*}"; b_part="${b_part:-0}"
    # 10# 强制按十进制解析, 避免前导零被当作八进制
    if (( 10#$a_part > 10#$b_part )); then return 0; fi
    if (( 10#$a_part < 10#$b_part )); then return 1; fi
  done
  return 0
}

# 交互确认 (--yes 时自动通过)
confirm() {
  local prompt="$1"
  if [[ "$YES" -eq 1 ]]; then
    return 0
  fi
  read -r -p "$prompt [y/N] " answer
  [[ "$answer" =~ ^[Yy]$ ]]
}

# 检测操作系统与架构
detect_os() {
  local uname_s arch
  uname_s="$(uname -s)"
  arch="$(uname -m)"

  case "$arch" in
    x86_64|amd64)  ARCH="x86_64" ;;
    arm64|aarch64) ARCH="arm64"   ;;
    *)             ARCH="$arch"   ;;
  esac

  if [[ "$uname_s" == "Darwin" ]]; then
    OS="macos"
  elif [[ -f /etc/os-release ]]; then
    # shellcheck disable=SC1091
    . /etc/os-release
    if [[ "$ID" == "ubuntu" || "$ID" == "debian" || "${ID_LIKE:-}" == *"debian"* ]]; then
      OS="linux"
      # 仅 Ubuntu 记录版本号, 用于判断是否需源码编译 Neovim
      if [[ "$ID" == "ubuntu" ]]; then
        UBUNTU_VERSION="${VERSION_ID:-}"
      fi
    else
      OS="unknown"
    fi
  else
    OS="unknown"
  fi

  info "检测到系统: ${OS} (架构: ${ARCH})"
}

# 检查前置工具 (git / curl / tar)
check_prerequisites() {
  local missing=()
  for cmd in git curl tar; do
    command_exists "$cmd" || missing+=("$cmd")
  done
  if [[ ${#missing[@]} -gt 0 ]]; then
    die "缺少前置工具: ${missing[*]}. 请先安装后再运行本脚本."
  fi
}

# 判断是否运行在容器内 (Docker / Podman 等)
is_container() {
  [[ -f /.dockerenv ]] && return 0
  [[ -f /run/.containerenv ]] && return 0
  [[ -f /proc/1/cgroup ]] && grep -qE '(docker|container|kubepods|containerd)' /proc/1/cgroup 2>/dev/null && return 0
  return 1
}

# 判断是否为无图形界面的 Server / 容器环境 (无需安装字体)
is_headless() {
  # macOS 始终有 GUI
  [[ "$OS" == "linux" ]] || return 1

  # Docker / Podman 等容器环境无需安装字体
  is_container && return 0

  if command_exists systemctl; then
    # systemd 默认启动目标: multi-user.target => server, graphical.target => desktop
    local target
    target="$(systemctl get-default 2>/dev/null || true)"
    [[ "$target" == "multi-user.target" ]] && return 0
    return 1
  fi

  # 无 systemd (WSL 等): 没有显示服务器则视为 server
  [[ -z "${DISPLAY:-}" && -z "${WAYLAND_DISPLAY:-}" ]]
}

# Ubuntu <= 20.04 需源码编译 Neovim (预编译包依赖更高版本 glibc)
neovim_use_source_build() {
  [[ "$OS" == "linux" && -n "$UBUNTU_VERSION" ]] || return 1
  version_at_least "20.04" "$UBUNTU_VERSION"
}

# ---------------------------------------------------------------------------
# 1. 安装 Neovim
# ---------------------------------------------------------------------------
install_neovim() {
  # 已安装且版本满足要求则跳过
  if command_exists nvim; then
    local current
    current="$(nvim --version | head -n1 | awk '{print $2}')"
    if version_at_least "$current" "$NVIM_VERSION"; then
      ok "Neovim 已安装 (${current} >= ${NVIM_VERSION}), 跳过安装"
      return 0
    fi
    warn "当前 Neovim 版本 ${current} 低于 ${NVIM_VERSION}, 将重新安装"
  fi

  # Ubuntu <= 20.04 走源码编译, 其余版本走预编译包
  if neovim_use_source_build; then
    install_neovim_from_source
    return 0
  fi

  local tarball
  case "$OS" in
    macos)
      if [[ "$ARCH" == "arm64" ]]; then
        tarball="nvim-macos-arm64.tar.gz"
      else
        tarball="nvim-macos-x86_64.tar.gz"
      fi
      ;;
    linux)
      tarball="nvim-linux-x86_64.tar.gz"
      ;;
    *)
      warn "无法为系统 '${OS}' 自动下载预编译 Neovim, 请参考 README.md 从源码安装"
      return 0
      ;;
  esac

  info "下载 Neovim ${NVIM_VERSION} (${tarball}) ..."
  local tmpdir="$WORKDIR/neovim"
  mkdir -p "$tmpdir"

  curl -fL "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/${tarball}" -o "${tmpdir}/${tarball}"
  tar -zxf "${tmpdir}/${tarball}" -C "$tmpdir"

  info "安装到 /usr/local (需要 sudo 权限) ..."
  sudo cp -r "${tmpdir}/${tarball%.tar.gz}"/* /usr/local

  if command_exists nvim; then
    ok "Neovim 安装完成: $(nvim --version | head -n1)"
  else
    warn "Neovim 已复制, 但未在 PATH 中检测到, 请确认 /usr/local/bin 已加入 PATH"
  fi
}

# Ubuntu <= 20.04: 源码编译安装 Neovim
install_neovim_from_source() {
  info "Ubuntu ${UBUNTU_VERSION} 通过源码编译安装 Neovim ${NVIM_VERSION} ..."

  # 编译依赖 (README 要求 gettext/luajit, 补充完整构建链)
  sudo apt install -y build-essential cmake ninja-build gettext luajit unzip

  local srcdir="$WORKDIR/neovim-src"
  git clone --branch "${NVIM_VERSION}" --single-branch --depth 1 \
    https://github.com/neovim/neovim.git "$srcdir"

  # 与 README 一致: make CMAKE_BUILD_TYPE=RelWithDebInfo, 然后 sudo make install
  (
    cd "$srcdir"
    make -j"$(nproc 2>/dev/null || echo 2)" CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
  )
}

# ---------------------------------------------------------------------------
# 2. 安装 Nerd Fonts
# ---------------------------------------------------------------------------
install_fonts() {
  # Ubuntu Server / Docker 容器等无图形界面环境不需要安装字体 (终端渲染在本地客户端完成)
  if is_headless; then
    ok "检测到 Server / 容器环境, 跳过字体安装"
    return 0
  fi

  info "安装 Nerd Fonts 字体: ${NERD_FONT}"

  local font_dir
  if [[ "$OS" == "macos" ]]; then
    font_dir="$HOME/Library/Fonts"
  else
    font_dir="$HOME/.local/share/fonts"
  fi

  # 已安装则跳过
  if find "$font_dir" -iname "*${NERD_FONT}*Nerd*Font*" -print -quit 2>/dev/null | grep -q .; then
    ok "字体 ${NERD_FONT} Nerd Font 已存在, 跳过"
    return 0
  fi

  mkdir -p "$font_dir"

  local tmpdir="$WORKDIR/fonts"
  mkdir -p "$tmpdir"

  local url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${NERD_FONT}.zip"
  info "下载字体: ${url}"
  curl -fL "$url" -o "${tmpdir}/${NERD_FONT}.zip"

  unzip -q "${tmpdir}/${NERD_FONT}.zip" -d "${tmpdir}/fonts"
  # 注意: 必须加括号, 否则 -o 的隐式 -print 只作用于 .otf, .ttf 会被漏掉
  find "${tmpdir}/fonts" -type f \( -iname "*.ttf" -o -iname "*.otf" \) -print | while read -r font; do
    cp "$font" "$font_dir/"
  done

  if [[ "$OS" == "linux" ]] && command_exists fc-cache; then
    fc-cache -f "$font_dir"
  fi

  ok "字体安装完成: ${font_dir}"
  warn "请在终端模拟器 (iTerm2 / kitty / alacritty 等) 中将字体设置为 '${NERD_FONT} Nerd Font'"
}

# ---------------------------------------------------------------------------
# 3. 安装第三方依赖
# ---------------------------------------------------------------------------
install_dependencies() {
  info "安装第三方依赖 ..."
  case "$OS" in
    macos)
      install_dependencies_macos
      ;;
    linux)
      install_dependencies_linux
      ;;
    *)
      warn "无法为系统 '${OS}' 自动安装依赖, 请参考 README.md 手动安装"
      ;;
  esac
}

install_dependencies_macos() {
  if ! command_exists brew; then
    info "未检测到 Homebrew, 开始安装 ..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  brew tap universal-ctags/universal-ctags
  brew install --HEAD universal-ctags
  brew install ripgrep gnu-sed llvm tig sqlite
  brew install imagemagick          # 图片预览
  brew install lazygit              # 可选, git 客户端
}

install_dependencies_linux() {
  sudo apt update

  # 必需依赖 (含 Neovim / treesitter 编译所需的 gcc 等)
  sudo apt install -y \
    git curl wget tar gzip unzip make gcc g++ cmake gettext \
    python3-venv python3-pip universal-ctags global tig sqlite3 libsqlite3-0 \
    ripgrep imagemagick

  # llvm 体积较大, 单独安装, 失败不中断
  sudo apt install -y llvm || warn "llvm 安装失败, 可稍后手动安装"

  # lazygit (可选)
  if command_exists lazygit; then
    ok "lazygit 已安装, 跳过"
  elif confirm "是否安装 lazygit (可选)?"; then
    local lazygit_version
    lazygit_version="$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*' || true)"
    if [[ -n "$lazygit_version" ]]; then
      local tmpdir="$WORKDIR/lazygit"
      mkdir -p "$tmpdir"
      curl -Lo "${tmpdir}/lazygit.tar.gz" "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${lazygit_version}_Linux_x86_64.tar.gz"
      tar xf "${tmpdir}/lazygit.tar.gz" -C "$tmpdir" lazygit
      sudo install "${tmpdir}/lazygit" /usr/local/bin
      ok "lazygit 安装完成"
    else
      warn "获取 lazygit 版本失败, 跳过"
    fi
  fi
}

# ---------------------------------------------------------------------------
# 4. 安装 Node.js (nvm)
# ---------------------------------------------------------------------------
install_node() {
  export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

  if [[ ! -s "$NVM_DIR/nvm.sh" ]]; then
    info "安装 nvm ..."
    curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" | bash
  fi

  # 加载 nvm (非交互 shell 下)
  # shellcheck disable=SC1090
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

  # 已安装且版本 >= 指定版本 (含更新版本) 则跳过
  if command_exists node; then
    local current
    current="$(node --version)"
    if version_at_least "$current" "$NODE_VERSION"; then
      ok "Node.js 已安装 (${current} >= ${NODE_VERSION}), 跳过"
      return 0
    fi
    warn "当前 Node.js 版本 ${current} 低于 ${NODE_VERSION}, 将安装 ${NODE_VERSION}"
  fi

  info "安装 Node.js ${NODE_VERSION} ..."
  nvm install "$NODE_VERSION"
  nvm alias default "$NODE_VERSION"
  ok "Node.js 安装完成: $(node --version)"
}

# ---------------------------------------------------------------------------
# 5. 安装 Python + Protobuf 依赖
# ---------------------------------------------------------------------------
install_python_deps() {
  info "安装 Python + Protobuf 相关依赖 (mypy-protobuf / protobuf) ..."

  if ! command_exists python3; then
    warn "未检测到 python3, 跳过 Python 依赖安装"
    return 0
  fi

  # PEP 668 (Ubuntu 23.04+) 环境下需要 --break-system-packages
  if ! python3 -m pip install --user mypy-protobuf protobuf 2>/dev/null; then
    warn "普通 pip 安装失败, 尝试 --break-system-packages"
    python3 -m pip install --user --break-system-packages mypy-protobuf protobuf \
      || warn "Python 依赖安装失败, 请稍后手动执行: python3 -m pip install mypy-protobuf protobuf"
  fi

  # 将 ~/.local/bin 加入 PATH
  local local_bin="$HOME/.local/bin"
  for rc in "$HOME/.zshrc" "$HOME/.bashrc"; do
    if [[ -f "$rc" ]] && ! grep -q "$local_bin" "$rc"; then
      echo "export PATH=$local_bin:\$PATH" >> "$rc"
      ok "已将 $local_bin 加入 PATH ($rc)"
    fi
  done
  export PATH="$local_bin:$PATH"

  ok "Python + Protobuf 依赖安装完成"
}

# ---------------------------------------------------------------------------
# 6. 配置目录 (克隆 / 链接)
# ---------------------------------------------------------------------------
setup_config() {
  local script_dir
  script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

  # 脚本本身位于配置仓库内
  if [[ -f "$script_dir/init.vim" && -f "$script_dir/lua/user/plugins.lua" ]]; then
    ok "检测到脚本位于配置仓库内: ${script_dir}"
    if [[ "$script_dir" == "$CONFIG_DIR" ]]; then
      info "配置目录已就位: ${CONFIG_DIR}"
    else
      info "建立符号链接: ${CONFIG_DIR} -> ${script_dir}"
      mkdir -p "$(dirname "$CONFIG_DIR")"
      [[ -e "$CONFIG_DIR" || -L "$CONFIG_DIR" ]] || ln -s "$script_dir" "$CONFIG_DIR"
    fi
    return 0
  fi

  # 独立运行: 克隆仓库
  if [[ -e "$CONFIG_DIR" ]]; then
    if [[ -f "$CONFIG_DIR/init.vim" ]]; then
      ok "配置目录已存在: ${CONFIG_DIR}, 跳过克隆"
      return 0
    fi
    die "目录 ${CONFIG_DIR} 已存在但不是本配置仓库, 请手动处理后重试"
  fi

  info "克隆配置仓库到 ${CONFIG_DIR} ..."
  git clone "$CONFIG_REPO" "$CONFIG_DIR"
  ok "配置克隆完成"
}

# ---------------------------------------------------------------------------
# 7. 收尾提示
# ---------------------------------------------------------------------------
print_post_install() {
  echo
  info "==================== 安装完成 ===================="
  echo "接下来还有以下手动步骤:"
  echo
  echo "  [1] 字体: 在终端模拟器中设置字体为 '${NERD_FONT} Nerd Font'"
  echo
  echo "  [2] GitHub Copilot (可选):"
  echo "      打开 nvim 执行 :Copilot Auth"
  echo "      复制验证码 -> 浏览器登录 -> 输入验证码"
  echo
  echo "  [3] Codeium (可选):"
  echo "      打开 nvim 执行 :Codeium Auth -> 选择 Display URL"
  echo "      复制 URL 到浏览器 -> 复制 Token 并粘贴"
  echo
  echo "  [4] 重新打开终端 (使 nvm / PATH 生效), 然后运行 nvim"
  echo
  ok "Enjoy your Neovim! 🚀"
}

# ---------------------------------------------------------------------------
# 帮助
# ---------------------------------------------------------------------------
print_help() {
  cat <<EOF
用法: $0 [选项]

根据 README.md 自动完成 Neovim 配置的一键安装.

选项:
  -y, --yes    跳过所有确认提示, 非交互安装
  -h, --help   显示本帮助

可选环境变量:
  CONFIG_DIR   配置目录 (默认 ~/.config/nvim)
  NVIM_VERSION Neovim 版本 (默认 v0.12.2)
  NODE_VERSION Node.js 版本 (默认 v22.22.2)

示例:
  $0 --yes
  CONFIG_DIR=~/.config/nvim NVIM_VERSION=v0.12.2 $0
EOF
}

# ---------------------------------------------------------------------------
# 主流程
# ---------------------------------------------------------------------------
main() {
  # 解析参数
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -y|--yes) YES=1 ;;
      -h|--help) print_help; exit 0 ;;
      *) warn "未知参数: $1"; print_help; exit 1 ;;
    esac
    shift
  done

  echo
  info "开始安装 Neovim 配置 (Neovim ${NVIM_VERSION} / Node ${NODE_VERSION})"
  echo

  # 初始化全局临时目录, 脚本退出时统一清理
  WORKDIR="$(mktemp -d)"
  trap 'rm -rf "$WORKDIR"' EXIT

  detect_os
  check_prerequisites

  # 非交互模式下直接继续; 交互模式先展示计划并确认
  if [[ "$YES" -eq 0 ]]; then
    echo "将执行以下步骤:"
    echo "  1. 安装 Neovim ${NVIM_VERSION}"
    echo "  2. 安装 Nerd Fonts 字体 (${NERD_FONT})"
    echo "  3. 安装第三方依赖"
    echo "  4. 通过 nvm 安装 Node.js ${NODE_VERSION}"
    echo "  5. 安装 Python + Protobuf 依赖"
    echo "  6. 克隆/链接配置到 ${CONFIG_DIR}"
    echo
    confirm "是否继续?" || die "已取消安装"
  fi

  echo
  install_neovim
  install_fonts
  install_dependencies
  install_node
  install_python_deps
  setup_config
  print_post_install
}

main "$@"
