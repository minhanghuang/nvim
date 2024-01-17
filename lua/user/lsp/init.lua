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
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason = require("mason")
      local mason_config = require("mason-lspconfig")
      local mason_tool_installer = require("mason-tool-installer")
      local g_config = require("user.config")

      -- diagnostics signs
      for name, icon in pairs(require("user.config").defaults.icons.diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end

      mason.setup({
        ui = {
          icons = require("user.config").defaults.icons.mason
        }
      })

      -- :Mason 查看lsp server状态
      -- :LspLog 查看lsp日志
      mason_config.setup {
        -- Node.js version: v15.4.0
        -- 安装列表: https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
        ensure_installed = g_config.defaults.extensions.lsp_server,
      }

      mason_tool_installer.setup({
        ensure_installed = {
          g_config.defaults.extensions.formatter,
          g_config.defaults.extensions.linter,
        },
      })

      -- { key: 服务器名, value: 配置文件 }
      -- 配置: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
      local servers = {
        jsonls = require("user.lsp.providers.jsonls"),
        lua_ls = require("user.lsp.providers.sumneko_lua"),

        -- Python使用两个lsp, pylsp作为辅助, 补全第三方库(rospy、Protobuf等)
        pyright = require("user.lsp.providers.pyright"),
        pylsp = require("user.lsp.providers.pylsp"),

        clangd = require("user.lsp.providers.clangd"),
        html = require("user.lsp.providers.html"),
        tsserver = require("user.lsp.providers.typescript"),
        cmake = require("user.lsp.providers.cmake"),
        yamlls = require("user.lsp.providers.yamlls"),
        bashls = require("user.lsp.providers.bashls"),
        vuels = require("user.lsp.providers.vue"),
        docker_compose_language_service = require("user.lsp.providers.docker-compose"),
        dockerls = require("user.lsp.providers.default"),
        marksman = require("user.lsp.providers.default"),
      }

      for name, config in pairs(servers) do
        if config then
          lspconfig[name].setup(config)
        else
          lspconfig[name].setup({}) -- 默认配置
        end
      end
    end,
  },
}
