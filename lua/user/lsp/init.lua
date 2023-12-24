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
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        -- signs = {
        --   active = signs,
        -- },
        underline = true, -- 将代码中诊断出的问题用下划线标记
        update_in_insert = false, -- 控制是否在插入模式中更新诊断信息
        severity_sort = true, -- 控制是否按照诊断的严重程度对其进行排序
        float = { -- 在浮动窗口中显示诊断信息的设置
          -- focusable = false,
          style = "minimal", -- 设置浮动窗口的样式
          border = "rounded", -- 设置浮动窗口的边框样式
          source = "always", -- 控制何时显示浮动窗口
          header = "", -- 定义浮动窗口的标题
          prefix = "", -- 定义浮动窗口中每个诊断条目前面的前缀
        },
        virtual_text = { -- 设置虚拟文本（在行内显示的小标签）的样式和配置
          spacing = 4, -- 定义虚拟文本与代码之间的间距
          source = "if_many", -- 控制虚拟文本显示的信息，"if_many" 表示只有存在多个诊断时才显示虚拟文本
          prefix = "●", -- 定义虚拟文本前缀
        },
      },
      -- diagnostics
    },
    config = function()
      require("user.lsp.handlers").setup()
    end,
  },
}
