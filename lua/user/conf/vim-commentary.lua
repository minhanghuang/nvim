-- 注释c/cpp文件时, 使用//
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "c,cpp",
  callback = function()
    vim.api.nvim_buf_set_option(0, 'commentstring', '// %s')
  end,
})

-- 注释launch文件时, 使用<!-- -->
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "launch",
  callback = function()
    vim.api.nvim_buf_set_option(0, 'commentstring', '<!-- %s -->')
  end,
})
