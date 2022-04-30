
return {
  adapters = {
      id = "cppdbg",
      type = "executable",
      -- command = "/Users/cox/work/cpptools-osx/extension/debugAdapters/bin/OpenDebugAD7",
      command = "/Users/cox/work/cpptools-osx2/extension/debugAdapters/bin/OpenDebugAD7",
      -- options = { detached = false },
  },
  configurations = {
    {
      name = "Launch file",
      type = "cppdbg",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = true,
    },
    {
      name = 'Attach to gdbserver :9990',
      type = 'cppdbg',
      request = 'launch',
      MIMode = 'gdb',
      miDebuggerServerAddress = 'localhost:8888',
      miDebuggerPath = '/usr/local/bin/gdb',
      cwd = '${workspaceFolder}',
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      setupCommands = {
        {
          text = '-enable-pretty-printing',
          description =  'enable pretty printing',
          ignoreFailures = false
        },
      }
    },
  }
}
