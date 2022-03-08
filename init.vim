call plug#begin('~/.config/nvim/plugged')

Plug 'ellisonleao/gruvbox.nvim' "主题
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'akinsho/bufferline.nvim' " 窗口标签 
Plug 'neoclide/coc.nvim', {'branch': 'release'} " 函数跳转 
Plug 'luochen1990/rainbow' " 括号颜色 
Plug 'wincent/command-t'

call plug#end()


lua require("plugin/nvim-tree")
lua require("plugin/gruvbox")
lua require("plugin/bufferline")


" ***********************************
"             基本配置
" ***********************************
let mapleader="\<Space>"

set number " 显示行号 
set cursorline " 高亮所在行 
set tabstop=2 " tab 
set shiftwidth=2
set expandtab
set history=1024 " 历史记录
set backspace=indent,eol,start whichwrap+=<,>,[,]
set showcmd
set cmdheight=1 " 1 screen lines to use for the command-line
set showfulltag " show tag with function protype.
set guioptions+=b " present the bottom scrollbar when the longest visible line exceed the window
set fileencodings=utf-8,gbk2312,gbk,gb18030,cp936
set encoding=utf-8
set tenc=utf-8
syntax on
syntax enable
set autoread
set hlsearch

" ************快捷键***************
"
" nmap: 正常模式 
" vmap: 可视模式 
" imap: 插入模式 
"
nmap <C-u> 10k " 向上10行 
nmap <C-d> 10j " 向下10行

vmap >  >gv " 缩进 
vmap <  <gv " 缩进 


" ************插件***************
"
" --- 彩虹括号 ---
let g:rainbow_active = 1

" --- 文件树 ---
nmap <Leader>o :NvimTreeToggle<CR>

" --- tab窗口 ---
nmap <C-h> :BufferLineCyclePrev<CR>
nmap <C-l> :BufferLineCycleNext<CR>



