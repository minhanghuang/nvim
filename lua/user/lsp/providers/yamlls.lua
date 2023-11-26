local config = require("user.lsp.config")

return {
  capabilities = config.capabilities,
  on_attach = config.on_attach,
  settings = {
    yaml = {
      format = {
        enable = true,
      },
      schemas = {
        ["https://raw.githubusercontent.com/quantumblacklabs/kedro/develop/static/jsonschema/kedro-catalog-0.17.json"] =
        "conf/**/*catalog*",
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
      },
    },
  },
}
