local util = require('user.util')

local M = {}

local defaults = {

  theme = "gruvbox", -- 主题(gruvbox tokyonight catppuccin)

  -- 拓展插件
  extensions = {
    treesitter = {
      "c",
      "cpp",
      "python",
      "bash",
      "cmake",
      "lua",
      "css",
      "json",
      "json5",
      "jsonc",
      "javascript",
      "make",
      "vue",
      "yaml",
      "vim",
      "html",
      "dockerfile",
      "diff",
      "go",
      "gomod",
      "gosum",
      "gowork",
      "git_config",
      "git_rebase",
      "gitcommit",
      "gitignore",
      "markdown",
      "markdown_inline",
      "proto",
      "query",
      "vimdoc",
    },
    lsp_server = {
      'lua_ls@3.7.3',
      'pyright@1.1.335',
      'pylsp@1.11.0',
      'clangd@16.0.2',
      'gopls', -- Golang
      'html@4.0.0',
      'volar@3.3.11',                         -- Vue 3 (注册名为 vue_ls)
      'cmake@0.1.0',                           -- dependence python3-venv
      'jsonls@4.0.0',                          -- json
      'yamlls@1.14.0',                         -- yaml
      'bashls@4.0.0',                          -- bash
      'docker_compose_language_service@0.2.0', -- docker-compose
      'dockerls@0.11.0',                       -- docker file
      'marksman@2023-12-09',                   -- markdown
    },
    formatter = {
      { "clang-format", version = "19.1.6" }, -- cpp code format
      { "ruff",         version = "0.16.8" }, -- python lint and code format
      { "cmakelang",    version = "0.6.13" }, -- cmakelists
      { "prettier",     version = "3.4.2" },  -- Angular, CSS, Flow, GraphQL, HTML, JSON, JSX, JavaScript, LESS, Markdown, SCSS, TypeScript, Vue, YAML
    },
    linter = {
      -- "cspell",       -- spell
      {
        -- https://github.com/minhanghuang/nvim/issues/50
        "cmakelint",
        version = "1.4.2"
      },
      {
        "markdownlint", version = "0.38.0", -- markdown
      },
      { "cspell",     version = "10.0.1" }, -- cspell
      { "cspell-lsp", version = "1.1.5" },  -- cspell-lsp
    },
    dap = {
      { "debugpy",  version = "1.8.0" },   -- Python
      { "codelldb", version = "v1.12.2" }, -- C/C++/Rust
      { "delve",    version = "v1.27.2" }, -- Golang
    },
  },

  -- icons used by other plugins
  -- stylua: ignore
  icons = {
    misc = {
      dots = "󰇘",
    },
    diagnostics = {
      Error = " ",
      Warn  = " ",
      Hint  = " ",
      Info  = " ",
    },
    git = {
      add          = { hl = 'GitSignsAdd', text = '▊', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
      change       = { hl = 'GitSignsChange', text = '▊', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
      topdelete    = { hl = 'GitSignsDelete', text = '▊', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
      delete       = { hl = 'GitSignsDelete', text = '▊', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
      changedelete = { hl = 'GitSignsChange', text = '┃', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
      untracked    = { hl = 'GitSignsUntracked', text = '┆', numhl = 'GitSignsUntracked', linehl = 'GitSignsUntrackedLn' },
    },
    mason = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
    dap = {
      -- "🛑⊚⭕🚫👉⭐️⛔️🔴",
      breakpoint = {
        text = "🔴",
        texthl = "LspDiagnosticsSignError",
        linehl = "",
        numhl = "",
      },
      stopped    = {
        text = "👉",
        texthl = "LspDiagnosticsSignInformation",
        linehl = "DiagnosticUnderlineInfo",
        numhl = "LspDiagnosticsSignInformation",
      },
      rejected   = {
        text = "🚫",
        texthl = "LspDiagnosticsSignHint",
        linehl = "",
        numhl = "",
      },
    },
  },
}

function M:load()
  util.enable_tmux()
  vim.g.python_version = util.get_python_version()
  vim.g.python_venv_name = util.get_python_venv_name()
end

M.defaults = defaults

return M
