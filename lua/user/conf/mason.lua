local has_mason, mason = pcall(require, "mason")
local has_package_installer, package_installer = pcall(require, "mason-tool-installer")

if not has_mason then
  vim.notify("mason.nvim not found!")
  return
end
if not has_package_installer then
  vim.notify("mason-tool-installer.nvim not found!")
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

package_installer.setup({
  -- issue: https://github.com/minhanghuang/nvim/issues/50
  ensure_installed = vim.tbl_flatten({
    require("user.config").defaults.extensions.formatter,
    require("user.config").defaults.extensions.linter,
    require("user.config").defaults.extensions.dap,
  })
})
