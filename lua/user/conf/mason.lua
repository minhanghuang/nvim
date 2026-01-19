local has_mason, mason = pcall(require, "mason")
local has_lsp_config_installer, lsp_config_installer = pcall(require, "mason-lspconfig")
local has_package_installer, package_installer = pcall(require, "mason-tool-installer")

if not has_mason then
  vim.notify("mason.nvim not found!")
  return
end
if not has_lsp_config_installer then
  vim.notify("mason-lspconfig.nvim not found!")
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

lsp_config_installer.setup({
  -- Node.js version: v15.4.0
  -- 安装列表: https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
  ensure_installed = require("user.config").defaults.extensions.lsp_server,
})

package_installer.setup({
  -- issue: https://github.com/minhanghuang/nvim/issues/50
  ensure_installed = vim.tbl_flatten({
    require("user.config").defaults.extensions.formatter,
    require("user.config").defaults.extensions.linter,
    require("user.config").defaults.extensions.dap,
  })
})
