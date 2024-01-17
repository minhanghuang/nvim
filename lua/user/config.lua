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
      'lua_ls',
      'pyright',
      'pylsp',
      'clangd',
      'html@4.0.0',
      'tsserver',                        -- js ts
      'cmake',                           -- dependence python3-venv
      'jsonls@4.0.0',                    -- json
      'yamlls',                          -- yaml
      'bashls@4.0.0',                    -- bash
      'vuels',                           -- vue.js 2(vuels)
      -- 'vue',                             -- vue.js 3(volar)
      'docker_compose_language_service', -- docker-compose
      'dockerls',                        -- docker file
      'marksman',                        -- markdown
    },
    formatter = {
      "clang-format",      -- cpp
      "autopep8", "black", -- python
      "cmakelang",         -- cmakelists
      "prettier",          -- Angular, CSS, Flow, GraphQL, HTML, JSON, JSX, JavaScript, LESS, Markdown, SCSS, TypeScript, Vue, YAML
    },
    linter = {
      -- "cspell",       -- spell
      "cmakelint",    -- cmake
      "markdownlint", -- markdown
    },
    dap = {
      "python",   -- python
      -- "codelldb", -- c++
      "cppdbg",   -- c++
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

local function get_python_version()
  local python_version = vim.fn.system('python3 --version | awk \'{print $2}\' | cut -d "." -f 1-2')
  return string.gsub(python_version, "\n", "")
end

function M:load()
  vim.g.python_version = get_python_version()
end

M.defaults = defaults

return M
