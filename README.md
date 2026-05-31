# 🌟 NeoVim Configuration

![neovim](https://raw.githubusercontent.com/wiki/minhanghuang/nvim/images/cpp-debug.gif)

A highly customized **Neovim** configuration tailored for C++/Python development, featuring rich plugin support, debugging, fuzzy search, LSP, and AI autocompletion tools like GitHub Copilot and Codeium.

## 📦 Installation

```shell
git clone https://github.com/minhanghuang/nvim.git ~/.config/nvim
```

## 🛠 Environment Setup

### ✅ Neovim

- Minimum required version: 0.12.0
- Recommended version (for clipboard support in SSH/docker): 0.12.2+ [Related PR](https://github.com/neovim/neovim/pull/25872)

#### Ubuntu

```
wget https://github.com/neovim/neovim/releases/download/v0.12.2/nvim-linux-x86_64.tar.gz
tar -zxvf nvim-linux-x86_64.tar.gz
sudo cp -r nvim-linux-x86_64/* /usr/local
```

#### macOS

- Intel Silicon
```shell
wget https://github.com/neovim/neovim/releases/download/v0.12.2/nvim-macos-x86_64.tar.gz
tar -zxvf nvim-macos-x86_64.tar.gz
sudo cp -r nvim-macos-x86_64/* /usr/local
```

- Apple Silicon
```shell
wget https://github.com/neovim/neovim/releases/download/v0.12.2/nvim-macos-arm64.tar.gz
tar -zxvf nvim-macos-arm64.tar.gz
sudo cp -r nvim-macos-arm64/* /usr/local
```

#### From Source (supports x86_64 & aarch64)

```shell
# macOS
brew install luajit

# ubuntu
sudo apt install -y gettext luajit
```

```shell
git clone --branch v0.12.0 --single-branch --depth 1 https://github.com/neovim/neovim.git
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo

# option
## make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/neovim"

# Ubuntu option create package of deb
## cd build && sudo cpack -G DEB TGZ && sudo dpkg -i nvim-*.deb
```

```shell
sudo make install
```

</details>

### 🖋 Fonts

Download and install one of the following [Nerd Fonts](https://www.nerdfonts.com/font-downloads):
- [DejaVuSansMono](https://www.nerdfonts.com/font-downloads)
- [Monaco](https://github.com/Karmenzind/monaco-nerd-fonts/blob/master/fonts/MonacoNerdFont-Regular.ttf)

### 🔗 Dependencies

#### Node.js (via nvm)

```shell
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source ~/.zshrc
nvm install v22.22.2
nvm alias default v22.22.2
```

#### Third-Party Tools

##### macOS
```shell
brew tap universal-ctags/universal-ctags
brew install --HEAD universal-ctags
brew install ripgrep gnu-sed llvm tig sqlite
```

```shell
# for image view
brew install imagemagick
```

Optional: Install [Lazygit](https://github.com/jesseduffield/lazygit)

```shell
brew install lazygit
```

##### Ubuntu

```shell
sudo apt update
sudo apt install -y python3-venv universal-ctags global llvm tig sqlite3 libsqlite3-0
```

```shell
# for image view
sudo apt install imagemagick
``````

- ripgrep

```shell
# Ubuntu20.04+
sudo apt install -y ripgrep

# Ubuntu18.04
wget https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep_14.1.0-1_amd64.deb
sudo dpkg -i ripgrep_14.1.0-1_amd64.deb
```

Optional: Install [Lazygit](https://github.com/jesseduffield/lazygit)

```shell
# https://github.com/jesseduffield/lazygit?tab=readme-ov-file#ubuntu
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
```

### 🤖 AI Code Completion

#### GitHub Copilot

![copilot-auth](https://raw.githubusercontent.com/wiki/minhanghuang/nvim/images/copilot-auth.jpg)

1. Can be done by running: `:Copilot Auth`

2. Copy the verification code

3. Open the link in a browser and log in

4. Enter the verification code

#### Codeium

![codeium-auth](https://raw.githubusercontent.com/wiki/minhanghuang/nvim/images/codeium-auth.jpg)

1. [login codeium](https://codeium.com/vim_tutorial?extensionName=neovim)

2. Can be done by running: `:Codeium Auth`

3. Select `Display URL`

4. Copy and paste the URL into the browser

5. Copy Token and paste your Token

## 🧩 Supplement

### Auto Completion With Python + Protobuf

Install dependencies:

```shell
python3 -m pip install mypy-protobuf protobuf
export PATH=~/.local/bin:$PATH
```

Generate .py + .pyi:
```shell
protoc -I=./ --python_out=. --mypy_out=. *.proto
```

### Clipboard Support (OSC52)

- Neovim version should be 0.10.0+ or higher
- Configure the host terminal, for example `iTerm2`:

Go to: Settings → General → Selection
- [x] Copy to pasteboard on selection
- [x] Applications in terminal may access clipboard

