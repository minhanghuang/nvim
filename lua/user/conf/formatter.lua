local has_formatter, formatter = pcall(require, "formatter")
if not has_formatter then
  vim.notify("formatter not found!")
  return
end

formatter.setup {
  filetype = {
    python = {
      require("formatter.filetypes.python").black,
      require("formatter.filetypes.python").isort
    },
    vue = {
      -- 使用默认配置
      require("formatter.filetypes.vue").prettier,
    },

    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ["*"] = {
      -- 似乎不起效果!
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
}
