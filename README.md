[TOC]

# NeoVim

![neovim](./data/cpp-debug.gif)

```shell
git clone git@github.com:minhanghuang/nvim.git ~/.config/nvim
```

## #1 Installation 

### #1.1 neovim

- macOS

```shell
brew install neovim 
```

- Ubuntu 

> Ubuntu20.04 nvim0.7

```
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb
sudo dpkg -i nvim-linux64.deb
```

### #1.2 node 

- macOS

```shell
brew install nodejs yarn
npm install -g cnpm --registry=https://registry.npm.taobao.org
yarn config set registry https://registry.npm.taobao.org/
```

- Ubuntu

```shell
sudo apt install python3-venv
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

### #1.3 python lib

```shell
pip3 install neovim 
pip3 install jedi
pip3 install jedi-language-server==0.35.1
```

### #1.4 vim plugin

```shell
cd ~/.config/nvim
./install.sh
```

