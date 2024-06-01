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
        typeCheckingMode = "basic", -- 类型检查规则  [off, basic, standard, strict]
        autoImportCompletions = true,
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        extraPaths = util.get_current_python_package_paths(),
        diagnosticSeverityOverrides = {
          strictListInference = true,       -- 推断类型
          strictDictionaryInference = true, -- 推断类型
          strictSetInference = true,        -- 推断类型
          reportUnusedExpression = "none",
          reportUnusedCoroutine = "none",
          reportUnusedClass = "none",
          reportUnusedImport = "warning",
          reportUnusedFunction = "warning",
          reportUnusedVariable = "none",
          reportUnusedCallResult = "none",
          reportDuplicateImport = "warning",
          reportPrivateUsage = "warning",
          reportConstantRedefinition = "error",
          reportIncompatibleMethodOverride = "error",
          reportMissingImports = "error",
          reportUndefinedVariable = "error",
          reportAssertAlwaysTrue = "error",
        },
      },
      pythonPath = util.get_python_path(),
    }
  },
}
