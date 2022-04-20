-- python3 -m pip install debugpy
return {
    adapters = {
        type = "executable",
        command = "python3",
        args = {"-m", "debugpy.adapter"}
    },
    configurations = {
        {
            type = "python",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            pythonPath = function()
                return "/usr/bin/python3" 
            end
            -- pythonPath = function()
            -- local cwd = vim.fn.getcwd()
            -- if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
            --   return cwd .. '/venv/bin/python'
            -- elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
            --   return cwd .. '/.venv/bin/python'
            -- else
            --   return '/usr/bin/python'
            -- end
          -- end;
        }
    }
}
