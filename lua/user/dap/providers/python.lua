-- python3 -m pip install debugpy
local status_ok, dap = pcall(require, "dap")
if not status_ok then
  vim.notify("dap not found!")
  return
end

dap.adapters.python = {
  type = "executable",
  command = "python3",
  args = { "-m", "debugpy.adapter" }
}

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    args = function()
      local input = vim.fn.input("Input args: ")
      return require("user.dap.dap-util").str2argtable(input)
    end,
    pythonPath = function()
      return "/usr/bin/python3"
    end
  }
}
