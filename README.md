# NeoVim

![neovim](./data/cpp-debug.gif)

```shell
git clone --depth 1 https://github.com/minhanghuang/nvim.git ~/.config/nvim
```

## #1 Installation

### #1.1 neovim

> minimum neovim 0.8.3

- macOS

```shell
brew install neovim
```

- Ubuntu

```
wget https://github.com/neovim/neovim/releases/download/v0.8.3/nvim-linux64.tar.gz
tar -zxvf nvim-linux64.tar.gz
sudo cp -r nvim-linux64/* /usr/local
```

### #1.2 Node.js

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

### #1.3 dependency

```shell
sudo python3 -m pip install --prefix=/usr/local -r requirement.txt
```

```shell
python3 setup.py
```

```shell
nvim
:PlugInstall
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
sudo dpkg -i data/ripgrep_0.10.0_amd64.deb
sudo apt install -y ctags python3-venv llvm tig
```

