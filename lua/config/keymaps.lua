vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- ***********************************
--  vim 快捷键
--         Normal | Visual | Insert | Operator | Command
--   map:    T        T                  T
--   !map:                     T                   T
--   nmap:   T
--   vmap:            T
--   imap:                     T
--   omap:                               T
--   cmap:                                         T
--
--   default map:
--    yaw: 复制光标所在单词
--    yy: 复制当前行
--    yyP: 拷贝当前行到上一行
--    yyp: 拷贝当前行到下一行
--    ^或0: 行首
--    $: 行尾
--    s: 修改当前字母
--    S: 修改当前行
--    w: 光标移动到下一个单词开头
--    e: 光标移动到下一个单词结尾
--    b: 光标移动到前一个单词开头
--    gg: 光标移动到文件开头处
--    G: 光标移动到文件结尾处
--    dd: 剪切当前行
--    x: 删除当前字母
--    dw: 以光标为界,删除单词后半部分
--    diw: 删除光标所在单词
--    o: 当前行向下插入一空行
--    O: 当前行向上插入一空行
--    u: 撤销操作
--   <C-r>: 反撤销
--   <C-o>: 返回上一次光标所在位置
--   <C-i>: 回到上一次光标所在位置
--   <C-l>: 刷新屏幕
--   y: vmap模式,复制选中内容
--   :/ : 当前buffer搜索(n:下一个, N:上一个) <C-l>恢复屏幕
--   *: 当前BUFFER搜索光标所在单词(n:下一个,N:上一个)
--   gu: 大写转小写
--   gU: 小写转大写
--   rx: x替换当前光标所在字母
--   fx: 光标向后移动到第一个x所在位置
--   Fx: 光标向前移动到第一个x所在位置
--   :[addr]s/old/new/[option] : 替换
--     s是substitute缩写
--     [addr]:
--       "1,n":表示从第1行到n行
--       ".,$:表示从当前行到文件尾
--       "%":表示整个文件,同"1,$"
--     [option]: g c p i 省略时仅对每行第一个匹配串进行替换
--       g: global 全局替换
--       c: confirm 确认
--       p: 表示替代结果逐行显示,<C-l>恢复屏幕
--       i:ignore 不区分大小写
--     #为转义符
--
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
keymap("n", "<S-Left>", ":vertical resize -2<CR>", { silent = true })
keymap("n", "<S-Right>", ":vertical resize +2<CR>", { silent = true })
keymap("t", "<S-Up>", "<cmd>:resize +2<CR>", { silent = true })
keymap("t", "<S-Down>", "<cmd>:resize -2<CR>", { silent = true })

keymap("i", "<C-;>", "<Esc>", { silent = true })
keymap("v", "<C-;>", "<Esc>", { silent = true })
keymap("t", "<C-;>", "<C-\\><C-n>", { silent = true })

keymap("n", "<C-s>", "<cmd>w<CR>", { silent = true })
keymap("i", "<C-s>", "<cmd>w<CR>", { silent = true })
keymap("v", "<C-s>", "<cmd>w<CR>", { silent = true })

keymap("n", "<C-w>", "<C-w>w", { silent = true })
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
keymap("n", "<Leader><Leader>o", ":NvimTreeFindFile<CR>", { silent = true })

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

-- 搜索(telescope)
function _G.grep_string_the_file()
  require('telescope.builtin').grep_string({
    grep_open_files = true
  })
end

function _G.live_grep_the_file()
  require('telescope.builtin').live_grep({
    grep_open_files = true
  })
end

-- 搜索文件
keymap("n", "<Leader>ff", "<cmd>Telescope find_files<cr>", { silent = true })
-- 搜索字符串(所有文件)
keymap("n", "<Leader>fs", "<cmd>Telescope live_grep<cr>", { silent = true })
-- 搜索字符串(当前文件)
keymap("n", "<Leader>fj", "<cmd>lua _G.live_grep_the_file()<cr>", { silent = true })
-- 搜索光标所在字符串(所有文件)
keymap("n", "<Leader>fh", "<cmd>Telescope grep_string<cr>", { silent = true })
-- 搜索光标所在字符串(当前文件)
keymap("n", "<Leader>fc", "<cmd>lua _G.grep_string_the_file()<cr>", { silent = true })
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

-- tagbar(preservim/tagbar)
keymap("n", "<Leader><Tab>", ":TagbarToggle<CR>", { silent = true })

-- 括号归属(haringsrob/nvim_context_vt)
keymap("n", "<Leader>vt", ":NvimContextVtToggle<CR>", { silent = true })

-- code-format
keymap("n", "<Leader>cf", ":call CocActionAsync('format')<CR>", { silent = true })

