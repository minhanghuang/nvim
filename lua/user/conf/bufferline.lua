-- https://github.com/akinsho/bufferline.nvim
local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  vim.notify("bufferline not found!")
  return
end

bufferline.setup {
  options = {
    -- 使用 nvim 内置lsp
    diagnostics = "nvim_lsp",
    -- 左侧让出 nvim-tree 的位置
    offsets = { {
      filetype = "NvimTree",
      text = "File Explorer",
      highlight = "Directory",
      text_align = "left"
    } },
    close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
    buffer_close_icon = "",
    modified_icon = "🚫",
    close_icon = "",
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " "
            or (e == "warning" and " " or "")
        s = s .. n .. sym
      end
      return s
    end
  }
}
