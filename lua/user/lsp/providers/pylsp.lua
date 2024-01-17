local config = require("user.lsp.config")

return {
  capabilities = config.capabilities,
  on_attach = config.on_attach,
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = { 'W391' },
          maxLineLength = 100
        }
      }
    }
  },
}
