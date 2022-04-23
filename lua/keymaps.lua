local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", ";", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
--       ".,$":表示从当前行到文件尾
--       "%":表示整个文件,同"1,$"
--     [option]: g c p i 省略时仅对每行第一个匹配串进行替换 
--       g: global 全局替换
--       c: confirm 确认 
--       p: 表示替代结果逐行显示,<C-l>恢复屏幕
--       i:ignore 不区分大小写
--     #为转义符
--
keymap("n", "<C-j>", "10j", opts)
keymap("v", "<C-j>", "10j", opts)
keymap("n", "<C-k>", "10k", opts)
keymap("v", "<C-k>", "10k", opts)

keymap("v", ">", ">gv", opts)
keymap("v", "<", "<gv", opts)

keymap("i", "<C-u>", "<Home>", opts)
keymap("i", "<C-d>", "<End>", opts)

keymap("n", "<Leader><Leader>y", "\"+y", opts)
keymap("n", "<Leader><Leader>p", "\"+p", opts)

keymap("i", "<C-h>", "<Left>", opts)
keymap("i", "<C-j>", "<Down>", opts)
keymap("i", "<C-k>", "<Up>", opts)
keymap("i", "<C-l>", "<Right>", opts)

keymap("i", "<C-o>", "<Esc>o", opts)

keymap("i", "<C-b>", "<PageUp>", opts)
keymap("i", "<C-f>", "<PageDown>", opts)

keymap("n", "<C-a>", "ggVG$", opts)
keymap("i", "<C-a>", "<Esc>ggVG$", opts)

keymap("n", "<Leader>=", ":vertical resize +2<CR>", opts)
keymap("n", "<Leader>-", ":vertical resize -2<CR>", opts)


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
keymap("n", "<Leader>o", ":NvimTreeToggle<CR>", opts)
keymap("n", "<Leader><Leader>o", ":NvimTreeFindFile<CR>", opts)

-- debuggger(dap) 
keymap("n", "<Leader>du", "<cmd>lua require'dapui'.toggle()<CR>", opts)
keymap("n", "<Leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
keymap("n", "<F5>", "<cmd>lua require'dap'.continue()<CR>", opts)
keymap("n", "<F6>", "<cmd>lua require'dap'.step_into()<CR>", opts)
keymap("n", "<F7>", "<cmd>lua require'dap'.step_over()<CR>", opts)
keymap("n", "<F8>", "<cmd>lua require'dap'.step_out()<CR>", opts)
keymap("n", "<F9>", "<cmd>lua require'dap'.run_last()<CR>", opts)
keymap("n",
  "<F10>", 
  "<cmd>lua require'dap'.close()<CR><cmd>lua require'dap.repl'.close()<CR><cmd>lua require'dapui'.close()<CR><cmd>DapVirtualTextForceRefresh<CR>", 
  opts
)

-- 搜索(telescope) 
keymap("n", "<Leader>ff", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<Leader>fg", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<Leader>fb", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<Leader>fh", "<cmd>Telescope help_tags<cr>", opts)

-- buffers
keymap("n", "<C-n>", ":BufferLineCycleNext<CR>", opts)
keymap("i", "<C-n>", "<Esc>:BufferLineCycleNext<CR>i", opts)
keymap("n", "<C-p>", ":BufferLineCyclePrev<CR>", opts)
keymap("i", "<C-p>", "<Esc>:BufferLineCyclePrev<CR>i", opts)
keymap("n", "<Leader>fd", ":Bdelete!<CR>", opts)

-- 注释 
-- keymap("n", "<C-]>", "gcc<CR>", opts)
-- keymap("i", "<C-]>", "<Esc>gcc<CR>i", opts)
-- keymap("v", "<C-]>", "gc", opts)

-- tagbar(preservim/tagbar)
keymap("n", "<Leader><Tab>", ":TagbarToggle<CR>", opts)


