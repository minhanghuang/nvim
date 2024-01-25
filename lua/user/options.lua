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

-- 从Neovim 0.10.0开始, 支持原生OSC52, 不需要安装插件, 实现ssh远端复制粘贴功能
-- https://github.com/neovim/neovim/pull/25872
-- :h clipboard-osc52
if pcall(require, 'vim.ui.clipboard.osc52') then
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy('+'),
      ["*"] = require("vim.ui.clipboard.osc52").copy('*'),
    },
    paste = {
      -- 不允许在终端内使用系统粘贴板, 防止出现长时间等待问题
      -- Waiting for OSC 52 response from the terminal. Press Ctrl-C to interrupt...
      -- https://github.com/neovim/neovim/pull/25872#issuecomment-1808182953
      -- ["+"] = require("vim.ui.clipboard.osc52").paste('+'),
      -- ["*"] = require("vim.ui.clipboard.osc52").paste('*'),
      ["+"] = function() end,
      ["*"] = function() end,
    },
  }
end
