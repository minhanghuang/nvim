call plug#begin('~/.config/nvim/plugged')

" 1. 主题 
Plug 'sonph/onehalf',{'rtp' : 'vim'} 
Plug 'ellisonleao/gruvbox.nvim' "主题
Plug 'kyazdani42/nvim-web-devicons' " file icons (ellisonleao/gruvbox.nvim)

" 2. 最近文件
Plug 'mhinz/vim-startify' " 驱动画面

" 3. 文件显示
Plug 'kyazdani42/nvim-tree.lua' " 文件树 
" Plug 'akinsho/bufferline.nvim' " buffers 1 类似VSCode的tag 
Plug 'vim-airline/vim-airline' " buffers 2 条形tag 
Plug 'vim-airline/vim-airline-themes' " buffers 2 

" 4. 美化
Plug 'luochen1990/rainbow' " 括号颜色 
Plug 'jiangmiao/auto-pairs' " 补全括号

" 5. 代码相关
Plug 'neoclide/coc.nvim', {'branch' : 'release'} " 跳转 
Plug 'junegunn/fzf',{'dir' : '~/.fzf', 'do' : './install --all'}
Plug 'junegunn/fzf.vim' " 搜索插件1 
Plug 'kana/vim-operator-user' " clang-format Requirements
Plug 'rhysd/vim-clang-format' " clang-format  
" Plug 'tpope/vim-fugitive' " git   
Plug 'airblade/vim-gitgutter' " git   
" Plug 'puremourning/vimspector' " debugger graph    
Plug 'preservim/tagbar' " 显示class function ...     
Plug 'tpope/vim-commentary' " 注释 
Plug 'minhanghuang/DoxygenToolkit.vim' " doxygen 

" 6. 终端
Plug 'voldikss/vim-floaterm'

" 7. 文本
Plug 'iamcco/markdown-preview.nvim', {'do' : 'cd app && yarn install'}
Plug 'ianva/vim-youdao-translater' " 有道翻译 
Plug 'voldikss/vim-translator' " 翻译 

" 8. 代码块 
" 引擎 + 集合
" 自定义代码块: 调高优先级, 覆盖honza/vim-snippets中不满意的代码块
Plug 'SirVer/ultisnips' " 引擎 
Plug 'honza/vim-snippets' " 代码块集合

call plug#end()


" ***********************************
"  vim 基本配置
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
set ignorecase " 不区分大小写 
" set noignorecase " 区分大小写 
syntax on " 语法检测
syntax enable

" ***********************************
"  vim 快捷键
"         Normal | Visual | Insert | Operator | Command 
"   map:    T        T                  T               
"   !map:                     T                   T               
"   nmap:   T   
"   vmap:            T  
"   imap:                     T      
"   omap:                               T          
"   cmap:                                         T          
"
"   default map:
"    yy: 复制当前行
"    yyP: 拷贝当前行到上一行 
"    yyp: 拷贝当前行到下一行
"    ^或0: 行首
"    $: 行尾
"    s: 修改当前字母
"    S: 修改当前行
"    w: 光标移动到下一个单词开头
"    e: 光标移动到下一个单词结尾
"    b: 光标移动到前一个单词开头
"    gg: 光标移动到文件开头处
"    G: 光标移动到文件结尾处
"    dd: 剪切当前行
"    x: 删除当前字母
"    dw: 以光标为界,删除单词后半部分 
"    diw: 删除光标所在单词
"    o: 当前行向下插入一空行
"    O: 当前行向上插入一空行
"    u: 撤销操作
"   <C-r>: 反撤销
"   <C-o>: 返回上一次光标所在位置
"   <C-i>: 回到上一次光标所在位置
"   <C-l>: 刷新屏幕
"   y: vmap模式,复制选中内容
"   :/ : 当前buffer搜索(n:下一个, N:上一个) <C-l>恢复屏幕 
"   *: 当前BUFFER搜索光标所在单词(n:下一个,N:上一个)
"   gu: 大写转小写 
"   gU: 小写转大写 
"   rx: x替换当前光标所在字母  
"   fx: 光标向后移动到第一个x所在位置   
"   Fx: 光标向前移动到第一个x所在位置   
"   :[addr]s/old/new/[option] : 替换 
"     s是substitute缩写
"     [addr]: 
"       "1,n":表示从第1行到n行
"       ".,$":表示从当前行到文件尾
"       "%":表示整个文件,同"1,$"
"     [option]: g c p i 省略时仅对每行第一个匹配串进行替换 
"       g: global 全局替换
"       c: confirm 确认 
"       p: 表示替代结果逐行显示,<C-l>恢复屏幕
"       i:ignore 不区分大小写
"     #为转义符
" ***********************************
" 光标移动 向上10行/向下10行 
nmap <c-u> 10k 
nmap <c-d> 10j 
" 缩进 
vmap >  >gv 
vmap <  <gv  
" 插入模式, 移动到行首/行尾 
imap <C-u> <Home>
imap <C-d> <End>
" 复制当前选中到系统剪切板
vmap <leader><leader>y "+y
" 将系统剪切板内容粘贴到vim
nmap <leader><leader>p "+p
" 插入模式移动光标 
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
" 插入模式, 当前行向下插入一空行
imap <C-o> <Esc>o
" 插入模式, 翻页 
imap <C-b> <PageUp>
imap <C-f> <PageDown>
" 全选 
nmap <C-a> ggvG 
imap <C-a> <Esc>ggvG 


