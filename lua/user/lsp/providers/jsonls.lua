local config = require("user.lsp.config")

return {
  capabilities = config.capabilities,
  on_attach = config.on_attach,
  settings = {
    json = {
      format = { enable = true },
      validate = { enable = true },
      schemas = require('schemastore').json.schemas(),
    },
  },

  -- 标准json没有注释功能(Comments are not permitted in JSON.)
  handlers = {
    ["textDocument/publishDiagnostics"] = function(_, result, ...)
      result.diagnostics = vim.tbl_filter(function(t)
        return t.code ~= 521
      end, result.diagnostics)
      return vim.lsp.diagnostic.on_publish_diagnostics(_, result, ...)
    end,
  },

  setup = {
    filetypes = { "json", "jsonc", "json5" },
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
        end,
      },
    },
  },
}
