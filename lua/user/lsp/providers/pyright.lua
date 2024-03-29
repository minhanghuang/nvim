local util = require('user.util')
local config = require("user.lsp.config")

return {
  capabilities = config.capabilities,
  on_attach = config.on_attach,
  settings = {
    pyright = {
      disableLanguageServices = false,
      disableOrganizeImports = false
    },
    python = {
      -- https://microsoft.github.io/pyright/#/configuration?id=main-configuration-options
      analysis = {
        typeCheckingMode = "off",
        autoImportCompletions = true,
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        extraPaths = util.get_current_python_package_paths(),
      },
      pythonPath = util.get_python_path(),
    }
  },
}
