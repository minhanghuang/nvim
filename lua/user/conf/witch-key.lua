local ok, witch_key = pcall(require, "which-key")
if not ok then
  vim.notify("folke/which-key.nvim not found!")
  return
end

witch_key.setup({
  keys = {
    scroll_down = "<C-e>", -- binding to scroll down inside the popup (vim-native line scroll)
    scroll_up = "<C-y>",   -- binding to scroll up inside the popup (vim-native line scroll)
  },
  triggers = {},           -- disable automatic trigger on <leader>; only manual <leader>? will show
})
