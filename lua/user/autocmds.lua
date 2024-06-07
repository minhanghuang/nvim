local function augroup(name)
  return vim.api.nvim_create_augroup("user__" .. name, { clear = true })
end

-- 注释c/cpp文件, 使用//
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("cpp_commentstring"),
  pattern = "c,cpp",
  callback = function()
    vim.api.nvim_buf_set_option(0, 'commentstring', '// %s')
  end,
})

-- 注释launch文件, 使用<!-- -->
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("launch_commentstring"),
  pattern = "launch",
  callback = function()
    vim.api.nvim_buf_set_option(0, 'commentstring', '<!-- %s -->')
  end,
})

-- 注释json文件, 使用//
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("json_commentstring"),
  pattern = "json",
  callback = function()
    vim.api.nvim_buf_set_option(0, 'commentstring', '// %s')
  end,
})

-- 注释proto文件, 使用//
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("proto_commentstring"),
  pattern = "proto",
  callback = function()
    vim.api.nvim_buf_set_option(0, 'commentstring', '// %s')
  end,
})

-- lazy.nvim安装插件完成后触发
vim.api.nvim_create_autocmd({ "User" }, {
  group = augroup("LazyComplete"),
  pattern = { "LazyInstall" },
  callback = function()
    vim.defer_fn(vim.cmd.MasonToolsInstall, 2000) --  安装Mason其他插件
  end,
})
