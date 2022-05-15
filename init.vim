call plug#begin('~/.config/nvim/plugged') 

" 1. 主题 
Plug 'sonph/onehalf',{'rtp' : 'vim'} " 主题 1  
Plug 'ellisonleao/gruvbox.nvim' " 主题 2 
Plug 'kyazdani42/nvim-web-devicons' " file icons (ellisonleao/gruvbox.nvim)
Plug 'projekt0n/github-nvim-theme' " 主题 3  
Plug 'catppuccin/nvim', {'as': 'catppuccin'} " 主题 4 

" 2. 文件  
Plug 'kyazdani42/nvim-tree.lua' " 文件树 
Plug 'mhinz/vim-startify' " 驱动画面
Plug 'nathom/filetype.nvim' " 加速neovim 

"3. buffers 
Plug 'akinsho/bufferline.nvim' " buffers 
Plug 'famiu/bufdelete.nvim' " 关闭buffer 
Plug 'windwp/windline.nvim' " 底部状态栏美化

"4. 搜索 
Plug 'nvim-telescope/telescope.nvim' " 搜索  
Plug 'nvim-lua/plenary.nvim' " 搜索 (telescope.nvim require)  
Plug 'BurntSushi/ripgrep' " 搜索插件 文本查找 (telescope.nvim require)  
Plug 'sharkdp/fd' " 搜索插件 文件查找 (telescope.nvim require)  
Plug 'kevinhwang91/nvim-hlslens' " 搜索美化 [2/56]
Plug 'folke/todo-comments.nvim' " todo list  

" 5. 美化
Plug 'luochen1990/rainbow' " 括号颜色 
Plug 'jiangmiao/auto-pairs' " 补全括号

" 6. 代码相关
Plug 'neoclide/coc.nvim', {'branch' : 'release'} " 跳转 
Plug 'kana/vim-operator-user' " clang-format Requirements
Plug 'rhysd/vim-clang-format' " clang-format  
Plug 'preservim/tagbar' " 显示class function ...     
Plug 'tpope/vim-commentary' " 注释 
Plug 'minhanghuang/DoxygenToolkit.vim' " doxygen 
Plug 'lukas-reineke/indent-blankline.nvim' " 缩进 
Plug 'nvim-treesitter/nvim-treesitter' " 代码语法高亮 
Plug 'xiyaowong/nvim-cursorword' " 高亮与当前光标相同的词汇 
Plug 'haringsrob/nvim_context_vt' " 括号后提示所属条件 
Plug 'lewis6991/gitsigns.nvim' " git  
Plug 'sindrets/diffview.nvim' 

" 7. 终端
Plug 'voldikss/vim-floaterm'

" 8. 文本
Plug 'iamcco/markdown-preview.nvim', {'do' : 'cd app && yarn install'}
Plug 'voldikss/vim-translator' " 翻译 
Plug 'ethanholz/nvim-lastplace' " 缓存当前光标信息,下次重启恢复文件位置 
Plug 'windwp/nvim-spectre' " 替换

" 9. 代码块 
" 引擎 + 集合
" 自定义代码块: 调高优先级, 覆盖honza/vim-snippets中不满意的代码块
Plug 'SirVer/ultisnips' " 引擎 
Plug 'honza/vim-snippets' " 代码块集合

" 10. debugger 
Plug 'ravenxrz/DAPInstall.nvim' " 下载debugger
Plug 'mfussenegger/nvim-dap' " 基本调试 
Plug 'theHamsta/nvim-dap-virtual-text' " 显示调试
Plug 'rcarriga/nvim-dap-ui' " UI,显示堆栈等  

" 11. 显示快捷键
Plug 'folke/which-key.nvim'

" 12. 书签 
Plug 'MattesGroeger/vim-bookmarks' 

call plug#end()


lua require("options")
lua require("plugins")
lua require("keymaps")

