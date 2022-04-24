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
lua require("plugins")
lua require("keymaps")


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
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


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
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_browser = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
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
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'
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
nmap <silent> <Leader>ta <Plug>Translate
vmap <silent> <Leader>ta <Plug>TranslateV
nmap <silent> <Leader>taw <Plug>TranslateW
vmap <silent> <Leader>taw <Plug>TranslateWV


" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"   插件: Doxygen 
" @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
" vim-scripts/DoxygenToolkit.vim
let g:DoxygenToolkit_authorName="huangminhang@trunk.tech" 
" 函数信息 
nmap <Leader>dd :Dox<CR>

