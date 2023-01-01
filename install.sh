#!/bin/bash

echo "install git plug"

# plug 管理工具 
git clone git@github.com:rktjmp/lush.nvim.git ~/.config/nvim/plugged

# 主题 
git clone git@github.com:ellisonleao/gruvbox.nvim.git ~/.config/nvim/plugged/gruvbox.nvim
git clone git@github.com:kyazdani42/nvim-web-devicons.git ~/.config/nvim/plugged/nvim-web-devicons

# 文件树
git clone git@github.com:nvim-tree/nvim-tree.lua.git ~/.config/nvim/plugged/nvim-tree.lua

# 窗口tag 
git clone git@github.com:akinsho/bufferline.nvim.git ~/.config/nvim/plugged/bufferline.nvim
git clone git@github.com:famiu/bufdelete.nvim.git ~/.config/nvim/plugged/bufdelete.nvim
cd ~/.config/nvim/plugged/bufdelete.nvim && git checkout 46255e4a76c4fb450a94885527f5e58a7d96983c 
git clone git@github.com:windwp/windline.nvim.git ~/.config/nvim/plugged/windline.nvim
git clone git@github.com:lewis6991/gitsigns.nvim.git ~/.config/nvim/plugged/gitsigns.nvim

# 跳转
git clone git@github.com:neoclide/coc.nvim.git ~/.config/nvim/plugged/coc.nvim
cd ~/.config/nvim/plugged/coc.nvim && git checkout v0.0.81

# 彩虹括号 
git clone git@github.com:luochen1990/rainbow.git ~/.config/nvim/plugged/rainbow
git clone git@github.com:jiangmiao/auto-pairs.git ~/.config/nvim/plugged/auto-pairs

# 搜索 
# git clone git@github.com:junegunn/fzf.vim.git ~/.config/nvim/plugged/fzf.vim
git clone git@github.com:junegunn/fzf.git  ~/.fzf
cd ~/.fzf && ./install --all
git clone git@github.com:nvim-telescope/telescope.nvim.git ~/.config/nvim/plugged/telescope.nvim
git clone git@github.com:nvim-lua/plenary.nvim.git ~/.config/nvim/plugged/plenary.nvim
git clone git@github.com:BurntSushi/ripgrep.git ~/.config/nvim/plugged/ripgrep
git clone git@github.com:sharkdp/fd.git ~/.config/nvim/plugged/fd
git clone git@github.com:kevinhwang91/nvim-hlslens.git ~/.config/nvim/plugged/nvim-hlslens

# 最近打开文件
git clone git@github.com:mhinz/vim-startify.git ~/.config/nvim/plugged/vim-startify

# terminal
git clone git@github.com:voldikss/vim-floaterm.git ~/.config/nvim/plugged/vim-floaterm

# markdown
git clone git@github.com:iamcco/markdown-preview.nvim.git ~/.config/nvim/plugged/markdown-preview.nvim
cd ~/.config/nvim/plugged/markdown-preview.nvim/app && yarn install

# 代码块(引擎+代码块集合)
git clone git@github.com:honza/vim-snippets.git ~/.config/nvim/plugged/vim-snippets
git clone git@github.com:SirVer/ultisnips.git ~/.config/nvim/plugged/ultisnips

# 注释
git clone git@github.com:tpope/vim-commentary.git ~/.config/nvim/plugged/vim-commentary

# preservim/tagbar
git clone git@github.com:preservim/tagbar.git ~/.config/nvim/plugged/tagbar

# 显示tab缩进 
git clone git@github.com:lukas-reineke/indent-blankline.nvim.git ~/.config/nvim/plugged/indent-blankline.nvim

# 缓存当前光标信息
git clone git@github.com:ethanholz/nvim-lastplace.git ~/.config/nvim/plugged/nvim-lastplace

# 语法高亮 
git clone git@github.com:nvim-treesitter/nvim-treesitter.git ~/.config/nvim/plugged/nvim-treesitter

# 括号 
git clone git@github.com:haringsrob/nvim_context_vt.git ~/.config/nvim/plugged/nvim_context_vt

# debugger
git clone git@github.com:mfussenegger/nvim-dap.git ~/.config/nvim/plugged/nvim-dap
cd ~/.config/nvim/plugged/nvim-dap && git reset --hard f4a3be57f61893cffa1e22aa5e1e7bded495fcf2 
git clone git@github.com:theHamsta/nvim-dap-virtual-text.git ~/.config/nvim/plugged/nvim-dap-virtual-text
cd ~/.config/nvim/plugged/nvim-dap-virtual-text && git reset --hard a36982259216afd710f55bcdc220477c74b5bc35 
git clone git@github.com:rcarriga/nvim-dap-ui.git ~/.config/nvim/plugged/nvim-dap-ui
cd ~/.config/nvim/plugged/nvim-dap-ui && git reset --hard b0bc932ce6ca57bdec5536d773ab643e5b2f57ad 

# NeoVim 加速
git clone git@github.com:nathom/filetype.nvim.git ~/.config/nvim/plugged/filetype.nvim

# 
git clone git@github.com:folke/which-key.nvim.git ~/.config/nvim/plugged/which-key.nvim
git clone git@github.com:nvim-pack/nvim-spectre.git ~/.config/nvim/plugged/nvim-spectre
git clone git@github.com:folke/todo-comments.nvim.git ~/.config/nvim/plugged/todo-comments.nvim
git clone git@github.com:MattesGroeger/vim-bookmarks.git ~/.config/nvim/plugged/vim-bookmarks 
git clone git@github.com:sindrets/diffview.nvim.git ~/.config/nvim/plugged/diffview.nvim
git clone git@github.com:Pocco81/auto-save.nvim.git ~/.config/nvim/plugged/auto-save.nvim

# # python ide 
# git clone --recurse-submodules git@gitee.com:haha-web/python-mode.git ~/.config/nvim/plugged/python-mode

# 断点持久化
git clone git@github.com:Weissle/persistent-breakpoints.nvim.git ~/.config/nvim/plugged/persistent-breakpoints.nvim

# sudo file
git clone git@github.com:lambdalisue/suda.vim.git ~/.config/nvim/plugged/suda.vim

# ssh copy 
git clone git@github.com:ojroques/vim-oscyank.git ~/.config/nvim/plugged/vim-oscyank

git clone git@github.com:danymat/neogen.git ~/.config/nvim/plugged/neogen

echo "安装依赖"

os_type=`uname  -a`

if [[ $os_type =~ 'Darwin' ]];then
    echo "macOS"
    brew install ripgrep
    brew install gnu-sed 
    brew install llvm
    brew tap universal-ctags/universal-ctags
    brew install --HEAD universal-ctags
    brew install tig
    python3 -m pip install debugpy autopep8 cmakelang
    unzip -d ~/.config/nvim/data/debug/tools/ ~/.config/nvim/data/debug/codelldb-x86_64-darwin.vsix
elif [[ $os_type =~ 'Linux' ]];then
    echo "Ubuntu"
    # curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb
    sudo dpkg -i ~/.config/nvim/data/ripgrep_0.10.0_amd64.deb
    sudo apt install ctags
    sudo apt install python3-venv # coc.nvim 中的coc-jedi模块需要依赖venv
    python3 -m pip install debugpy autopep8 cmakelang
    unzip -d ~/.config/nvim/data/debug/tools/ ~/.config/nvim/data/debug/codelldb-x86_64-linux.vsix
    sudo apt install llvm
    sudo apt install tig
  else
    echo $os_type
fi

