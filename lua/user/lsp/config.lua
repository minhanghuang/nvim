local M = {}

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true -- 函数补全参数

function FormatCode()
  local file_type = vim.api.nvim_buf_get_option(0, 'filetype')

  -- 如果是 Python 文件，使用 neoformat
  if file_type == 'python' then
    vim.cmd('Neoformat')
  else
    -- lsp不提供格式化Python方法
    -- 否则使用 LSP 的格式化
    vim.lsp.buf.format { async = true }
  end
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }

  -- 格式化
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cf", "<cmd>lua FormatCode()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cf", "<cmd>lua vim.lsp.buf.format { async = true }<CR>", opts)

  -- 跳转到函数定义
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)

  -- 跳转到声明
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ci", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)

  -- 跳转到引用
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)

  -- 代码优化
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ce", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

  -- 修改变量名
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cc", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

  -- 查看函数说明
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ch", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

  -- 跳转到下一个错误
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>-", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>',
    opts)

  -- 跳转到上一个错误
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>=", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>',
    opts)
end

local on_attach = function(_, bufnr)
  lsp_keymaps(bufnr)
  require "lsp_signature".on_attach()
end

M.flags = {
  debounce_text_changes = 150,
}

M.capabilities = capabilities
M.on_attach = on_attach

return M