" ***********************************
"  neovim 插件 
" ***********************************
"
" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"   插件: 主题 
" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"  主题1: ellisonleao/gruvbox.nvim
set termguicolors
set background=dark " or light if you want light mode
let g:gruvbox_bold=1
let g:gruvbox_italic=1
let g:gruvbox_transparent_bg=1
let g:gruvbox_underline=1
let g:gruvbox_undercurl=1
let g:gruvbox_termcolors=256
colorscheme gruvbox
" 主题2: sonph/onehalf
" syntax on
" set t_Co=256
" set cursorline
" colorscheme onehalfdark
" let g:airline_theme='onehalfdark'

" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"   插件: 括号 
" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
" luochen1990/rainbow 
let g:rainbow_active = 1


" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"   插件: 文件树
" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
" kyazdani42/nvim-tree.lua
" <C-ww>: 切换窗口(工作区与编辑区窗口)
" <C-v>: 垂直打开新窗口
" type a: 新建文件/文件夹(文件夹后加下划线/)
" type o: 打开文件/文件夹
" type r: 修改文件名 
" type y: 拷贝文件名(系统剪切板)
" type Y: 拷贝文件相对路径(系统剪切板)
" type gy: 拷贝文件绝对路径(系统剪切板)
" type d: 删除文件(确认)
" type R: 刷新
" type H: 显示/不显示 隐藏文件
lua require("plugin/nvim-tree")
" 打开/关闭 文件树
nmap <silent> <Leader>o :NvimTreeToggle<CR> 
" 定位当前buffer在文件树的位置
nmap <silent> <Leader><Leader>o :NvimTreeFindFile<CR> 


" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"   插件: tagbar 
" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
" preservim/tagbar
" 需要安装ctag库 https://github.com/universal-ctags/ctags
" macos: brew tap universal-ctags/universal-ctags
"        brew install --HEAD universal-ctags
" Ubuntu: sudo apt install ctags 
nmap <silent> <Leader><Tab> :TagbarToggle<CR>


" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"   插件: buffers窗口 
" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
" akinsho/bufferline.nvim
" lua require("plugin/bufferline")
" 循环切换tag窗口 
" nmap <C-h> :BufferLineCyclePrev<CR>
" nmap <C-l> :BufferLineCycleNext<CR>

" vim-airline/vim-airline 
" next buffer 
nmap <silent> <C-n> :bn<CR>
imap <silent> <C-n> <Esc>:bn<CR>i
nmap <silent> <C-p> :bp<CR>
imap <silent> <C-p> <Esc>:bp<CR>i
" close current buffer 
nmap <silent> <Leader>bd :NvimTreeToggle<CR>:bd<CR>:NvimTreeToggle<CR>
set ambiwidth=double " 显示全角符号 
let g:airline_theme="light" " 主题 
let g:airline_powerline_fonts = 1 " tag箭头  
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'


" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"   插件: 终端 <Leader>t(x)  
" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
" voldikss/vim-floaterm
" 下一个terminal windows
tnoremap <silent> <C-n> <C-\><C-n>:FloatermNext<CR>
" 回到Normal模式,方便查看Terminal信息 
tnoremap <silent> <Esc> <C-\><C-n>
" 新建terminal windows
let g:floaterm_keymap_new = '<Leader>tw'
" 切换terminal模式
let g:floaterm_keymap_toggle = '<Leader>tt'
" 关闭当前terminal windows Or <C-d> 
" let g:floaterm_keymap_kill = '<Leader>tk'
" 终端窗口类型 
" let g:floaterm_wintype = 'split'
" let g:floaterm_position = 'botright'
let g:floaterm_wintype = 'float'
let g:floaterm_position = 'center'
" 终端宽(0,1)
let g:floaterm_width = 0.6
" 终端高(0,1)
let g:floaterm_height = 0.4
" 终端标题
let g:floaterm_title = 'floaterm: $1/$2'


" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"   插件: 搜索 
" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
" junegunn/fzf.vim
" 在所有buffers搜索字符
nmap <Leader>fs :Lines 
nmap <Leader>s :Lines 
" 在当前目录搜索文件
nmap <silent> <Leader>ff :Files<CR>
" 切换Buffers中的文件
nmap <silent> <Leader>fb :Buffers<CR>
" 在Vim打开的历史文件中搜索 
" nmap <silent> <Leader>fh :History<CR>
" 查看git graph 
nmap <silent> <Leader>fg :Commits<CR>
" - down / up / left / right
" let g:fzf_layout = { 'up': '~25%' }
let g:fzf_preview_window = ['right:50%','ctrl-/']
" let  g:fzf_preview_window =  []
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg' : [ 'fg', 'Normal' ],
  \ 'bg' : [ 'bg', 'Normal' ],
  \ 'hl' : [ 'fg', 'Comment' ],
  \ 'fg+' : [ 'fg', 'CursorLine', 'CursorColumn', 'Normal' ],
  \ 'bg+' : [ 'bg', 'CursorLine', 'CursorColumn' ],
  \ 'hl+' : [ 'fg', 'Statement' ],
  \ 'info' : [ 'fg', 'PreProc' ],
  \ 'border' : [ 'fg', 'Ignore' ],
  \ 'prompt' : [ 'fg', 'Conditional' ],
  \ 'pointer' : [ 'fg', 'Exception' ],
  \ 'marker' : [ 'fg', 'Keyword' ],
  \ 'spinner' : [ 'fg', 'Label' ],
  \ 'header' : [ 'fg', 'Comment' ] }
" 递归搜索当前目录
" :Rg <keyword> 
" 需要安装 ripgrep https://github.com/BurntSushi/ripgrep
" fzf#vim#with_preview('up:60%','ctrl-/') 设置预览窗口, up:预览窗口位于上方, C-/ 切换预览窗口(显示不显示)
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%','ctrl-/') 
  \           : fzf#vim#with_preview('right:50%', 'ctrl-/'),
  \   <bang>0)


" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"   插件: 跳转
" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
" neoclide/coc.nvim
" 启动vim自动安装coc.xxx语言插件
let g:coc_global_extensions = ['coc-json','coc-css','coc-clangd','coc-cmake','coc-git','coc-yaml','coc-sh','coc-highlight','coc-markdownlint','coc-snippets','coc-emmet','coc-html','coc-jedi']
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" Remap keys for gotos
" 跳转到函数定义
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
" 哪些地方调用了该函数  
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window
" nnoremap <silent> K :call <SID>show_documentation()<CR>
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


" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"   插件: 注释  
" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
" tpope/vim-commentary 
" 注释单行 
nmap <C-]> gcc<CR>
imap <C-]> <Esc>gcc<CR>i
" 注释单行/多行 
vmap <C-]> gc
" C和C++的文件使用 // 注释 (默认是/**/)
autocmd FileType c,cpp setlocal commentstring=//\ %s


" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"   插件: git 
" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
" airblade/vim-gitgutter 
function! GitGutterNextHunkCycle()
  let line = line('.')
    GitGutterNextHunk
  if line('.') == line
    1
    GitGutterNextHunk
  endif
endfunction

function! GitGutterPrevHunkCycle()
  let line = line('.')
  " silent! GitGutterPrevHunk
    GitGutterPrevHunk
  if line('.') == line
    normal! G
    GitGutterPrevHunk
  endif
endfunction

function! NextHunkAllBuffers()
  let line = line('.')
  GitGutterNextHunk
  if line('.') != line
    return
  endif

  let bufnr = bufnr('')
  while 1
    bnext
    if bufnr('') == bufnr
      return
    endif
    if !empty(GitGutterGetHunks())
      1
      GitGutterNextHunk
      return
    endif
  endwhile
endfunction

