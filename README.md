[TOC]

# NeoVim使用


## #1 安装

### #1.1 macOS 

```shell
brew install neovim 
pip3 install neovim 
```

### #1.2 Ubuntu 

```shell
// 安装高版本的nvim(默认低版本,有些语法不支持)
sudo apt-get install software-properties-common
sudo apt-get update
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt install neovim 
sudo apt-get install ripgrep
sudo apt install fd-find
pip3 install neovim 
```

```shell
vim --version
// NVIM v0.6.1
// Build type: Release
// LuaJIT 2.1.0-beta3
```

> 因为后面使用`neovim`插件时,有些插件需要依赖`Python`,所以这里提前在`Python`中安装`neovim`库

> 安装node.js

```shell
sudo apt install -y nodejs npm  
sudo npm config set registry https://registry.npm.taobao.org
sudo npm install n -g
sudo n stable  # 安装最新版本, coc.nvim需要依赖高版本node

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install yarn
```

> 安装Python库 , coc.nvim依赖库

```shell
sudo apt install python3-venv
pip3 install jedi
pip3 install jedi-language-server==0.35.1
```

## #2 NeoVim

### #2.1 安装脚本

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

> 至此, NeoVim基本配置完成!

> 进入`NeoVim`, 发现有很多错误提示,这是因为有些第三方库没有没有安装完整(只是拉取了源码,没有进一步安装)

- 安装插件

查看`~/.config/nvim/init.vim`, 找到`Plug xxx`

```shell
cat ~/.config/nvim/init.vim
```

```shell
call plug#begin('~/.config/nvim/plugged')
...
Plug 'junegunn/fzf',{'dir' : '~/.fzf', 'do' : './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'iamcco/markdown-preview.nvim', {'do' : 'cd app && yarn install'}
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
...
call plug#end()
```

`{'dir' : '~/.fzf', 'do' : './install --all'}` 表示到`~/.fzf`目录下,运行指令`./install --all`

```shell
cd ~/.fzf
./install --all
```

`{'branch': 'master', 'do': 'yarn install --frozen-lockfile'}`表示到`~/.config/nvim/plugged/neoclide/coc.nvim`目录下,切换`master`分支,然后运行命令`yarn install --frozen-lockfile`

```shell
cd ~/.config/nvim/plugged/neoclide/coc.nvim
git checkout master 
yarn install --frozen-lockfile
```

> 依次安装所有插件



## # 问题 

### #1 coc.nvim C++安装失败 

```shell
https://github.com/clangd/coc-clangd/issues/61
```

> 每次重装都会遇到这个问题,但是,有一次解决问题的方法与之前的不同,大多数情况是和上面的`issues`的解决方法一样,有一次是讲coc.settings.json文件清空就可以解决,记录一下
