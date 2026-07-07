local ok, autosave = pcall(require, "auto-save")
if not ok then
  vim.notify("Pocco81/auto-save.nvim not found!")
  return
end

autosave.setup({
  enabled = true,
  execution_message = {
    message = function() -- message to print on save
      return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
    end,
    dim = 0.18,               -- dim the color of `message`
    cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
  },
  events = { "InsertLeave", "TextChanged" },
  conditions = {
    exists = true,
    filename_is_not = { "plugins.lua" },
    filetype_is_not = {},
    modifiable = true
  },
  write_all_buffers = false,
  on_off_commands = true,
  clean_command_line_interval = 0,
  debounce_delay = 135
})
