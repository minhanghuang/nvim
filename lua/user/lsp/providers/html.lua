local config = require("user.lsp.config")

return {
  capabilities = config.capabilities,
  on_attach = config.on_attach,
  filetypes = { "html", "launch" }, -- add Ros launch filetype
}
