local has_nvim_treesitter, nvim_treesitter = pcall(require, "nvim-treesitter.configs")
if not has_nvim_treesitter then
  vim.notify("nvim-treesitter not found!")
  return
end

if vim.version().major >= 0 and vim.version().minor >= 9 then
  -- issues: https://github.com/minhanghuang/nvim/issues/46
  vim.filetype.add {
    extension = { -- 一个将文件扩展名映射到文件类型的表
      xodr = "html",
      launch = "html",
      json = "jsonc",
      rviz = "yaml",
    },
    -- filename = {}, -- 一个将文件路径模式映射到文件类型的表
    -- pattern = {}, -- 一个将文件名映射到文件类型的表
  }
  -- Neovim version: 0.9+
  vim.treesitter.language.register("html", "xodr")
  vim.treesitter.language.register("html", "launch")
  vim.treesitter.language.register("jsonc", "json")
  vim.treesitter.language.register("yaml", "rviz")
else
  local ft_to_parser = require "nvim-treesitter.parsers".filetype_to_parsername
  ft_to_parser.xodr = "html"
  ft_to_parser.launch = "html"
  ft_to_parser.json = "jsonc"
  ft_to_parser.rviz = "yaml"
end

local g_config = require("user.config")

nvim_treesitter.setup({
  -- 安装的高亮支持来源
  -- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
  -- ensure_installed = "maintained",
  ensure_installed = g_config.defaults.extensions.treesitter,
  -- 同步下载高亮支持
  sync_install = false,
  -- 高亮相关
  highlight = {
    -- 启用高亮支持
    enable = true,
    -- 使用 treesitter 高亮而不是 neovim 内置的高亮
    additional_vim_regex_highlighting = false
  },
  -- 启用增量选择
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<C-g>',
      node_incremental = '<C-g>',
      node_decremental = '<BS>',
      scope_incremental = '<TAB>',
    }
  },
})
