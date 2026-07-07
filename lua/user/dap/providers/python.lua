local ok, dap = pcall(require, "dap")
if not ok then
  vim.notify("mfussenegger/nvim-dap not found!", vim.log.levels.WARN)
  return
end

require("dap-python").setup(
  vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
)

dap.configurations.python = {
  -- 1) 快速启动(无参数，常用)
  {
    type = "python",
    request = "launch",
    name = "Run file",
    program = "${file}",
    console = "integratedTerminal",
  },

  -- 2) 带参数启动
  {
    type = "python",
    request = "launch",
    name = "Run file (with args)",
    program = "${file}",
    console = "integratedTerminal",
    args = function()
      local input = vim.fn.input("Input args: ")
      return require("user.dap.util").str2argtable(input)
    end,
  },

  -- 3) 模块启动 (python -m module)
  {
    type = "python",
    request = "launch",
    name = "Run module",
    module = function()
      return vim.fn.input("Module name: ")
    end,
    console = "integratedTerminal",
  },

  -- 4) 调试 pytest 当前函数
  {
    type = "python",
    request = "launch",
    name = "Debug test method",
    module = "pytest",
    args = function()
      return { "${file}::${test}" }
    end,
    console = "integratedTerminal",
    justMyCode = false,
  },

  -- 5) 附加到远程 debugpy(端口 5678)
  {
    type = "python",
    request = "attach",
    name = "Attach remote",
    connect = { host = "localhost", port = 5678 },
    justMyCode = false,
  },
}
