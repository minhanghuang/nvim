vim.g.startify_custom_footer = { '', "   请帮助使用这台电脑的可怜儿童！", '' }

vim.g.startify_lists = {
  {
    type = 'sessions',
    header = { '   会话列表：' },
  },
  {
    type = 'dir',
    header = { '   当前目录 [ ' .. vim.fn.getcwd() .. ' ]：' },
  },
  {
    type = 'files',
    header = { '   最近使用：' },
  },
  {
    type = 'bookmarks',
    header = { '   书签列表：' },
  },
  {
    type = 'commands',
    header = { '   命令列表：' },
  },
}

vim.api.nvim_exec([[
  augroup VimStartify
    autocmd User Startified nmap <buffer> o <plug>(startify-open-buffers)
  augroup END
]], true)

