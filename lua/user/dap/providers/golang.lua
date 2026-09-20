local ok, dap = pcall(require, "dap-go")
if not ok then
  vim.notify("leoluz/nvim-dap-go not found!", vim.log.levels.WARN)
  return
end

dap.setup({
  delve = {
    path = vim.fn.stdpath("data") .. "/mason/bin/dlv",
    initialize_timeout_sec = 20,
  },
})
