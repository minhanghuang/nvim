return {
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-dap-python",
      "jay-babu/mason-nvim-dap.nvim",
      "Weissle/persistent-breakpoints.nvim",
    },
    config = function()
      require("user.dap.ui")

      -- 内置 virtual text(替代 nvim-dap-virtual-text)
      vim.api.nvim_set_hl(0, "DapVirtualText", { link = "Comment" })
      vim.g.dap_virtual_text = true

      local g_config = require("user.config")
      vim.fn.sign_define("DapBreakpoint", g_config.defaults.icons.dap.breakpoint)
      vim.fn.sign_define("DapStopped", g_config.defaults.icons.dap.stopped)
      vim.fn.sign_define("DapBreakpointRejected", g_config.defaults.icons.dap.rejected)

      -- 断点持久化
      require("persistent-breakpoints").setup({
        save_dir = vim.fn.stdpath("data") .. "/lazy/persistent-breakpoints.nvim/.cache/",
        perf_record = false,
        load_breakpoints_event = { "BufReadPost" },
      })

      -- Mason DAP 适配器自动配置(debugpy | codelldb)
      require("mason-nvim-dap").setup({
        automatic_installation = true,
      })

      require("user.dap.providers.python")   -- Python: debugpy
      require("user.dap.providers.codelldb") -- C/C++/Rust: codelldb
    end,
  },
}
