local has_dap, dap = pcall(require, "dap")
if not has_dap then
  vim.notify("nvim-dap not found!")
  return
end

dap.adapters.python = {
  type = "executable",
  command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
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
      return require("user.dap.util").str2argtable(input)
    end,
    pythonPath = function()
      local venv = os.getenv("VIRTUAL_ENV")
      if venv then
        return venv .. '/bin/python'
      else
        return vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
      end
    end
  }
}
