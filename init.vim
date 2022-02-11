" 基础设置
lua require('basic')
" Packer插件管理
lua require('plugins')
" 快捷键映射
lua require('keybindings')

set background=dark
colorscheme gruvbox

" 插件配置
lua require('plugin-config/nvim-tree')
lua require('plugin-config/bufferline')
lua require('plugin-config/nvim-treesitter')

" 1033 中文语言
" 2052 英文语言
augroup im_select
    autocmd!
    autocmd InsertLeave * silent !./im-select.exe 1033
    autocmd InsertEnter * silent !./im-select.exe 2052
    autocmd BufRead * silent !./im-select.exe 1033
    " autocmd CmdlineLeave * silent !./im-select.exe 1033
    " autocmd CmdlineEnter * silent !./im-select.exe 2052
augroup END
