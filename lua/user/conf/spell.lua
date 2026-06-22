local ok, spell = pcall(require, "nvim-spell")
if not ok then
  vim.notify("minhanghuang/spell.nvim not found!")
  return
end

spell.setup({
  config_file = vim.fn.stdpath('config') .. '/spell/cspell.json',
  dictionaries = { -- https://github.com/streetsidesoftware/cspell-dicts#all-dictionaries
    'bash',
    'c',
    'cpp',
    'css',
    'docker',
    'dockerfile',
    'en_us',
    'en-gb',
    'git',
    'golang',
    'google',
    'html',
    'java',
    'lua',
    'makefile',
    'npm',
    'python',
    'redis',
    'ruby',
    'rust',
    'sql',
    'typescript',
    'vim',
  },
  locale = 'en-US',
  check_on_save = true,
  exclude_filetypes = { 'neo-tree', 'NvimTree', 'help', 'qf' },
  diagnostic_severity = vim.diagnostic.severity.INFO,
})
