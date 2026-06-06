return {
  {
    "neovim/nvim-lspconfig", -- lsp配置
    event = "VeryLazy",
    dependencies = {
      {
        "mason-org/mason-lspconfig.nvim", -- nvim-lspconfig配置
      },
      {
        lazy = true,
        "b0o/schemastore.nvim", -- json schemas
      },
      {
        -- https://github.com/j-hui/fidget.nvim
        -- Useful status updates for LSP
        "j-hui/fidget.nvim",
        event = { 'BufReadPre', 'BufNewFile' },
        tag = "v1.0.0",
        config = function()
          require("fidget").setup({
            progress = {
              -- text = {
              --   spinner = 'dots_negative',
              -- },
              display = {
                render_limit = 10,
                done_ttl = 3,
              }
            }
          })
        end,
      },
      -- 杀死不活跃的lsp客户端
      {
        "zeioth/garbage-day.nvim",
        dependencies = "neovim/nvim-lspconfig",
        event = "VeryLazy",
        opts = {
          -- your options here
        }
      },
    },
    config = function()
      local mason_installer = require("mason-lspconfig")

      -- mason installer 只能放在lsp-config里
      mason_installer.setup({
        ensure_installed = require("user.config").defaults.extensions.lsp_server,
      })

      -- diagnostics (Neovim 0.11+ 必须通过 vim.diagnostic.config 配置)
      local diag_icons = require("user.config").defaults.icons.diagnostics
      vim.diagnostic.config({
        underline = true, -- 将代码中诊断出的问题用下划线标记
        update_in_insert = false, -- 控制是否在插入模式中更新诊断信息
        severity_sort = true, -- 控制是否按照诊断的严重程度对其进行排序
        float = { -- 在浮动窗口中显示诊断信息的设置
          style = "minimal", -- 设置浮动窗口的样式
          border = "rounded", -- 设置浮动窗口的边框样式
          source = true, -- 显示诊断来源 (0.11+ 用 true/false 替代 "always"/"if_many")
          header = "", -- 定义浮动窗口的标题
          prefix = "", -- 定义浮动窗口中每个诊断条目前面的前缀
        },
        virtual_text = { -- 设置虚拟文本（在行内显示的小标签）的样式和配置
          spacing = 4, -- 定义虚拟文本与代码之间的间距
          source = "if_many", -- 控制虚拟文本显示的信息，"if_many" 表示只有存在多个诊断时才显示虚拟文本
          prefix = "●", -- 定义虚拟文本前缀
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = diag_icons.Error,
            [vim.diagnostic.severity.WARN]  = diag_icons.Warn,
            [vim.diagnostic.severity.HINT]  = diag_icons.Hint,
            [vim.diagnostic.severity.INFO]  = diag_icons.Info,
          },
          numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            [vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
            [vim.diagnostic.severity.HINT]  = "DiagnosticSignHint",
            [vim.diagnostic.severity.INFO]  = "DiagnosticSignInfo",
          },
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
        ts_ls = require("user.lsp.providers.typescript"),
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
          vim.lsp.config(name, config)
        else
          vim.lsp.config(name, {}) -- 默认配置
        end
        vim.lsp.enable(name)
      end
    end,
  },
}
