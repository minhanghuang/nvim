local has_lspsaga, lspsaga = pcall(require, "lspsaga")

if not has_lspsaga then
  vim.notify("lspsaga not found!")
  return
end

lspsaga.setup({
  symbol_in_winbar = {
    -- 面包屑(会被context.vim插件UI覆盖)
    enable = true,
    show_file = true, -- 是否显示文件路径
  },
  lightbulb = {
    sign = false,
  },
  outline = {
    -- 显示当前缓存页面的函数列表
    -- 前提需要把开启symbols_in_winbar
    keys = {
      quit = { "<esc>", "q" },
      toggle_or_jump = { "<cr>", "o" },
    },
    layout = 'float',
    close_after_jump = true,
  },
})
