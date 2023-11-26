return {
  -- LSP
  {
    "neovim/nvim-lspconfig",                         -- lsp配置
    dependencies = {
      "williamboman/mason.nvim",                     -- 管理lsp插件
      "williamboman/mason-lspconfig.nvim",           -- 配置nvim-lspconfig
      {
        "WhoIsSethDaniel/mason-tool-installer.nvim", -- 安装工具(解决一些非lsp工具mason-lspconfig.nvim无法安装问题)
      },
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
