local ok, dap = pcall(require, "dap")
if not ok then
  vim.notify("mfussenegger/nvim-dap not found!", vim.log.levels.WARN)
  return
end

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    -- Adjust as needed, must be absolute path
    command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb",
    args = { "--port", "${port}" },
  },
  -- On windows you may have to uncomment this:
  -- detached = false,
}

local configurations = {
  -- 1) 快速启动 (无参数)
  {
    name = "Run executable(codelldb)",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}", -- 被调试程序运行时的工作目录
    stopOnEntry = false,        -- false: 程序启动后直接运行,直到遇到断点或程序结束
    terminal = "integrated",    -- 使用编辑器内部集成终端
    args = {},                  -- 没有命令行参数
  },

  -- 2) 带参数启动
  {
    name = "Run executable(codelldb with args)",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    args = function()
      local input = vim.fn.input("Input args: ")
      return require("user.dap.util").str2argtable(input)
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = true,
    terminal = "integrated",
  },

  -- 3) 附加到运行中的进程
  {
    name = "Attach to process",
    type = "codelldb",
    request = "attach",
    pid = require("dap.utils").pick_process,
    cwd = "${workspaceFolder}",
    terminal = "integrated",
  },

  -- 4) 附加到 gdbserver (远程调试)
  {
    name = "Attach to gdbserver :1234",
    type = "codelldb",
    request = "launch",
    MIMode = "gdb",
    miDebuggerServerAddress = "localhost:1234",
    miDebuggerPath = "/usr/bin/gdb",
    cwd = "${workspaceFolder}",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
  },
}

dap.configurations.c = configurations
dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.c
