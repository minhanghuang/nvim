local ok, spell = pcall(require, "nvim-spell")
if not ok then
  vim.notify("minhanghuang/spell.nvim not found!")
  return
end

spell.setup({
  config_file = vim.fn.stdpath('config') .. '/spell/cspell.json',
  dictionaries = {
    'en_us',
    'lua',
    'bash',
    'shell',
    'softwareTerms',
    'python',
    'rust',
    'typescript',
    'golang',
    'git',
    'docker',
    'npm',
    'html',
  },
  locale = 'en-US',
  check_on_save = true,
  exclude_filetypes = { 'neo-tree', 'NvimTree', 'help', 'qf' },
  diagnostic_severity = vim.diagnostic.severity.INFO,
})