function! PrevHunkAllBuffers()
  let line = line('.')
  GitGutterPrevHunk
  if line('.') != line
    return
  endif

  let bufnr = bufnr('')
  while 1
    bprevious
    if bufnr('') == bufnr
      return
    endif
    if !empty(GitGutterGetHunks())
      normal! G
      GitGutterPrevHunk
      return
    endif
  endwhile
endfunction
" 当前所有buffers的上/下一块(循环)
nmap <silent> <Leader>gbn :call NextHunkAllBuffers()<CR>
nmap <silent> <Leader>gbp :call PrevHunkAllBuffers()<CR>
" 当前buffer的上/下一块(循环)
nmap <silent> <Leader>gn :call GitGutterNextHunkCycle()<CR>
nmap <silent> <Leader>gp :call GitGutterPrevHunkCycle()<CR>
" 保存当前块到stage(local->stage)
nmap <Leader>gs <Plug>(GitGutterStageHunk)
" 撤销当前块(local->cancel undo)
nmap <Leader>gu <Plug>(GitGutterUndoHunk)
" 查看当前块之前的代码 
nmap <Leader>gh <Plug>(GitGutterPreviewHunk)
" 显示块号 1/3 
let g:gitgutter_show_msg_on_hunk_jumping = 1
" 查看以前代码使用悬浮窗口
let g:gitgutter_preview_win_floating = 1
" 高亮行 
" let g:gitgutter_highlight_lines = 1
" 高亮行号 
let g:gitgutter_highlight_linenrs = 1
" 不使用gitgutter默认的快捷键映射
let g:gitgutter_map_keys = 0


" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"   插件: markdown
" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
" markdown1: iamcco/markdown-preview.nvim
" 启动视图
nmap <Leader>m <Plug>MarkdownPreview
" nmap <M-s> <Plug>MarkdownPreviewStop
" nmap <C-p> <Plug>MarkdownPreviewToggle
" set to 1, nvim will open the preview window after entering the markdown buffer default: 0
let g:mkdp_auto_start = 0
" set to 1, the nvim will auto close current preview window when change from markdown buffer to another buffer default: 1
let g:mkdp_auto_close = 1
" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or move the cursor default: 0
let g:mkdp_refresh_slow = 0
" set to 1, the MarkdownPreview command can be use for all files, by default it can be use in markdown file default: 0
let g:mkdp_command_for_global = 0
" set to 1, preview server available to others in your network by default, the server listens on localhost (127.0.0.1) default: 0
let g:mkdp_open_to_the_world = 0
" use custom IP to open preview page useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9 default empty
let g:mkdp_open_ip = ''
" specify browser to open preview page default: ''
let g:mkdp_browser = ''
" set to 1, echo preview page url in command line when open preview page default is 0
let g:mkdp_echo_preview_url = 0
" a custom vim function name to open preview page this function will receive url as param default is empty
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
" preview page title ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'
" recognized filetypes these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']


" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"   插件: 翻译 <Leader>t(x) 
" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
" ianva/vim-youdao-translater
vnoremap <silent> <Leader>ty :<C-u>Ydv<CR>
nnoremap <silent> <Leader>ty :<C-u>Ydc<CR>
noremap <leader>tyd :<C-u>Yde<CR>
"
" voldikss/vim-translator
let g:translator_target_lang = 'zh'
let g:translator_source_lang = 'auto'
let g:translator_default_engines = ['youdao', 'haici']
let g:translator_window_type = 'popup'
let g:translator_window_max_width = 0.6
let g:translator_window_max_height = 0.6
 " Echo translation in the cmdline
nmap <silent> <Leader>ta <Plug>Translate
vmap <silent> <Leader>ta <Plug>TranslateV
" Display translation in a window
nmap <silent> <Leader>taw <Plug>TranslateW
vmap <silent> <Leader>taw <Plug>TranslateWV
" Replace the text with translation
" nmap <silent> <Leader>r <Plug>TranslateR
" vmap <silent> <Leader>r <Plug>TranslateRV
" Translate the text in clipboard
" nmap <silent> <Leader>x <Plug>TranslateX


" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"   插件: Doxygen 
" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
" vim-scripts/DoxygenToolkit.vim
let g:DoxygenToolkit_authorName="huangminhang@trunk.tech" 
" 函数信息 
nmap <Leader>dd :Dox<CR>

" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"   插件: clang-format
" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
" rhysd/vim-clang-format
" :ClangFormat 
"   正常模式下使用: 整个代码将被格式化
"   可视模式下使用: 被选中的代码将被格式化

