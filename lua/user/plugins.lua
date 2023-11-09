local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

-- 1. 主题
Plug('ellisonleao/gruvbox.nvim', {commit = '353be59'})
Plug('dracula/vim', {as = 'dracula'})
Plug('kyazdani42/nvim-web-devicons', {commit = '2d02a56'}) --  file icons (ellisonleao/gruvbox.nvim)

-- 2. 文件

Plug('nvim-tree/nvim-tree.lua', {commit = 'b601b5a'}) --  文件树
Plug('mhinz/vim-startify', {commit = '81e36c3'}) --  驱动画面
Plug('nathom/filetype.nvim', {commit = 'b522628'}) --  加速neovim

-- 3. buffers
Plug('akinsho/bufferline.nvim', {commit = '417b303'}) --  buffers
Plug('famiu/bufdelete.nvim', {commit = '8933abc'}) --  关闭buffer
Plug('windwp/windline.nvim', {commit = '20d628f'}) --  底部状态栏美化

-- 4. 搜索
Plug('nvim-telescope/telescope.nvim', {commit = '6258d50'})
Plug('nvim-lua/plenary.nvim', {commit = '9ac3e95'})
Plug('BurntSushi/ripgrep', {commit = '0415448'})
Plug('sharkdp/fd', {commit = '072c9e5'})
Plug('kevinhwang91/nvim-hlslens', {commit = '1b629c0c28c4c5aa7923043e00a9e388b0ad937a'})
Plug('folke/todo-comments.nvim', {commit = '8febc60'})
Plug('ggandor/leap.nvim', {commit = '98a72ad'})

-- 6. 代码相关
Plug('neoclide/coc.nvim', {tag = 'v0.0.81'})
Plug('jiangmiao/auto-pairs', {commit = '39f06b8'})
Plug('preservim/tagbar', {commit = 'be56353'})
Plug('tpope/vim-commentary', {commit = 'e87cd90'})
Plug('lukas-reineke/indent-blankline.nvim', {commit = '4541d69'})
Plug('nvim-treesitter/nvim-treesitter', {commit = '0efa55a'})
Plug('haringsrob/nvim_context_vt', {commit = 'e592a91'})
Plug('lewis6991/gitsigns.nvim', {commit = '372d5cb'})
Plug('sindrets/diffview.nvim', {commit = '63720aa'})

-- 7. 终端
Plug('voldikss/vim-floaterm', {commit = 'ff6a871'})

--  8. 文本
Plug('iamcco/markdown-preview.nvim', {commit = '02cc387', ['do']= 'cd app && yarn install'})
Plug('ethanholz/nvim-lastplace', {commit = '75a2b78'})
Plug('windwp/nvim-spectre', {commit = '6e5ce37'})

--  9. 代码块
--  引擎 + 集合
--  自定义代码块: 调高优先级, 覆盖honza/vim-snippets中不满意的代码块
Plug('SirVer/ultisnips', {commit = '0ad238b'})
Plug('honza/vim-snippets', {commit = 'c7e61b7'})

--  10. debugger
Plug('mfussenegger/nvim-dap', {commit = 'f4a3be57f61893cffa1e22aa5e1e7bded495fcf2'})
Plug('theHamsta/nvim-dap-virtual-text', {commit = 'a36982259216afd710f55bcdc220477c74b5bc35'})
Plug('rcarriga/nvim-dap-ui', {commit = 'b0bc932ce6ca57bdec5536d773ab643e5b2f57ad'})

--  11. 显示快捷键
Plug('folke/which-key.nvim', {commit = '4b73390'})

--  12. 书签
Plug('MattesGroeger/vim-bookmarks', {commit = '9cc5fa7'})

--  13. 自动保存
Plug('Pocco81/auto-save.nvim', {commit = '979b6c8'})

--  14. 断点持久化
Plug('Weissle/persistent-breakpoints.nvim', {commit = 'a6091f7'})

--  16. ssh复制粘贴板
Plug('ojroques/vim-oscyank', {commit = 'ffe827a'})

--  17. 添加接口注释
Plug('danymat/neogen', {commit = '9c17225'})

--  平滑滚动
Plug('psliwka/vim-smoothie')

vim.call('plug#end')
