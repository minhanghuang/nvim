# NeoVim

![neovim](https://raw.githubusercontent.com/wiki/minhanghuang/nvim/images/cpp-debug.gif)

```shell
git clone https://github.com/minhanghuang/nvim.git ~/.config/nvim
```

## #1 env

### #1.1 neovim

> minimum neovim 0.8.3

- macOS

```shell
wget https://github.com/neovim/neovim/releases/download/v0.9.4/nvim-macos.tar.gz
tar -zxvf nvim-macos.tar.gz
sudo cp -r nvim-macos/* /usr/local
```

- Ubuntu

```
wget https://github.com/neovim/neovim/releases/download/v0.9.4/nvim-linux64.tar.gz
tar -zxvf nvim-linux64.tar.gz
sudo cp -r nvim-linux64/* /usr/local
```

### #1.2 font

[DejaVuSansMono](https://www.nerdfonts.com/font-downloads)

### #1.3 Node.js

> The Node.js version I am using is selected as' v15.4.0 ', and I am using' nvm 'to manage the Node.js version

- macOS

```shell
brew install nodejs yarn
npm config set registry http://registry.npmmirror.com
yarn config set registry http://registry.npmmirror.com
```

- Ubuntu

```shell
sudo apt update
sudo apt install -y nodejs npm
sudo npm config set http://registry.npmmirror.com
sudo npm install n -g
sudo n stable
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install yarn
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
python3 -m pip install -r requirement.txt
```

- macOS

```shell
brew tap universal-ctags/universal-ctags
brew install --HEAD universal-ctags
brew install ripgrep gnu-sed llvm tig
```

- Ubuntu

```shell
sudo apt update
sudo apt install -y universal-ctags global python3-venv llvm tig ripgrep
```

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
