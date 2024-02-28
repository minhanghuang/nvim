local has_dap, dap = pcall(require, "dap")
if not has_dap then
  vim.notify("dap not found!")
  return
end

-- https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(gdb-via--vscode-cpptools)
local path = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7"

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = "executable",
  command = path,
}

local configurations = {
  -- launch exe
  {
    name = "Launch file(best)",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    args = function()
      local input = vim.fn.input("Input args: ")
      return require("user.dap.util").str2argtable(input)
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
    setupCommands = {
      {
        description = 'enable pretty printing',
        text = '-enable-pretty-printing',
        ignoreFailures = false
      },
    },
  },
  -- attach process
  {
    name = "Attach process",
    type = "cppdbg",
    request = "attach",
    processId = require('dap.utils').pick_process,
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = "${workspaceFolder}",
    setupCommands = {
      {
        description = 'enable pretty printing',
        text = '-enable-pretty-printing',
        ignoreFailures = false
      },
    },
  },
  -- attach server
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description = 'enable pretty printing',
        ignoreFailures = false
      },
    },
  },
}

dap.configurations.c = configurations
dap.configurations.cpp = configurations
dap.configurations.rust = configurations
