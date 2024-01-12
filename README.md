# NeoVim

![neovim](./data/images/cpp-debug.gif)

```shell
git clone --depth 1 https://github.com/minhanghuang/nvim.git ~/.config/nvim
```

## #1 配置

### #1.1 字体

[DejaVuSansMono](https://www.nerdfonts.com/font-downloads)

### #1.2 插件

1. 包管理

- [ ] [lazy.nvim](https://github.com/folke/lazy.nvim)

2. LSP

- [ ] [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig): neovim官方提供的基础配置
- [ ] [mason.nvim](https://github.com/williamboman/mason.nvim): 管理lsp/dap/linter/format包工具
- [ ] [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim): 连接nvim-lspconfig和mason.nvim这两个插件

3. Complele

- [ ] [nvim-cmp](https://github.com/hrsh7th/nvim-cmp): 有了lsp还需要代码自动补全功能

4. DAP

- [ ] [nvim-dap](https://github.com/mfussenegger/nvim-dap): 基础的代码debug插件
- [ ] [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui): debug过程可视化插件
- [ ] [mason-nvim-dap](https://github.com/jay-babu/mason-nvim-dap.nvim): 提供dap基础接口, 简化配置

5. 代码片段

- [ ] [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip): 代码片段引擎 
- [ ] [honza/vim-snippets](https://github.com/honza/vim-snippets): snipMate和UltiSnip类型
- [ ] [rafamadriz/friendly-snippets](https://github.com/rafamadriz/friendly-snippets): LuaSnip类型

6. 格式化

- [ ] [mhartington/formatter.nvim](https://github.com/mhartington/formatter.nvim): lsp提供格式化功能, 但是有些语言不支持格式化(例如: Python), 这里加入一个格式化插件, 补充lsp格式化缺陷

## #2 环境

### #2.1 neovim

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

### #2.2 Node.js

> Node版本选择: `v15.4.0`, 使用`nvm`对Node.js版本进行管理

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

- nvm(可选)

```shell
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source ~/.zshrc
nvm install 15.4.0
nvm alias default 15.4.0
```

### #2.3 dependency

```shell
sudo python3 -m pip install --prefix=/usr/local -r requirement.txt
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
