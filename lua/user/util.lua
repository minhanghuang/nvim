local M = {}

-- telescope
---@param builtin string
---@param opts telescope.opts
M.telescope = function(builtin, opts)
  require("telescope.builtin")[builtin](opts)
end

-- format
M.format_code = function()
  local file_type = vim.api.nvim_buf_get_option(0, 'filetype')
  -- 如果是下面这些文件, 使用第三方插件进行格式化
  if 'python' == file_type or 'vue' == file_type then
    -- vim.cmd('Neoformat') -- sbdchd/neoformat
    vim.cmd("FormatWrite") -- mhartington/formatter.nvim
  else
    -- 否则使用 LSP 的格式化
    vim.lsp.buf.format { async = true }
  end
end

return M
