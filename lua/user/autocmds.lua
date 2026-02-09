local function augroup(name)
  return vim.api.nvim_create_augroup("user__" .. name, { clear = true })
end

-- lazy.nvim安装插件完成后触发
vim.api.nvim_create_autocmd({ "User" }, {
  group = augroup("LazyComplete"),
  pattern = { "LazyInstall" },
  callback = function()
    vim.defer_fn(vim.cmd.MasonToolsInstall, 2000) --  安装Mason其他插件
  end,
})
