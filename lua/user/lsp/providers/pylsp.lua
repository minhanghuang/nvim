-- local util = require('user.util')
local config = require("user.lsp.config")

-- pylsp作为Python补全的辅助工具, 只打开它的`jedi_completion`和`jedi`这两个配置, 其余配置全部关闭。
-- 用于补全rospy和部分Protobuf(暂时还不能补全函数)
return {
  capabilities = config.capabilities,
  on_attach = config.on_attach,
  settings = {
    pylsp = {
      -- https://github.com/python-lsp/python-lsp-server
      plugins = {
        -- https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
        pycodestyle = {
          enabled = false,
          -- ignore = { 'W391' },
          -- maxLineLength = 100
        },
        autopep8 = { enabled = false },
        flake8 = { enabled = false },
        -- 补全第三方库
        jedi_completion = { enabled = true },
        jedi_definition = { enabled = false },
        jedi_hover = { enabled = false },
        jedi_references = { enabled = false },
        jedi_signature_help = { enabled = false },
        jedi_symbols = { enabled = false },
        mccabe = { enabled = false },
        preload = { enabled = false },
        pydocstyle = { enabled = false },
        pyflakes = { enabled = false },
        pylint = { enabled = false },
        rope_autoimport = {
          enabled = false,
          completions = {
            enabled = false,
          },
          code_actions = {
            enabled = false,
          }
        },
        rope_completion = { enabled = false },
        yapf = { enabled = false },
        -- -- import sorting
        isort = { enabled = false },
        -- jedi = {
        --   environment = util.get_python_path(),
        -- },
      }
    }
  },
}
