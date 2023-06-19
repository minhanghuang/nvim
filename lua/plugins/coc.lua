vim.g.coc_global_extensions = {
  'coc-vetur', -- vue
  'coc-sumneko-lua@3.6.17',
  'coc-json',
  'coc-css@1.3.0',
  'coc-clangd@0.25.0',
  'coc-cmake',
  'coc-yaml',
  'coc-sh',
  'coc-highlight@1.3.0',
  'coc-markdownlint',
  'coc-snippets',
  'coc-emmet',
  'coc-html',
  'coc-pyright',
  'coc-translator',
  'coc-xml',
  'coc-spell-checker', -- 单词校验
}

-- <C-j> <C-k> 冲突
vim.g.coc_snippet_prev = '<S-j>'
vim.g.coc_snippet_next = '<S-k>'
