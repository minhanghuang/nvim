call plug#begin('~/.config/nvim/plugged')

" 1. 主题 
Plug 'ellisonleao/gruvbox.nvim' "主题
Plug 'sonph/onehalf', { 'rtp': 'vim' } " 主题 
Plug 'kyazdani42/nvim-web-devicons' " for file icons

" 2. 最近文件
Plug 'mhinz/vim-startify' " 驱动画面

" 3. 文件显示
Plug 'kyazdani42/nvim-tree.lua'
Plug 'akinsho/bufferline.nvim' " 窗口标签 

" 4. 美化
Plug 'luochen1990/rainbow' " 括号颜色 

" 5. 代码相关
Plug 'neoclide/coc.nvim', {'branch': 'release'} " 函数跳转 
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " 搜索 
Plug 'junegunn/fzf.vim' " 搜索 

" 6. 终端
" Plug 'skywind3000/vim-terminal-help' " terminal
Plug 'voldikss/vim-floaterm'

call plug#end()


lua require("plugin/nvim-tree")
lua require("plugin/bufferline")

" ***********************************
"             基本配置
" ***********************************
let mapleader="\<Space>"

set number " 显示行号
" set relativenumber " 相对行号 
set cursorline " 高亮所在行 
set tabstop=2 " tab
set shiftwidth=2
set expandtab
set history=1024 " 历史记录
set backspace=indent,eol,start whichwrap+=<,>,[,]
set showcmd
set showmatch " 高亮匹配括号
set cmdheight=1 " 1 screen lines to use for the command-line
set showfulltag " show tag with function protype.
set guioptions+=b " present the bottom scrollbar when the longest visible line exceed the window
set fileencodings=utf-8,gbk2312,gbk,gb18030,cp936
set encoding=utf-8
set tenc=utf-8
set ruler "显示最后一行的状态
set autoread
set hlsearch
syntax on " 语法检测
syntax enable

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
" -------- 彩虹括号 ---
"
let g:rainbow_active = 1

" -------- 主题 ---
"
"  主题 1
set termguicolors
set background=dark " or light if you want light mode
colorscheme gruvbox
" 主题 2
" syntax on
" set t_Co=256
" set cursorline
" colorscheme onehalfdark
" let g:airline_theme='onehalfdark'


" -------- terminal ---
" 
" 打开新终端 
nmap <silent> <Leader>n :FloatermNew<CR>
tnoremap <silent> <Leader>n <C-\><C-n>:FloatermNew<CR>
" 终端位置 
let g:floaterm_position = 'bottomright'
" 终端宽(0,1)
let g:floaterm_width = 0.6
" 终端高(0,1)
let g:floaterm_height = 0.4

" -------- 文件树 ---
"
nmap <Leader>o :NvimTreeToggle<CR>

" -------- tab窗口 ---
"
nmap <C-h> :BufferLineCyclePrev<CR>
nmap <C-l> :BufferLineCycleNext<CR>

" -------- fzf ---
"
" 在当前目录搜索文件
nmap <silent> <Leader>f :Files<CR>
" 切换Buffers中的文件
nmap <silent> <Leader>b :Buffers<CR>
" 在Vim打开的历史文件中搜索 
nmap <silent> <Leader>h :History<CR>

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" -------- 函数跳转 coc.nvim --- 
"
" GoTo code navigation.
let g:coc_global_extensions = ['coc-json','coc-css','coc-clangd','coc-cmake','coc-git','coc-yaml','coc-sh','coc-highlight','coc-markdownlint','coc-snippets','coc-emmet','coc-html','coc-jedi']

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>



