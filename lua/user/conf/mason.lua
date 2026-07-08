local has_mason, mason = pcall(require, "mason")
if not has_mason then
  vim.notify("mason-org/mason.nvim not found!")
  return
end

local has_installer, installer = pcall(require, "mason-tool-installer")
if not has_installer then
  vim.notify("WhoIsSethDaniel/mason-tool-installer.nvim not found!")
  return
end


mason.setup({
  ui = {
    icons = require("user.config").defaults.icons.mason
  },
  registries = {
    "github:mason-org/mason-registry",
  },
  log_level = vim.log.levels.INFO,
})

installer.setup({
  -- issue: https://github.com/minhanghuang/nvim/issues/50
  ensure_installed = vim.iter({
    require("user.config").defaults.extensions.formatter,
    require("user.config").defaults.extensions.linter,
    require("user.config").defaults.extensions.dap,
  }):flatten():totable(),
})
