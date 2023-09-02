"
" Thank you Bram Moolenaar!
"

call plug#begin('~/.config/nvim/plugged')

" 1. 主题
Plug 'ellisonleao/gruvbox.nvim', {'commit' : '353be59'} " 主题1
Plug 'dracula/vim', {'as' : 'dracula'} " 主题2
Plug 'kyazdani42/nvim-web-devicons' , {'commit' : '2d02a56'} " file icons (ellisonleao/gruvbox.nvim)

" 2. 文件
Plug 'nvim-tree/nvim-tree.lua', {'commit' : 'b601b5a'} " 文件树
Plug 'mhinz/vim-startify', {'commit' : '81e36c3'} " 驱动画面
Plug 'nathom/filetype.nvim', {'commit' : 'b522628'} " 加速neovim

"3. buffers
Plug 'akinsho/bufferline.nvim', {'commit' : '417b303'} " buffers
Plug 'famiu/bufdelete.nvim' , {'commit' : '8933abc'} " 关闭buffer
Plug 'windwp/windline.nvim', {'commit' : '20d628f'} " 底部状态栏美化

"4. 搜索
Plug 'nvim-telescope/telescope.nvim', {'commit' : '6258d50'} " 搜索
Plug 'nvim-lua/plenary.nvim' , {'commit' : '9ac3e95'} " 搜索 (telescope.nvim require)
Plug 'BurntSushi/ripgrep', {'commit' : '0415448'} " 搜索插件 文本查找 (telescope.nvim require)
Plug 'sharkdp/fd' , {'commit' : '072c9e5'} " 搜索插件 文件查找 (telescope.nvim require)
Plug 'kevinhwang91/nvim-hlslens', {'commit': '1b629c0c28c4c5aa7923043e00a9e388b0ad937a'}  " 搜索美化 [2/56]
Plug 'folke/todo-comments.nvim', {'commit' : '8febc60'} " todo list
Plug 'ggandor/leap.nvim', {'commit' : '98a72ad'} " 光标移动

" 6. 代码相关
Plug 'neoclide/coc.nvim', {'tag' : 'v0.0.81'} " 跳转
Plug 'jiangmiao/auto-pairs', {'commit' : '39f06b8'}  " 补全括号
Plug 'preservim/tagbar', {'commit' : 'be56353'}  " 显示class function ...
Plug 'tpope/vim-commentary', {'commit' : 'e87cd90'}  " 注释
Plug 'lukas-reineke/indent-blankline.nvim', {'commit' : 'e87cd90'}  " 缩进
Plug 'nvim-treesitter/nvim-treesitter', {'commit' : '0efa55a'}  " 代码语法高亮
Plug 'haringsrob/nvim_context_vt', {'commit' : 'e592a91'}  " 括号后提示所属条件
Plug 'lewis6991/gitsigns.nvim', {'commit' : '372d5cb'}  " git
Plug 'sindrets/diffview.nvim', {'commit' : '63720aa'}

" 7. 终端
Plug 'voldikss/vim-floaterm', {'commit' : 'ff6a871'}

" 8. 文本
Plug 'iamcco/markdown-preview.nvim', {'commit' : '02cc387', 'do' : 'cd app && yarn install'}
Plug 'ethanholz/nvim-lastplace', {'commit' : '75a2b78'}  " 缓存当前光标信息,下次重启恢复文件位置
Plug 'windwp/nvim-spectre', {'commit' : '6e5ce37'}  " 替换

" 9. 代码块
" 引擎 + 集合
" 自定义代码块: 调高优先级, 覆盖honza/vim-snippets中不满意的代码块
Plug 'SirVer/ultisnips', {'commit' : '0ad238b'}  " 引擎
Plug 'honza/vim-snippets', {'commit' : 'c7e61b7'}  " 代码块集合

" 10. debugger
Plug 'mfussenegger/nvim-dap', {'commit' : 'f4a3be57f61893cffa1e22aa5e1e7bded495fcf2'} " 基本调试
Plug 'theHamsta/nvim-dap-virtual-text', {'commit' : 'a36982259216afd710f55bcdc220477c74b5bc35'} " 显示调试
Plug 'rcarriga/nvim-dap-ui', {'commit' : 'b0bc932ce6ca57bdec5536d773ab643e5b2f57ad'} " UI,显示堆栈等

" 11. 显示快捷键
Plug 'folke/which-key.nvim', {'commit' : '4b73390'}

" 12. 书签
Plug 'MattesGroeger/vim-bookmarks', {'commit' : '9cc5fa7'}

" 13. 自动保存
Plug 'Pocco81/auto-save.nvim', {'commit' : '979b6c8'}

" 14. 断点持久化
Plug 'Weissle/persistent-breakpoints.nvim', {'commit' : 'a6091f7'}

" 16. ssh复制粘贴板
Plug 'ojroques/vim-oscyank', {'commit' : 'ffe827a'}

" 17. 添加接口注释
Plug 'danymat/neogen', {'commit' : '9c17225'}

call plug#end()

lua require("config.autocommands")
lua require("config.options")
lua require("config.plugins")
lua require("config.keymaps")

