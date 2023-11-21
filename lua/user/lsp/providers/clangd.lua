local config = require("user.lsp.config")

return {
  capabilities = config.capabilities,
  on_attach = config.on_attach,
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#clangd
  cmd = {
    "clangd",
    "--background-index", -- 后台建立索引，并持久化到disk
    "--completion-style=detailed",
    "--cross-file-rename=true",
    "--header-insertion=iwyu",
    "--pch-storage=memory",
    -- 启用这项时，补全函数时，将会给参数提供占位符，键入后按 Tab 可以切换到下一占位符
    "--function-arg-placeholders=true",
    "--log=verbose",
    "--ranking-model=decision_forest",
    -- 输入建议中，已包含头文件的项与还未包含头文件的项会以圆点加以区分
    "--header-insertion-decorators",
    "-j=12",
    "--pretty",
  }
}
