vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.api.nvim_set_keymap

keymap("n", "<C-j>", "10j", { silent = true })
keymap("v", "<C-j>", "10j", { silent = true })
keymap("n", "<C-k>", "10k", { silent = true })
keymap("v", "<C-k>", "10k", { silent = true })

keymap("v", ">", ">gv", { silent = true })
keymap("v", "<", "<gv", { silent = true })

keymap("n", "<C-h>", "^", { silent = true })
keymap("n", "<C-l>", "$", { silent = true })
keymap("v", "<C-h>", "^", { silent = true })
keymap("v", "<C-l>", "$", { silent = true })

keymap("n", "<Leader><Leader>y", "\"+y", { silent = true })
keymap("n", "<Leader><Leader>p", "\"+p", { silent = true })

keymap("i", "<C-h>", "<Left>", { silent = true })
keymap("i", "<C-j>", "<Down>", { silent = true })
keymap("i", "<C-k>", "<Up>", { silent = true })
keymap("i", "<C-l>", "<Right>", { silent = true })

keymap("i", "<C-o>", "<Esc>o", { silent = true })

keymap("i", "<C-b>", "<PageUp>", { silent = true })
keymap("i", "<C-f>", "<PageDown>", { silent = true })

keymap("n", "<C-a>", "ggVG$", { silent = true })
keymap("i", "<C-a>", "<Esc>ggVG$", { silent = true })

keymap("n", "<S-Up>", ":resize -2<CR>", { silent = true })
keymap("n", "<S-Down>", ":resize +2<CR>", { silent = true })
-- keymap("n", "<S-Left>", ":vertical resize -2<CR>", { silent = true })
-- keymap("n", "<S-Right>", ":vertical resize +2<CR>", { silent = true })
-- 使用nvim-tree提供的接口, 解决重新打开窗口时, 大小重置问题
keymap("n", "<S-Left>", ":NvimTreeResize -2<CR>", { silent = true })
keymap("n", "<S-Right>", ":NvimTreeResize +2<CR>", { silent = true })
keymap("t", "<S-Up>", "<cmd>:resize +2<CR>", { silent = true })
keymap("t", "<S-Down>", "<cmd>:resize -2<CR>", { silent = true })

keymap("i", "<C-;>", "<Esc>", { silent = true })
keymap("v", "<C-;>", "<Esc>", { silent = true })
keymap("t", "<C-;>", "<C-\\><C-n>", { silent = true })

-- keymap("n", "<C-s>", "<cmd>w<CR>", { silent = true })
-- keymap("i", "<C-s>", "<cmd>w<CR>", { silent = true })
-- keymap("v", "<C-s>", "<cmd>w<CR>", { silent = true })

--- Neovim 0.10.0 stable开始<C-w>映射相应很慢, 故将其删除, 切换窗口使用原始快捷键<C-w>w
-- keymap("n", "<C-w>", "<C-w>w", { silent = true })
keymap("t", "<C-w>", "<C-\\><C-n><C-w>w", { silent = true })
keymap("n", "<C-c>", ":nohlsearch<CR>", { silent = false })
keymap("n", "<C-d>", "yyp", { silent = true })
keymap("n", "<C-f>", "*", { silent = true })

keymap("n", "o", "o<Esc>", { silent = true })

-- nvim-tree
-- <C-ww>: 切换窗口(工作区与编辑区窗口)
-- <C-v>: 垂直打开新窗口
-- type a: 新建文件/文件夹(文件夹后加下划线/)
-- type o: 打开文件/文件夹
-- type r: 修改文件名
-- type x: 剪切
-- type c: 复制
-- type p: 粘贴
-- type y: 拷贝文件名(系统剪切板)
-- type Y: 拷贝文件相对路径(系统剪切板)
-- type gy: 拷贝文件绝对路径(系统剪切板)
-- type d: 删除文件(确认)
-- type R: 刷新
-- type H: 显示/不显示 隐藏文件
keymap("n", "<Leader>o", ":NvimTreeToggle<CR>", { silent = true })
keymap("n", "<Leader><Leader>o", ":lua require('user.util').nvim_tree_find_file()<cr>", { silent = true })
keymap("n", "<Leader><Leader>r", ":lua require('user.util').nvim_tree_goto_root()<cr>", { silent = true })

