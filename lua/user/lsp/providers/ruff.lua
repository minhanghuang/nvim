local config = require("user.lsp.config")


return {
  capabilities = config.capabilities,
  on_attach = function(client, bufnr)
    -- Pyright提供更完整的Python类型和悬浮信息
    client.server_capabilities.hoverProvider = false
    config.on_attach(client, bufnr)
  end,
  init_options = {
    settings = {
      configurationPreference = "filesystemFirst",
      lineLength = 79,
    },
  },
}
