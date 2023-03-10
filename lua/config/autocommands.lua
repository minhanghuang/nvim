vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "*",
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "c,cpp",
  callback = function()
    vim.api.nvim_buf_set_option(0, 'commentstring', '// %s')
  end,
})

