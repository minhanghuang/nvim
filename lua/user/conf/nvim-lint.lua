local has_lint, lint = pcall(require, "lint")
if not has_lint then
  vim.notify("nvim-lint not found!")
  return
end

lint.linters_by_ft = {
  -- 不支持[*]匹配所有文件(https://github.com/mfussenegger/nvim-lint/issues/355#issuecomment-1759203127)
  -- cpp = { "cspell" },
  cmake = { "cmakelint" },
  markdown = { "markdownlint" },
}

-- -- cspell
-- -- https://github.com/streetsidesoftware/cspell
-- lint.linters.cspell.args = {
--   "lint",
--   "--no-color",
--   "--no-progress",
--   "--no-summary",
--   "--config",
--   vim.fn.expand(vim.fn.stdpath("config") .. "/spell/cspell/cspell.json"),
-- }

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
  group = vim.api.nvim_create_augroup('lint', { clear = true }),
  callback = function()
    lint.try_lint()
    -- lint.try_lint("cspell") -- 所有文件检查拼写
  end,
})
