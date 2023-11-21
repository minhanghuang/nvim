return {
  -- LSP
  {
    "neovim/nvim-lspconfig",               -- lsp配置
    dependencies = {
      "williamboman/mason.nvim",           -- 管理lsp插件
      "williamboman/mason-lspconfig.nvim", -- 配置nvim-lspconfig
      {
        lazy = true,
        "b0o/schemastore.nvim", -- json schemas
      },
    },
    config = function()
      require("user.lsp.handlers").setup()
    end,
  },
}
