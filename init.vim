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

"3. buffers 
Plug 'akinsho/bufferline.nvim' " buffers 
Plug 'famiu/bufdelete.nvim' " 关闭buffer 
Plug 'windwp/windline.nvim' " 底部状态栏美化
Plug 'lewis6991/gitsigns.nvim' " 底部状态栏美化(获取git数据)

"4. 搜索 
Plug 'nvim-telescope/telescope.nvim' " 搜索  
Plug 'nvim-lua/plenary.nvim' " 搜索 (telescope.nvim require)  
Plug 'BurntSushi/ripgrep' " 搜索插件 文本查找 (telescope.nvim require)  
Plug 'sharkdp/fd' " 搜索插件 文件查找 (telescope.nvim require)  
Plug 'kevinhwang91/nvim-hlslens' " 搜索美化 [2/56]

" 5. 美化
Plug 'luochen1990/rainbow' " 括号颜色 
Plug 'jiangmiao/auto-pairs' " 补全括号
Plug 'rcarriga/nvim-notify' " 消息通知

" 6. 代码相关
Plug 'neoclide/coc.nvim', {'branch' : 'release'} " 跳转 
Plug 'kana/vim-operator-user' " clang-format Requirements
Plug 'rhysd/vim-clang-format' " clang-format  
Plug 'airblade/vim-gitgutter' " git   
Plug 'preservim/tagbar' " 显示class function ...     
Plug 'tpope/vim-commentary' " 注释 
Plug 'minhanghuang/DoxygenToolkit.vim' " doxygen 
Plug 'lukas-reineke/indent-blankline.nvim' " 缩进 
Plug 'nvim-treesitter/nvim-treesitter' " 代码语法高亮 
Plug 'xiyaowong/nvim-cursorword' " 高亮与当前光标相同的词汇 
Plug 'haringsrob/nvim_context_vt' " 括号后提示所属条件 

" 7. 终端
Plug 'voldikss/vim-floaterm'

" 8. 文本
Plug 'iamcco/markdown-preview.nvim', {'do' : 'cd app && yarn install'}
Plug 'ianva/vim-youdao-translater' " 有道翻译 
Plug 'voldikss/vim-translator' " 翻译 
Plug 'ethanholz/nvim-lastplace' " 缓存当前光标信息,下次重启恢复文件位置 

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

call plug#end()


" ***********************************
"  vim 基本配置
" ***********************************
let mapleader="\<Space>"

lua require("options")
lua require("keymaps")
" ***********************************
"  neovim 插件 
" ***********************************
"
" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"   插件: 主题 
" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
" 主题1: sonph/onehalf
" syntax on
" set t_Co=256
" set cursorline
" colorscheme onehalfdark
" let g:airline_theme='onehalfdark'

"  主题2: ellisonleao/gruvbox.nvim
set termguicolors
colorscheme gruvbox

" 主题3
" projekt0n/github-nvim-theme
" colorscheme github_dimmed 

" 主题 4 
" colorscheme catppuccin 
" lua require("plugin/catppuccin")


" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"   插件: debugger 
" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
lua require("dap/nvim-dap-ui")
lua require("dap/nvim-dap-virtual-text")
lua require("dap/nvim-dap")

" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"   插件: 括号 
" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
" luochen1990/rainbow 
let g:rainbow_active = 1

" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"   插件: 高亮与当前光标相同的词汇 
" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
" 
" disable highlighting for some filetypes
let g:cursorword_disable_filetypes = []
" min width of word
let g:cursorword_min_width = 3
" max width of word
let g:cursorword_max_width = 50

" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"   插件: 搜索美化 
" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
lua require("plugin/nvim-hlslens")

" " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
" "   插件: cmake 
" " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
" lua require("plugin/neovim-cmake")

" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"   插件: 语法高亮
" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

lua require("plugin/nvim-treesitter")

" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"   插件: 光标会停留在上次编辑时的位置 
" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
" 
lua require("plugin/nvim-lastplace")

" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"   插件: 显示tab缩进 
" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"
lua require("plugin/indent-blankline")

" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"   插件: 状态栏美化  
" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
" 
lua require("plugin/windline") 
lua require("plugin/gitsigns") 

" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"   插件: 括号后提示所属条件  
" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"
lua require("plugin/nvim_context_vt") 

" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"   插件: 文件树
" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
" kyazdani42/nvim-tree.lua
lua require("plugin/nvim-tree")
lua require("plugin/nvim-web-devicons")


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
lua require("plugin/bufferline")


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
" nmap <Leader>fs :Lines 
" nmap <Leader>s :Lines 
" " 在当前目录搜索文件
" nmap <silent> <Leader>ff :Files<CR>
" " 切换Buffers中的文件
" nmap <silent> <Leader>fb :Buffers<CR>
" " 在Vim打开的历史文件中搜索 
" " nmap <silent> <Leader>fh :History<CR>
" " 查看git graph 
" nmap <silent> <Leader>fg :Commits<CR>
" " - down / up / left / right
" " let g:fzf_layout = { 'up': '~25%' }
" let g:fzf_preview_window = ['right:50%','ctrl-/']
" " let  g:fzf_preview_window =  []
" " Customize fzf colors to match your color scheme
" let g:fzf_colors =
" \ { 'fg' : [ 'fg', 'Normal' ],
"   \ 'bg' : [ 'bg', 'Normal' ],
"   \ 'hl' : [ 'fg', 'Comment' ],
"   \ 'fg+' : [ 'fg', 'CursorLine', 'CursorColumn', 'Normal' ],
"   \ 'bg+' : [ 'bg', 'CursorLine', 'CursorColumn' ],
"   \ 'hl+' : [ 'fg', 'Statement' ],
"   \ 'info' : [ 'fg', 'PreProc' ],
"   \ 'border' : [ 'fg', 'Ignore' ],
"   \ 'prompt' : [ 'fg', 'Conditional' ],
"   \ 'pointer' : [ 'fg', 'Exception' ],
"   \ 'marker' : [ 'fg', 'Keyword' ],
"   \ 'spinner' : [ 'fg', 'Label' ],
"   \ 'header' : [ 'fg', 'Comment' ] }
" " 递归搜索当前目录
" " :Rg <keyword> 
" " 需要安装 ripgrep https://github.com/BurntSushi/ripgrep
" " fzf#vim#with_preview('up:60%','ctrl-/') 设置预览窗口, up:预览窗口位于上方, C-/ 切换预览窗口(显示不显示)
" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
"   \   <bang>0 ? fzf#vim#with_preview('up:60%','ctrl-/') 
"   \           : fzf#vim#with_preview('right:50%', 'ctrl-/'),
"   \   <bang>0)

" 搜索 2
" lua require("plugin/telescope")
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

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
" nmap <C-p> <PPluglug>MarkdownPreviewToggle
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

