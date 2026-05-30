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
      local mason_installer = require("mason-lspconfig")

      -- mason installer 只能放在lsp-config里
      mason_installer.setup({
        ensure_installed = require("user.config").defaults.extensions.lsp_server,
      })

      -- diagnostics signs
      for name, icon in pairs(require("user.config").defaults.icons.diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end

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
