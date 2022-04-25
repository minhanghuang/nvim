require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  -- keymaps = {
  --   noremap = true,
  --   ['n <Leader>gn'] = { expr = true, "&diff ? ']h' : '<cmd>Gitsigns next_hunk<CR>'"},
  --   ['n <Leader>gp'] = { expr = true, "&diff ? '[h' : '<cmd>Gitsigns prev_hunk<CR>'"},
  --   ['n <leader>gs'] = '<cmd>Gitsigns stage_hunk<CR>',
  --   ['n <leader>gu'] = '<cmd>Gitsigns undo_stage_hunk<CR>',
  --   ['n <leader>gh'] = '<cmd>Gitsigns preview_hunk<CR>',
  --   ['n <leader>gb'] = '<cmd>Gitsigns toggle_current_line_blame<CR>',
  -- },
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
}

