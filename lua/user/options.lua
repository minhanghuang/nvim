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
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  laststatus = 3,            -- 全局状态栏(NeoVim0.7)
  foldmethod = "expr",       -- 折叠
  foldexpr = "nvim_treesitter#foldexpr()",
  foldenable = false,        -- 打开文件时不应用折叠
  foldlevel = 99,
  mouse = "",                -- 禁用鼠标
  writebackup = false,       -- 如果文件正在被其他程序编辑，不允许编辑
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end
