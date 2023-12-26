local M = {}

local defaults = {

  theme = "gruvbox", -- 主题(gruvbox tokyonight catppuccin)

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

M.defaults = defaults

return M
