return {
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "Weissle/persistent-breakpoints.nvim",
    },
    config = function()
      local breakpoint = require("persistent-breakpoints")

      require("user.dap.ui")
      require("user.dap.virtual-text")

      local g_config = require("user.config")

      vim.fn.sign_define("DapBreakpoint", g_config.defaults.icons.dap.breakpoint)
      vim.fn.sign_define("DapStopped", g_config.defaults.icons.dap.stopped)
      vim.fn.sign_define("DapBreakpointRejected", g_config.defaults.icons.dap.rejected)

      -- 断点持久化
      breakpoint.setup {
        save_dir = vim.fn.stdpath("data") .. "/lazy/persistent-breakpoints.nvim/.cache/",
        perf_record = false,
        load_breakpoints_event = { "BufReadPost" },
      }

      require("user.dap.providers.python")
      require("user.dap.providers.cpptools")
      -- require("user.dap.providers.codelldb")
    end,
  },
}
