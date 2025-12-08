local has_spell, spell = pcall(require, "nvim-spell")
if not has_spell then
  vim.notify("nvim-spell not found!")
  return
end

spell.setup({
  enabled = true,
  spellfile = vim.fn.stdpath('config') .. '/spell/custom.en.utf-8.add',
  spelllang = { "en_us,cjk" },
})
