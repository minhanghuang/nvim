[TOC]

# NeoVim

![neovim](./data/cpp-debug.gif)

## #1 安装

### #1.1 macOS 

```shell
brew install neovim 
pip3 install neovim 
```

### #1.2 Ubuntu 

- 到`NeoVim`官网下载合适的版本(我这里使用nvim0.7版本)

```shell
curl -O https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb
```

```shell
// Ubuntu18 安装NeoVim0.7需要以来libgcc-s1
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt update
sudo apt --fix-broken install
sudo apt install libgcc-s1
sudo apt install ./nvim-linux64.deb
```

```shell
// nvim --version
NVIM v0.7.0
Build type: Release
LuaJIT 2.1.0-beta3
Compiled by runner@fv-az316-460

Features: +acl +iconv +tui
See ":help feature-compile"

   system vimrc file: "$VIM/sysinit.vim"
  fall-back for $VIM: "/share/nvim"

Run :checkhealth for more info
```

> 因为后面使用`neovim`插件时,有些插件需要依赖`Python`,所以这里提前在`Python`中安装`neovim`库

> 安装node.js

```shell
sudo apt install libssl1.0-dev
sudo apt install nodejs-dev
sudo apt install node-gyp
sudo apt install -y nodejs npm  
sudo npm config set registry https://registry.npm.taobao.org
sudo npm install n -g
sudo n stable  # 安装最新版本, coc.nvim需要依赖高版本node

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install yarn
yarn config set registry https://registry.npm.taobao.org/
```

> 安装Python库 , coc.nvim依赖库

```shell
sudo apt install python3-venv
pip3 install jedi
pip3 install jedi-language-server==0.35.1
```

## #2 安装插件

### #2.1 脚本

- 拉取NeoVim配置

```shell
git clone git@github.com:minhanghuang/nvim.git ~/.config/nvim
```

- 拉取第三方库

> 这里使用脚本拉取第三方库

```shell
cd ~/.config/nvim
./install.sh
```

