local has_gitsigns, gitsigns = pcall(require, "gitsigns")
if not has_gitsigns then
  vim.notify("gitsigns not found!")
  return
end

gitsigns.setup {
  signs = {
    add          = { hl = 'GitSignsAdd', text = '▊', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
    change       = { hl = 'GitSignsChange', text = '▊', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    topdelete    = { hl = 'GitSignsDelete', text = '▊', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    delete       = { hl = 'GitSignsDelete', text = '▊', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = '┃', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    untracked    = { hl = 'GitSignsUntracked', text = '┆', numhl = 'GitSignsUntracked', linehl = 'GitSignsUntrackedLn' },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false,     -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000, follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 100,
    ignore_whitespace = false,
  },
  current_line_blame_formatter_opts = {
    relative_time = false,
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  yadm = {
    enable = false,
  },
}
