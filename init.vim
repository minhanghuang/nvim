call plug#begin('~/.config/nvim/plugged') 

" 1. 主题 
Plug 'ellisonleao/gruvbox.nvim' " 主题
Plug 'kyazdani42/nvim-web-devicons' " file icons (ellisonleao/gruvbox.nvim)

" 2. 文件  
Plug 'nvim-tree/nvim-tree.lua' " 文件树
Plug 'mhinz/vim-startify' " 驱动画面
Plug 'nathom/filetype.nvim' " 加速neovim

"3. buffers 
Plug 'akinsho/bufferline.nvim', {'commit' : '46255e4a76c4fb450a94885527f5e58a7d96983c'} " buffers
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
Plug 'neoclide/coc.nvim', {'tag' : 'v0.0.81'} " 跳转
Plug 'preservim/tagbar' " 显示class function ...
Plug 'tpope/vim-commentary' " 注释 
Plug 'lukas-reineke/indent-blankline.nvim' " 缩进
Plug 'nvim-treesitter/nvim-treesitter' " 代码语法高亮
Plug 'haringsrob/nvim_context_vt' " 括号后提示所属条件
Plug 'lewis6991/gitsigns.nvim' " git
Plug 'sindrets/diffview.nvim'
Plug 'sbdchd/neoformat' " 格式化代码
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'kevinhwang91/promise-async'
Plug 'kevinhwang91/nvim-ufo'

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
Plug 'mfussenegger/nvim-dap', {'commit' : 'f4a3be57f61893cffa1e22aa5e1e7bded495fcf2'} " 基本调试
Plug 'theHamsta/nvim-dap-virtual-text', {'commit' : 'a36982259216afd710f55bcdc220477c74b5bc35'} " 显示调试
Plug 'rcarriga/nvim-dap-ui', {'commit' : 'b0bc932ce6ca57bdec5536d773ab643e5b2f57ad'} " UI,显示堆栈等

" 11. 显示快捷键
Plug 'folke/which-key.nvim'

" 12. 书签 
Plug 'MattesGroeger/vim-bookmarks' 

" 13. 自动保存
Plug 'Pocco81/auto-save.nvim'

" 14. 断点持久化
Plug 'Weissle/persistent-breakpoints.nvim'

" 15. 编辑需要sudo的文件
Plug 'lambdalisue/suda.vim'


call plug#end()

lua require("options")
lua require("plugins")
lua require("keymaps")

