local M = {}

local has_lspconfig, lspconfig = pcall(require, "lspconfig")
if not has_lspconfig then
  vim.notify("nvim-lspconfig not found!")
  return
end

local has_mason, mason = pcall(require, "mason")
if not has_mason then
  vim.notify("mason not found!")
  return
end

local has_mason_config, mason_config = pcall(require, "mason-lspconfig")
if not has_mason_config then
  vim.notify("mason-lspconfig not found!")
  return
end

local has_mason_tool_installer, mason_tool_installer = pcall(require, "mason-tool-installer")
if not has_mason_tool_installer then
  vim.notify("mason-tool-installer not found!")
  return
end

M.setup = function()
  -- diagnostics
  for name, icon in pairs(require("user.config").defaults.icons.diagnostics) do
    name = "DiagnosticSign" .. name
    vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
  end

  mason.setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    }
  })


  -- :Mason 查看lsp server状态
  -- :LspLog 查看lsp日志
  mason_config.setup {
    -- Node.js version: v15.4.0
    -- 安装列表: https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
    ensure_installed = {
      'lua_ls',
      'pyright',
      'clangd',
      'html@4.0.0',
      'cmake',                           -- dependence python3-venv
      'jsonls@4.0.0',                    -- json
      'yamlls',                          -- yaml
      'bashls@4.0.0',                    -- bash
      'vls',                             -- vue.js
      'docker_compose_language_service', -- docker-compose
      'dockerls',                        -- docker file
    },
  }

  mason_tool_installer.setup({
    ensure_installed = {
      -- format
      "autopep8", -- python formatter
      "black",    -- python formatter
      "prettier", -- Angular, CSS, Flow, GraphQL, HTML, JSON, JSX, JavaScript, LESS, Markdown, SCSS, TypeScript, Vue, YAML
    },
  })

  -- { key: 服务器名, value: 配置文件 }
  local servers = {
    jsonls = require("user.lsp.providers.jsonls"),
    lua_ls = require("user.lsp.providers.sumneko_lua"),
    pyright = require("user.lsp.providers.pyright"),
    clangd = require("user.lsp.providers.clangd"),
    html = require("user.lsp.providers.html"),
    cmake = require("user.lsp.providers.cmake"),
    yamlls = require("user.lsp.providers.yamlls"),
    bashls = require("user.lsp.providers.bashls"),
    vuels = require("user.lsp.providers.vue"),
    docker_compose_language_service = require("user.lsp.providers.docker-compose"),
    dockerls = require("user.lsp.providers.default"),
  }

  for name, config in pairs(servers) do
    if config then
      lspconfig[name].setup(config)
    else
      lspconfig[name].setup({}) -- 默认配置
    end
  end
end

return M
