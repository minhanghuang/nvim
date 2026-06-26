local ok, dap = pcall(require, "dap")
if not ok then
  vim.notify("mfussenegger/nvim-dap not found!")
  return
end

-- adapter 由 nvim-dap-python 在 init.lua 中统一配置
-- 这里只添加自定义 launch configurations
dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    console = "integratedTerminal", -- print 输出显示在终端
    args = function()
      local input = vim.fn.input("Input args: ")
      return require("user.dap.util").str2argtable(input)
    end,
    -- pythonPath 由 nvim-dap-python 自动检测虚拟环境
  },
}
