#!/usr/bin/env bash

set -euo pipefail

NVIM_VERSION="v0.12.2"
NVM_VERSION="v0.39.1"
NODE_VERSION="v22.22.2"

INSTALL_IMAGE_TOOLS=1
INSTALL_NEOVIM=1
INSTALL_NODE=1
INSTALL_DEPS=1

usage() {
  cat <<'USAGE'
Usage: ./install.sh [options]

Install the environment described in README.md for this Neovim configuration:
  - Neovim v0.12.2
  - Node.js v22.22.2 via nvm v0.39.1
  - Third-party dependencies for Ubuntu/macOS

Options:
  --no-image-tools      Skip ImageMagick installation
  --no-neovim           Skip Neovim installation
  --no-node             Skip Node.js/nvm installation
  --no-deps             Skip third-party system dependencies
  -h, --help            Show this help message
USAGE
}

log() {
  printf '\033[1;34m==>\033[0m %s\n' "$*"
}

warn() {
  printf '\033[1;33mWARN:\033[0m %s\n' "$*" >&2
}

err() {
  printf '\033[1;31mERROR:\033[0m %s\n' "$*" >&2
}

have() {
  command -v "$1" >/dev/null 2>&1
}

sudo_cmd() {
  if [ "$(id -u)" -eq 0 ]; then
    "$@"
  else
    sudo "$@"
  fi
}

normalize_arch() {
  case "$(uname -m)" in
    x86_64|amd64) printf 'x86_64' ;;
    arm64|aarch64) printf 'arm64' ;;
    *) uname -m ;;
  esac
}

parse_args() {
  while [ "$#" -gt 0 ]; do
    case "$1" in
      --no-image-tools) INSTALL_IMAGE_TOOLS=0 ;;
      --no-neovim) INSTALL_NEOVIM=0 ;;
      --no-node) INSTALL_NODE=0 ;;
      --no-deps) INSTALL_DEPS=0 ;;
      -h|--help) usage; exit 0 ;;
      *) err "Unknown option: $1"; usage; exit 2 ;;
    esac
    shift
  done
}

install_ubuntu_deps() {
  log "Installing Ubuntu dependencies"
  sudo_cmd apt update
  sudo_cmd apt install -y \
    ca-certificates \
    curl \
    git \
    gettext \
    global \
    llvm \
    luajit \
    python3-pip \
    python3-venv \
    ripgrep \
    sqlite3 \
    libsqlite3-0 \
    tar \
    tig \
    universal-ctags \
    wget

  if [ "$INSTALL_IMAGE_TOOLS" -eq 1 ]; then
    sudo_cmd apt install -y imagemagick
  fi
}

install_macos_deps() {
  if ! have brew; then
    err "Homebrew is required on macOS. Install it first: https://brew.sh/"
    exit 1
  fi

  log "Installing macOS dependencies"
  brew tap universal-ctags/universal-ctags || true
  brew install --HEAD universal-ctags
  brew install ripgrep gnu-sed llvm tig sqlite

  if [ "$INSTALL_IMAGE_TOOLS" -eq 1 ]; then
    brew install imagemagick
  fi
}

install_neovim_from_binary() {
  local os="$1"
  local arch="$2"
  local archive=""
  local extracted_dir=""

  case "$os:$arch" in
    linux:x86_64)
      archive="nvim-linux-x86_64.tar.gz"
      extracted_dir="nvim-linux-x86_64"
      ;;
    darwin:x86_64)
      archive="nvim-macos-x86_64.tar.gz"
      extracted_dir="nvim-macos-x86_64"
      ;;
    darwin:arm64)
      archive="nvim-macos-arm64.tar.gz"
      extracted_dir="nvim-macos-arm64"
      ;;
    *)
      return 1
      ;;
  esac

  local url="https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/${archive}"
  local tmpdir
  tmpdir="$(mktemp -d)"
  trap 'rm -rf "$tmpdir"' RETURN

  log "Downloading Neovim ${NVIM_VERSION} from ${url}"
  curl -fL "$url" -o "${tmpdir}/${archive}"
  tar -xzf "${tmpdir}/${archive}" -C "$tmpdir"

  log "Installing Neovim to /usr/local"
  sudo_cmd cp -R "${tmpdir}/${extracted_dir}/." /usr/local/
}

install_neovim_from_source() {
  local tmpdir
  tmpdir="$(mktemp -d)"
  trap 'rm -rf "$tmpdir"' RETURN

  log "Installing build dependencies for Neovim source build"
  case "$(uname -s)" in
    Linux)
      sudo_cmd apt update
      sudo_cmd apt install -y build-essential cmake gettext git luajit ninja-build pkg-config unzip
      ;;
    Darwin)
      if ! have brew; then
        err "Homebrew is required to install luajit for a macOS source build."
        exit 1
      fi
      brew install luajit cmake ninja gettext
      ;;
  esac

  log "Building Neovim ${NVIM_VERSION} from source"
  git clone --branch "$NVIM_VERSION" --single-branch --depth 1 https://github.com/neovim/neovim.git "$tmpdir/neovim"
  make -C "$tmpdir/neovim" CMAKE_BUILD_TYPE=RelWithDebInfo
  sudo_cmd make -C "$tmpdir/neovim" install
}

install_neovim() {
  local os=""
  local arch
  arch="$(normalize_arch)"

  case "$(uname -s)" in
    Linux) os="linux" ;;
    Darwin) os="darwin" ;;
    *) err "Unsupported OS: $(uname -s)"; exit 1 ;;
  esac

  if install_neovim_from_binary "$os" "$arch"; then
    return
  fi

  warn "No prebuilt Neovim archive configured for ${os}/${arch}; falling back to source build."
  install_neovim_from_source
}

install_node_with_nvm() {
  export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

  if [ ! -s "$NVM_DIR/nvm.sh" ]; then
    log "Installing nvm ${NVM_VERSION}"
    curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" | bash
  else
    log "Using existing nvm at ${NVM_DIR}"
  fi

  # shellcheck disable=SC1091
  . "$NVM_DIR/nvm.sh"

  log "Installing Node.js ${NODE_VERSION}"
  nvm install "$NODE_VERSION"
  nvm alias default "$NODE_VERSION"
  nvm use default
}

main() {
  parse_args "$@"

  case "$(uname -s)" in
    Linux)
      if [ "$INSTALL_DEPS" -eq 1 ]; then
        install_ubuntu_deps
      fi
      ;;
    Darwin)
      if [ "$INSTALL_DEPS" -eq 1 ]; then
        install_macos_deps
      fi
      ;;
    *) err "Unsupported OS: $(uname -s)"; exit 1 ;;
  esac

  if [ "$INSTALL_NEOVIM" -eq 1 ]; then
    install_neovim
  fi

  if [ "$INSTALL_NODE" -eq 1 ]; then
    install_node_with_nvm
  fi

  log "Installation complete"
  log "Open a new shell or source your shell rc file, then run: nvim --version"
}

main "$@"
