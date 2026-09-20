local config = require("user.lsp.config")

return {
  capabilities = config.capabilities,
  on_attach = config.on_attach,
  root_dir = function(bufnr, on_dir)
    local path = vim.api.nvim_buf_get_name(bufnr)
    local root = path ~= "" and vim.fs.root(path, {
      ".shuck.toml",
      "shuck.toml",
      ".git",
    }) or nil

    if not root then
      root = path ~= "" and vim.fs.dirname(path) or vim.fn.getcwd()
    end

    on_dir(root)
  end,
}
