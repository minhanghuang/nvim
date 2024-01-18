return {
  -- 调试
  {
    "mfussenegger/nvim-dap",
    commit = 'f4a3be57f61893cffa1e22aa5e1e7bded495fcf2',
    event = "VeryLazy",
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
      },
      {
        "Weissle/persistent-breakpoints.nvim",
        event = "VeryLazy",
      },
    },
    config = function()
      local breakpoint = require("persistent-breakpoints")

      require("user.dap.ui")
      require("user.dap.virtual-text")

      local g_config = require("user.config")
      local mason_dap = require("mason-nvim-dap")

      vim.fn.sign_define("DapBreakpoint", g_config.defaults.icons.dap.breakpoint)
      vim.fn.sign_define("DapStopped", g_config.defaults.icons.dap.stopped)
      vim.fn.sign_define("DapBreakpointRejected", g_config.defaults.icons.dap.rejected)

      -- 断点持久化
      breakpoint.setup {
        save_dir = vim.fn.stdpath("data") .. "/lazy/persistent-breakpoints.nvim/.cache/",
        perf_record = false,
        load_breakpoints_event = { "BufReadPost" },
      }

      mason_dap.setup({
        -- 下载DAP
        -- https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
        -- ~/.local/share/nvim/mason/bin/
        ensure_installed = g_config.defaults.extensions.dap,
      })
      require("user.dap.providers.python")
      require("user.dap.providers.cpptools")
      -- require("user.dap.providers.codelldb")
    end,
  },
}
