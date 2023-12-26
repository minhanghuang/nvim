local has_tokyonight, tokyonight = pcall(require, "tokyonight")
if not has_tokyonight then
  vim.notify("tokyonight.nvim not found!")
  return
end

tokyonight.setup()
