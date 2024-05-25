if vim.version().major >= 0 and vim.version().minor >= 9 then
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

require("nvim-treesitter.configs").setup({
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
}
)
