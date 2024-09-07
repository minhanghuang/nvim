# NeoVim

![neovim](https://raw.githubusercontent.com/wiki/minhanghuang/nvim/images/cpp-debug.gif)

```shell
git clone https://github.com/minhanghuang/nvim.git ~/.config/nvim
```

## #1 env

### #1.1 Neovim

> Neovim minimum version required: `0.9.0`. If you wish to enable copying and pasteing functionality in SSH or docker containers, please upgrade to version `0.10.0` or `later`. [related link](https://github.com/neovim/neovim/pull/25872)


<details open>
<summary>Ubuntu</summary>

```
wget https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-linux64.tar.gz
tar -zxvf nvim-linux64.tar.gz
sudo cp -r nvim-linux64/* /usr/local
```

</details>

<details>
<summary>macOS</summary>

- Intel Silicon


```shell
wget https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-macos-x86_64.tar.gz
tar -zxvf nvim-macos-x86_64.tar.gz
sudo cp -r nvim-macos-x86_64/* /usr/local
```

- Apple Silicon

```shell
wget https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-macos-arm64.tar.gz
tar -zxvf nvim-macos-arm64.tar.gz
sudo cp -r nvim-macos-arm64/* /usr/local
```

</details>

<details>
<summary>Source Code</summary>

> support x86_64 arrch64

```shell
# macOS
brew install luajit

# ubuntu
sudo apt install -y gettext luajit
```

```shell
git clone --branch v0.10.0 --single-branch --depth 1 https://github.com/neovim/neovim.git
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

### #1.2 Font

- [DejaVuSansMono](https://www.nerdfonts.com/font-downloads)
- [Monaco](https://github.com/Karmenzind/monaco-nerd-fonts/blob/master/fonts/MonacoNerdFont-Regular.ttf)

### #1.3 Node.js

> The Node.js version I am using is selected as `v15.4.0`, and I am using `nvm` to manage the Node.js version

- macOS

```shell
brew install nodejs yarn
```

```shell
# option
npm config set registry http://registry.npmmirror.com
yarn config set registry http://registry.npmmirror.com
```

- Ubuntu

```shell
sudo apt update
sudo apt install -y nodejs npm
sudo npm install n -g
sudo n stable
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install yarn
```

```shell
# option
sudo npm config set http://registry.npmmirror.com
yarn config set registry http://registry.npmmirror.com
```

- nvm(option)

```shell
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source ~/.zshrc
nvm install 15.4.0
nvm alias default 15.4.0
```

### #1.3 dependency

```shell
sudo python3 -m pip install --prefix=/usr/local -r requirement.txt
```

- macOS

```shell
brew tap universal-ctags/universal-ctags
brew install --HEAD universal-ctags
```

```shell
brew install ripgrep gnu-sed llvm tig
```

<details>
<summary>lazygit(Option)</summary>

```shell
# https://github.com/jesseduffield/lazygit?tab=readme-ov-file#homebrew
brew install lazygit
```

</details>

- Ubuntu

```shell
sudo apt update
sudo apt install -y python3-venv
```

```shell
sudo apt install -y universal-ctags global llvm tig
```

> ripgrep

```shell
# Ubuntu20.04+
sudo apt install -y ripgrep

# Ubuntu18.04
wget https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep_14.1.0-1_amd64.deb
sudo dpkg -i ripgrep_14.1.0-1_amd64.deb
```

<details>
<summary>lazygit(Option)</summary>

```shell
# https://github.com/jesseduffield/lazygit?tab=readme-ov-file#ubuntu
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
```

</details>

## # Supplement

### #.1 Auto Completion With Python Protobuf

1. installation

```shell
python3 -m pip install mypy-protobuf protobuf
```

```shell
export PATH=~/.local/bin:$PATH
```

2. generate python protobuf

```shell
protoc -I=./ --python_out=. --mypy_out=. *.proto
```

### #.2 About Neovim OSC 52 Clipboard Support

1. Neovim version should be 0.10.0+ or higher

2. Configure the host terminal, for example `iTerm2`:
   Go to Settings -> General -> Selection
   Check the boxes for:
   - `Copy to pasteboard on selection`
   - `Applications in terminal may access clipboard Allow sending of clipboard contents?`
