return {
  -- 调试
  {
    "mfussenegger/nvim-dap",
    commit = 'f4a3be57f61893cffa1e22aa5e1e7bded495fcf2',
    config = function()
      require("user.dap.nvim-dap")
    end,
  },

  -- 显示调试
  {
    "theHamsta/nvim-dap-virtual-text",
    commit = 'a36982259216afd710f55bcdc220477c74b5bc35',
    config = function()
      require('user.dap.nvim-dap-ui')
    end,
  },

  -- 调试UI
  {
    "rcarriga/nvim-dap-ui",
    commit = 'b0bc932ce6ca57bdec5536d773ab643e5b2f57ad',
    config = function()
      require('user.dap.nvim-dap-virtual-text')
    end,
  },

}
