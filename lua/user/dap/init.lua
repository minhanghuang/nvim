return {
  -- 调试
  {
    "mfussenegger/nvim-dap",
    commit = 'f4a3be57f61893cffa1e22aa5e1e7bded495fcf2',
    dependencies = {
      {
        "jay-babu/mason-nvim-dap.nvim"
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        commit = 'a36982259216afd710f55bcdc220477c74b5bc35',
      },
      {
        "rcarriga/nvim-dap-ui",
        commit = 'b0bc932ce6ca57bdec5536d773ab643e5b2f57ad',
      }
    },
    config = function()
      require("user.dap.dap-ui")
      require("user.dap.dap-virtual-text")

      local mason_dap = require("mason-nvim-dap")
      local icons_dap = require("user.config").defaults.icons.dap

      vim.fn.sign_define("DapBreakpoint", icons_dap.breakpoint)
      vim.fn.sign_define("DapStopped", icons_dap.stopped)
      vim.fn.sign_define("DapBreakpointRejected", icons_dap.rejected)

      mason_dap.setup({
        -- 下载DAP
        -- https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
        -- ~/.local/share/nvim/mason/bin/
        ensure_installed = {
          'python', -- python
          -- 'codelldb', -- c++
          'cppdbg', -- c++
        },
      })
      require("user.dap.providers.python")
      require("user.dap.providers.cpp-cppdbg")
    end,
  },
}
