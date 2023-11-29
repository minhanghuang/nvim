local has_formatter, formatter = pcall(require, "formatter")
if not has_formatter then
  vim.notify("formatter not found!")
  return
end

formatter.setup {
  filetype = {
    python = {
      function()
        return {
          exe = "autopep8",
          args = {
            "--in-place --aggressive --aggressive",
          },
          stdin = false
        }
      end
    },
    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
}
