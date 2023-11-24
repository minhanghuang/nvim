local M = {}

local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  vim.notify("nvim-lspconfig not found!")
  return
end

local status_ok, mason = pcall(require, "mason")
if not status_ok then
  vim.notify("mason not found!")
  return
end

local status_ok, masonconfig = pcall(require, "mason-lspconfig")
if not status_ok then
  vim.notify("mason-lspconfig not found!")
  return
end

M.setup = function()
  mason.setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    }
  })


  -- 安装列表: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
  -- :Mason 查看lsp server状态
  -- :LspLog 查看lsp日志
  local server_name = {
    'lua_ls',
    'pyright',
    'clangd',
    'html',
    'cmake', -- dependence python3-venv
    'jsonls',
  };

  masonconfig.setup {
    ensure_installed = server_name,
  }

  -- { key: 服务器名, value: 配置文件 }
  local servers = {
    jsonls = require("user.lsp.providers.jsonls"),
    lua_ls = require("user.lsp.providers.sumneko_lua"),
    pyright = require("user.lsp.providers.pyright"),
    clangd = require("user.lsp.providers.clangd"),
    html = {},
    cmake = {},
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
