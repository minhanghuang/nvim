local ok, lastplace = pcall(require, "nvim-lastplace")
if not ok then
  vim.notify("ethanholz/nvim-lastplace not found!")
  return
end

lastplace.setup({
  -- 那些 buffer 类型不记录光标位置
  lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
  -- 那些文件类型不记录光标位置
  lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
  lastplace_open_folds = true
})
