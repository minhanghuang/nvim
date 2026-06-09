local options = {
  backup = false,       -- 不创建备份文件
  number = true,        -- set numbered lines
  cursorline = true,    -- highlight the current line
  shiftwidth = 2,       -- the number of spaces inserted for each indentation
  expandtab = true,     -- convert tabs to spaces
  tabstop = 2,          -- Number of spaces tabs count for
  termguicolors = true, -- set term gui colors (most terminals support this)
  history = 1024,
  showcmd = true,
  showmatch = true,
  showfulltag = true,
  ruler = true,
  autoread = true,
  hlsearch = true,
  ignorecase = true, -- 在搜索模式中忽略大小写
  -- noignorecase = true;
  cmdheight = 1,     -- 保持状态栏位置接近底部，状态栏的高度为1
  encoding = "utf-8",
  fileencodings = "utf-8,gbk2312,gbk,gb18030,cp936",
  clipboard = "unnamedplus",                    -- allows neovim to access the system clipboard
  laststatus = 3,                               -- 全局状态栏(NeoVim0.7)
  ttimeoutlen = 10,
  updatetime = 300,                             -- Faster completion (4000ms default)
  smoothscroll = false,                         -- 平滑滚动
  foldmethod = "expr",                          -- 折叠
  -- foldexpr = "nvim_treesitter#foldexpr()",
  foldexpr = "v:lua.vim.treesitter.foldexpr()", -- 使用Lua版本的foldexpr，性能更好
  foldenable = false,                           -- 打开文件时不应用折叠
  foldlevel = 99,
  foldminlines = 1,                             -- 最小折叠行数
  foldnestmax = 20,                             -- 最大折叠层级
  mouse = "",                                   -- 禁用鼠标
  writebackup = false,                          -- 如果文件正在被其他程序编辑，不允许编辑
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end
