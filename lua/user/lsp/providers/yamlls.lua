local config = require("user.lsp.config")

local on_attach = function(client, bufnr)
  -- 对yaml格式化单独处理
  -- see https://github.com/redhat-developer/yaml-language-server/issues/486#issuecomment-1046792026
  client.server_capabilities.documentFormattingProvider = true
  config.on_attach(client, bufnr)
end

return {
  capabilities = config.capabilities,
  on_attach = on_attach,
  settings = {
    filetypes = { "yml", "yaml", "yaml.docker-compose" },
    yaml = {
      format = { enable = true, },
      schemas = {
        ["https://raw.githubusercontent.com/quantumblacklabs/kedro/develop/static/jsonschema/kedro-catalog-0.17.json"] =
        "conf/**/*catalog*",
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
      },
    },
  },
}