-- nvim-spectre(文本替换)
--- Toggle Spectre
keymap("n", "<Leader>ss", ":lua require('spectre').toggle()<CR>", { silent = true })
--- Search current word
keymap("n", "<Leader>sw", ":lua require('spectre').open_visual({select_word=true})<CR>", { silent = true })
--- Search on current file
keymap("n", "<Leader>sp", ":lua require('spectre').open_file_search({select_word=true})<CR>", { silent = true })

-- debuggger(dap)
-- 断点
-- keymap("n", "<Leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>j", {silent = true})
-- 断点(持久化)
keymap("n", "<Leader>db", "<cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<cr>j", { silent = true })
-- 清空断点
keymap("n", "<Leader>dB", "<cmd>lua require('persistent-breakpoints.api').clear_all_breakpoints()<cr>", { silent = true })
-- 显示变量信息
keymap("n", "<Leader>de", "<cmd>lua require'dapui'.eval()<CR>", { silent = true })
-- 开始/下一个断点
keymap("n", "<Leader>dg", "<cmd>lua require'dap'.continue()<CR>", { silent = true })
-- Requests the debugee to step into a function or method if possible.
keymap("n", "<Leader>di", "<cmd>lua require'dap'.step_into()<CR>", { silent = true })
-- Requests the debugee to run again for one step.
keymap("n", "<Leader>dn", "<cmd>lua require'dap'.step_over()<CR>", { silent = true })
-- Requests the debugee to step out of a function or method if possible.
keymap("n", "<Leader>do", "<cmd>lua require'dap'.step_out()<CR>", { silent = true })
-- Steps one step back. Debug adapter must support reverse debugging.
keymap("n", "<Leader>dp", "<cmd>lua require'dap'.step_back()<CR>", { silent = true })
-- 重新运行
keymap("n", "<Leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { silent = true })
-- 运行到光标处
keymap("n", "<Leader>dc", "<cmd>lua require'dap'.run_to_cursor()<CR>", { silent = true })
-- 结束
keymap("n",
  "<Leader>dd",
  "<cmd>lua require'dap'.close()<CR><cmd>lua require'dap.repl'.close()<CR><cmd>lua require'dapui'.close()<CR><cmd>DapVirtualTextForceRefresh<CR><cmd>q<CR>"
  ,
  { silent = true }
)

-- 搜索文件
keymap("n", "<Leader>ff", ":lua require('user.util').telescope('find_files')<cr>", { silent = true })
-- 搜索字符串(所有文件)
keymap("n", "<Leader>fs", ":lua require('user.util').telescope('live_grep')<cr>", { silent = true })
-- 搜索字符串(当前打开的文件)
keymap("n", "<Leader>fj", ":lua require('user.util').telescope('live_grep', {grep_open_files = true})<cr>",
  { silent = true })
-- 搜索光标所在字符串(所有文件)
-- keymap("n", "<Leader>fa", ":lua require('user.util').telescope('grep_string')<cr>", { silent = true })
-- 搜索光标所在字符串(当前打开的文件)
-- keymap("n", "<Leader>fc", ":lua require('user.util').telescope('grep_string', {grep_open_files = true})<cr>",
-- { silent = true })
-- 搜索TODO LIST
keymap("n", "<Leader>ft", "<cmd>TodoTelescope<cr>", { silent = true })
-- 指定路径搜索文件/字符 在 ./lua/pligin/nvim-tree.lua中

-- buffers
keymap("n", "<C-n>", ":BufferLineCycleNext<CR>", { silent = true })
keymap("i", "<C-n>", "<Esc>:BufferLineCycleNext<CR>i", { silent = true })
keymap("n", "<C-p>", ":BufferLineCyclePrev<CR>", { silent = true })
keymap("i", "<C-p>", "<Esc>:BufferLineCyclePrev<CR>i", { silent = true })
keymap("n", "<Leader>fd", ":Bdelete!<CR>", { silent = true })
keymap("n", "<Leader>bmn", ":BufferLineMoveNext<CR>", { silent = true })
keymap("n", "<Leader>bmp", ":BufferLineMovePrev<CR>", { silent = true })
keymap("n", "<Leader>bb", ":BufferLineSortByDirectory<CR>", { silent = true })
keymap("n", "<Leader>bo", ":BdeleteHidden<CR>", { silent = true })

-- code-format
-- lsp格式化不支持Python
-- keymap("n", "<Leader>cf", "<cmd>lua vim.lsp.buf.format { async = true }<CR>", { silent = true })
-- keymap("n", "<Leader>cf", ":Neoformat<CR>", { silent = true })

-- git(lewis6991/gitsigns.nvim)
-- 显示当前行git提交信息
keymap("n", "<Leader>gt", ":Gitsigns toggle_current_line_blame<CR>", { silent = true })
keymap("n", "<Leader>gn", ":Gitsigns next_hunk<CR>", { silent = true })
keymap("n", "<Leader>gp", ":Gitsigns prev_hunk<CR>", { silent = true })
keymap("n", "<Leader>gs", ":Gitsigns stage_hunk<CR>", { silent = true })
keymap("n", "<Leader>gu", ":Gitsigns reset_hunk<CR>", { silent = true })
keymap("n", "<Leader>gh", ":Gitsigns preview_hunk<CR>", { silent = true })
keymap("n", "<Leader>gj", "<cmd>lua require'gitsigns'.blame_line {full=true, ignore_whitespace=true}<CR>",
  { silent = true })
-- 查看git diff
keymap("n", "<Leader>gd", "<Leader>o<CR>:DiffviewOpen HEAD~", { silent = true })
-- 退出git diff
keymap("n", "<Leader>gc", ":DiffviewClose<CR><Leader>o<CR>", { silent = true })
-- lazygit UI
keymap("n", "<Leader>gg", ":LazyGit<CR>", { silent = true })

-- terminal
keymap("t", "<Esc>", "<C-\\><C-n>", { silent = true })
-- keymap("t", "<C-n>", "<C-\\><C-n>:FloatermNext<CR>", { silent = true })
keymap("t", "<Leader>tw", "<C-\\><C-n>:FloatermNew<CR>", { silent = true })
keymap("t", "<Leader>tt", "<C-\\><C-n>:FloatermToggle<CR>", { silent = true })
keymap("n", "<Leader>tt", ":FloatermToggle<CR>", { silent = true })
keymap("t", "<Leader>tk", "<C-\\><C-n>:FloatermKill<CR>:FloatermToggle<CR>", { silent = true })

-- Markdown(iamcco/markdown-preview.nvim)
keymap("n", "<Leader>md", ":MarkdownPreview<CR>", { silent = true })

-- 注释(tpope/vim-commentary)
keymap("n", "<C-/>", "gcc<CR>", { silent = true })
keymap("i", "<C-/>", "<Esc>gcc<CR>i", { silent = true })
keymap("v", "<C-/>", "gc", { silent = true })

-- 折叠
keymap("n", "<S-c>", "zc", { silent = true })
-- 打开
keymap("n", "<S-o>", "zo", { silent = true })
-- 折叠全部
keymap("n", "<S-r>", "zR", { silent = true })
-- 打开全部
keymap("n", "<S-m>", "zM", { silent = true })

-- 书签
keymap("n", "mm", ":BookmarkToggle<CR>", { silent = true })
keymap("n", "mt", ":BookmarkAnnotate ", { silent = true })
-- keymap("n", "ma", ":BookmarkShowAll<CR>", { silent = true })
keymap("n", "mn", ":BookmarkNext<CR>", { silent = true })
keymap("n", "mp", ":BookmarkPrev<CR>", { silent = true })
keymap("n", "mc", ":BookmarkClearAll<CR>", { silent = true })
-- keymap("n", "ma", "lua require('telescope').extensions.vim_bookmarks.all()<CR>", { silent = true })
keymap("n", "ma", ":lua require('telescope').extensions.vim_bookmarks.current_file()<CR>", { silent = true })

-- inserted annotation
keymap("n", "<Leader>aa", ":lua require('neogen').generate()<CR>", { silent = true })

-- 平滑滚动 <C-m>和系统快捷键有冲突, 暂时先使用<C-S->
keymap("n", "<C-S-k>", "<Plug>(SmoothieUpwards)", { silent = true })
keymap("n", "<C-S-j>", "<Plug>(SmoothieDownwards)", { silent = true })

-- 翻译
keymap("n", "<C-t>", "<Plug>TranslateW", { silent = true })
keymap("v", "<C-t>", "<Plug>TranslateWV", { silent = true })
