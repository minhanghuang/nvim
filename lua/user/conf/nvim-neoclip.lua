local ok, neoclip = pcall(require, "neoclip")
if not ok then
  vim.notify("AckslD/nvim-neoclip.lua not found!")
  return
end

local has_sqlite = require('user.util').has_sqlite()
local db_path
if has_sqlite then
  db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3"
end

neoclip.setup({
  enable_persistent_history = has_sqlite,
  db_path = db_path,
  default_register = { '"+', '"*' },
  keys = {
    telescope = {
      i = {
        select = '<CR>',
        -- paste = 'p',
        paste_behind = 'P', -- 占位,避免<c-k>冲突
        -- replay = 'q', -- replay a macro
        -- delete = 'd', -- delete an entry
        -- edit = 'e',   -- edit an entry
        -- custom = {},
      },
      n = {
        select = '<CR>',
        -- paste = 'p',
        paste_behind = 'P', -- 占位,避免<c-k>冲突
        -- replay = 'q',
        -- delete = 'd',
        -- edit = 'e',
        -- custom = {},
      },
    },
  },
})

-- Since we need to load after telescope, it should be safe to call this here
require('telescope').load_extension('neoclip')
