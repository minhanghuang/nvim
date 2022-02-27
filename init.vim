call plug#begin('~/.config/nvim/plugged')

Plug 'ellisonleao/gruvbox.nvim' "主题
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'akinsho/bufferline.nvim'
" Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'luochen1990/rainbow'

call plug#end()

lua require("basic")

lua require("plugin/nvim-tree")
lua require("plugin/gruvbox")
lua require("plugin/bufferline")

lua require("keybindings")
