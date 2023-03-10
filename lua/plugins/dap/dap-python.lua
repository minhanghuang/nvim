-- python3 -m pip install debugpy

local dap = require("dap")

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
      return require("dap.dap-util").str2argtable(input)
    end,
    pythonPath = function()
      return "/usr/bin/python3"
    end
  }
}