-- git(lewis6991/gitsigns.nvim)
-- 显示当前行git提交信息
keymap("n", "<Leader>gt", ":Gitsigns toggle_current_line_blame<CR>", { silent = true })
keymap("n", "<Leader>gn", ":Gitsigns next_hunk<CR>", { silent = true })
keymap("n", "<Leader>gp", ":Gitsigns prev_hunk<CR>", { silent = true })
keymap("n", "<Leader>gs", ":Gitsigns stage_hunk<CR>", { silent = true })
keymap("n", "<Leader>gu", ":Gitsigns reset_hunk<CR>", { silent = true })
keymap("n", "<Leader>gh", ":Gitsigns preview_hunk<CR>", { silent = true })
-- 查看git diff
keymap("n", "<Leader>gd", "<Leader>o<CR>:DiffviewOpen HEAD~", { silent = true })
-- 退出git diff
keymap("n", "<Leader>gc", ":DiffviewClose<CR><Leader>o<CR>", { silent = true })

-- terminal
keymap("t", "<Esc>", "<C-\\><C-n>", { silent = true })
-- keymap("t", "<C-n>", "<C-\\><C-n>:FloatermNext<CR>", { silent = true })
keymap("t", "<Leader>tw", "<C-\\><C-n>:FloatermNew<CR>", { silent = true })
keymap("t", "<Leader>tt", "<C-\\><C-n>:FloatermToggle<CR>", { silent = true })
keymap("n", "<Leader>tt", ":FloatermToggle<CR>", { silent = true })
keymap("t", "<Leader>tk", "<C-\\><C-n>:FloatermKill<CR>:FloatermToggle<CR>", { silent = true })

-- 翻译(voldikss/vim-translator)
keymap("n", "<Leader>tr", ":Translate<CR>", { silent = true })

-- Markdown(iamcco/markdown-preview.nvim)
keymap("n", "<Leader>md", ":MarkdownPreview<CR>", { silent = true })

-- 注释(tpope/vim-commentary)
keymap("n", "<C-/>", "gcc<CR>", { silent = true })
keymap("i", "<C-/>", "<Esc>gcc<CR>i", { silent = true })
keymap("v", "<C-/>", "gc", { silent = true })

-- 函数跳转(coc.nvim)
function _G.show_docs()
  local cw = vim.fn.expand('<cword>')
  if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
    vim.api.nvim_command('h ' .. cw)
  elseif vim.api.nvim_eval('coc#rpc#ready()') then
    vim.fn.CocActionAsync('doHover')
  else
    vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
  end
end

-- 显示变量类型 或 函数接口文档
keymap("n", "<Leader>cs", "<cmd>lua _G.show_docs()<CR>", { silent = true })
-- 下(上)一个报错的位置
keymap("n", "<Leader>-", "<Plug>(coc-diagnostic-prev)", { silent = true })
keymap("n", "<Leader>=", "<Plug>(coc-diagnostic-next)", { silent = true })
-- keymap("n", "<Leader>gw", "<Plug>(coc-diagnostic-next)", term_{silent = true})
-- 跳转函数定义(实现)
keymap("n", "<Leader>cd", "<Plug>(coc-definition)", { silent = true })
keymap("n", "<Leader>ci", "<Plug>(coc-implementation)", { silent = true })
-- 列出函数被引用的位置
keymap("n", "<Leader>cr", "<Plug>(coc-references)", { silent = true })
-- 重新命名变量
keymap("n", "<Leader>cn", "<Plug>(coc-rename)", { silent = true })
-- 自动修复当前行的报错
keymap("n", "<Leader>ce", "<Plug>(coc-fix-current)", { silent = true })
-- 翻译
keymap("n", "<Leader>ct", "<Plug>(coc-translator-p)", { silent = true })
keymap("v", "<C-t>", "<Plug>(coc-translator-pv)", { silent = true })
-- 单词校验
keymap("n", "<Leader>ss", "<Plug>(coc-codeaction-selected)<CR>", { silent = true })

-- coc version: 0.82.0
-- keymap("i", "<C-j>", [[coc#pum#visible() ? coc#pum#next(1) : "<Down>"]], expr_{silent = true})
-- keymap("i", "<C-k>", [[coc#pum#visible() ? coc#pum#prev(1) : "<Up>"]], expr_{silent = true})
-- keymap("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "<CR>"]], expr_{silent = true})

-- 替换(windwp/nvim-spectre)
-- 全文替换-当前光标所在单词
keymap("n", "<Leader>rw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", { silent = true })
-- 替换当前文件
keymap("n", "<Leader>r", "viw:lua require('spectre').open_file_search()<CR>", { silent = true })
-- -- 任意替换
-- keymap("n", "<Leader>a", "<cmd>lua require('spectre').open()<CR>", {silent = true})
-- -- 全文替换
-- keymap("n", "<Leader>c", "<cmd>lua require('spectre').open_visual()<CR>", {silent = true})

-- which-key
keymap("n", "<Leader>h", ":WhichKey W <CR>", { silent = true })

-- flod
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
keymap("n", "ma", ":BookmarkShowAll<CR>", { silent = true })
keymap("n", "mn", ":BookmarkNext<CR>", { silent = true })
keymap("n", "mp", ":BookmarkPrev<CR>", { silent = true })
keymap("n", "mc", ":BookmarkClearAll<CR>", { silent = true })

-- inserted annotation
keymap("n", "<Leader>aa", ":lua require('neogen').generate()<CR>", { silent = true })

-- leap
keymap("n", "f", "<Plug>(leap-forward-to)", { silent = true })
keymap("n", "F", "<Plug>(leap-backward-to)", { silent = true })
