call plug#begin('~/.config/nvim/plugged')

" 1. 主题 
Plug 'sonph/onehalf', { 'rtp': 'vim' } " 主题 
Plug 'ellisonleao/gruvbox.nvim' "主题
Plug 'kyazdani42/nvim-web-devicons' " file icons (ellisonleao/gruvbox.nvim)

" 2. 最近文件
Plug 'mhinz/vim-startify' " 驱动画面

" 3. 文件显示
Plug 'kyazdani42/nvim-tree.lua' " 文件树 
Plug 'akinsho/bufferline.nvim' " 窗口标签 

" 4. 美化
Plug 'luochen1990/rainbow' " 括号颜色 

" 5. 代码相关
Plug 'neoclide/coc.nvim', {'branch': 'release'} " 函数跳转 
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " 搜索 
Plug 'junegunn/fzf.vim' " 搜索 

" 6. 终端
Plug 'voldikss/vim-floaterm'

" 7. 文本
" --- markdown 1
" Plug 'godlygeek/tabular' " The tabular plugin must come before vim-markdown.
" Plug 'preservim/vim-markdown' 
" ---
" --- markdown 2
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" 8. 代码块 
" 引擎 + 集合
" 自定义代码块: 调高优先级, 覆盖honza/vim-snippets中不满意的代码块
Plug 'SirVer/ultisnips' " 引擎 
Plug 'honza/vim-snippets' " 代码块集合

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

" 自动补全 
imap ( ()<Esc>i
imap [ []<Esc>i
imap { {}<Esc>i
imap < <><Esc>i

" 插入模式下, 移动到行首
imap <C-u> <Home>
" 插入模式下, 移动到行尾
imap <C-d> <End>


"----------------------------------------------------------
"                    插件: 括号
"----------------------------------------------------------
" -------- 彩虹括号 ---
let g:rainbow_active = 1

" =========================================================

"----------------------------------------------------------
"                    插件: 主题
"----------------------------------------------------------
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

" =========================================================

"----------------------------------------------------------
"                    插件: 终端
"----------------------------------------------------------
" 打开新终端 
nmap <silent> <Leader>t :FloatermNew<CR>
tnoremap <silent> <Leader>t <C-\><C-n>:FloatermNew<CR>
" 终端位置 
let g:floaterm_position = 'bottomright'
" 终端宽(0,1)
let g:floaterm_width = 0.6
" 终端高(0,1)
let g:floaterm_height = 0.4
" 终端标题
" let g:floaterm_title = 'floaterm: $1/$2'

" =========================================================

"----------------------------------------------------------
"                    插件: 文件树 
"----------------------------------------------------------
" https://github.com/kyazdani42/nvim-tree.lua
nmap <Leader>o :NvimTreeToggle<CR>

" default mappings
" type a: 新建文件
" type o: 打开文件/文件夹
" type r: 修改文件名 
" type y: 拷贝文件名(系统剪切板)
" type Y: 拷贝文件相对路径(系统剪切板)
" type gy: 拷贝文件绝对路径(系统剪切板)
" type d: 删除文件(确认)
" type R: 刷新
" type H: 显示/不显示 隐藏文件

" =========================================================

"----------------------------------------------------------
"                    插件: 窗口buffers 
"----------------------------------------------------------
nmap <C-h> :BufferLineCyclePrev<CR>
nmap <C-l> :BufferLineCycleNext<CR>

" =========================================================

"----------------------------------------------------------
"                    插件: 搜索 
"----------------------------------------------------------
" 在当前目录搜索文件
nmap <silent> <Leader>f :Files<CR>
" 切换Buffers中的文件
nmap <silent> <Leader>b :Buffers<CR>
" 在Vim打开的历史文件中搜索 
nmap <silent> <Leader>h :History<CR>
" 查看git graph 
nmap <silent> <Leader>g :Commits<CR>

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~25%' }

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

" =========================================================

"----------------------------------------------------------
"                    插件: markdown 
"----------------------------------------------------------
" --插件1-- 
" 启动视图
nmap <Leader>m <Plug>MarkdownPreview
" nmap <M-s> <Plug>MarkdownPreviewStop
" nmap <C-p> <Plug>MarkdownPreviewToggle

" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" =========================================================

"----------------------------------------------------------
"                    插件: 跳转 
"----------------------------------------------------------
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

" =========================================================


