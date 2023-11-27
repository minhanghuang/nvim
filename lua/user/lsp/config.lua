local M = {}

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true -- 函数补全参数

--- 代码格式化, 由于不是所有语言的lsp都支持formatting, 所有需要对这些语言使用插件格式化
function FormatCode()
  local file_type = vim.api.nvim_buf_get_option(0, 'filetype')

  -- 如果是 Python 文件，使用 neoformat
  if file_type == 'python' then
    -- vim.cmd('Neoformat') -- sbdchd/neoformat
    vim.cmd("FormatWrite") -- mhartington/formatter.nvim
  else
    -- lsp不提供格式化Python方法
    -- 否则使用 LSP 的格式化
    vim.lsp.buf.format { async = true }
  end
end

--- 配置快捷键
---@param bufnr
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
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

  -- 查看函数说明
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ch", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

  -- 跳转到下一个错误
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>-", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>',
    opts)

  -- 跳转到上一个错误
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>=", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>',
    opts)
end

--- 光标所在的函数会高亮
---@param client
local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end


local on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
  -- require "lsp_signature".on_attach()
end

M.flags = {
  debounce_text_changes = 150,
}

M.capabilities = capabilities
M.on_attach = on_attach

return M
