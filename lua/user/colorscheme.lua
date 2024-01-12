return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    branch = "main",
  },
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    commit = "353be59",
    name = "gruvbox",
    priority = 1000,
    config = function()
      local g_config = require("user.config")
      require("user.themes.tokyonight")
      require("user.themes.catppuccin")
      require("user.themes.gruvbox")
      local theme_ok, _ = pcall(vim.cmd, "colorscheme " .. g_config.defaults.theme)
      if not theme_ok then
        vim.notify("colorscheme " .. g_config.defaults.theme .. " not found!")
        return
      end
    end,
  }
}
