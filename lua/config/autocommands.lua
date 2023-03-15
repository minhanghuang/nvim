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

-- -- 解决dap连不上服务器问题(https://github.com/mfussenegger/nvim-dap/issues/717)
-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
--   pattern = "*",
--   callback = function()
--     vim.api.nvim_command("language en_US.UTF-8")
--   end,
-- })

