local has_dap, dap = pcall(require, "dap")
local has_ui, ui = pcall(require, "dapui")

if not has_dap then
  vim.notify("mfussenegger/nvim-dap not found!")
  return
end
if not has_ui then
  vim.notify("rcarriga/nvim-dap-ui not found!")
  return
end

ui.setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t"
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7"),
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position.
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
        -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40,
      position = "right",
    },
    {
      elements = {
        { id = "repl",    size = 0.5 },
        { id = "console", size = 0.5 },
      },
      size = 16,
      position = "bottom",
    },
  },
  floating = {
    max_height = nil,  -- These can be integers or a float between 0 and 1.
    max_width = nil,   -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
  }
})

-- 如果开启或关闭调试，则自动打开或关闭调试界面
dap.listeners.after.event_initialized["dapui_config"] = function()
  -- 不开codelldb窗口
  ui.open()
  -- dap_ui.open("sidebar")
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  -- 只关闭侧边栏，保留底部输出窗口，方便查看 stdout/stderr
  ui.close(1)
end
dap.listeners.before.event_exited["dapui_config"] = function()
  -- 使用 <leader>dd 手动关闭保留的 REPL 和 Console
  ui.close(1)
end
