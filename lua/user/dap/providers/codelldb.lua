local has_dap, dap = pcall(require, "dap")
if not has_dap then
  vim.notify("dap not found!")
  return
end

-- https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)
local path = vim.fn.stdpath("data") .. "/mason/bin/codelldb"

dap.adapters.codelldb = function(on_adapter)
  -- This asks the system for a free port
  local tcp = vim.loop.new_tcp()
  tcp:bind("127.0.0.1", 0)
  local port = tcp:getsockname().port
  tcp:shutdown()
  tcp:close()

  -- Start codelldb with the port
  local stdout = vim.loop.new_pipe(false)
  local stderr = vim.loop.new_pipe(false)
  local opts = {
    stdio = { nil, stdout, stderr },
    args = { "--port", tostring(port) }
  }
  local handle
  local pid_or_err
  handle, pid_or_err =
      vim.loop.spawn(
        path,
        opts,
        function(code)
          stdout:close()
          stderr:close()
          handle:close()
          if code ~= 0 then
            print("codelldb exited with code", code)
          end
        end
      )
  if not handle then
    vim.notify("Error running codelldb: " .. tostring(pid_or_err), vim.log.levels.ERROR)
    stdout:close()
    stderr:close()
    return
  end
  vim.notify("codelldb started. pid=" .. pid_or_err)
  stderr:read_start(
    function(err, chunk)
      assert(not err, err)
      if chunk then
        vim.schedule(
          function()
            require("dap.repl").append(chunk)
          end
        )
      end
    end
  )
  local adapter = {
    type = "server",
    host = "127.0.0.1",
    port = port
  }
  -- 💀
  -- Wait for codelldb to get ready and start listening before telling nvim-dap to connect
  -- If you get connect errors, try to increase 500 to a higher value, or check the stderr (Open the REPL)
  vim.defer_fn(
    function()
      on_adapter(adapter)
    end,
    500
  )
end

local configurations = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    args = function()
      local input = vim.fn.input("Input args: ")
      return require("user.dap.util").str2argtable(input)
    end,
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    -- pid = function()
    --   local handle = io.popen("pgrep hw$")
    --   local result = handle:read()
    --   handle:close()
    --   return result
    -- end,
    cwd = "${workspaceFolder}",
    stopOnEntry = true,
    -- terminal = "integrated"
  }
}

dap.configurations.c = configurations
dap.configurations.cpp = configurations
dap.configurations.rust = configurations
