return {
  {
    "nvim-lua/plenary.nvim",
    enabled = true,
    init = function()
      -- pass
    end,
    config = function()
      -- pass
    end,
  },

  --mason
  {
    "mason-org/mason.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
      "MasonUpdate"
    },
    dependencies = {
      "mason-org/mason.nvim",                      -- 管理lsp插件
      "WhoIsSethDaniel/mason-tool-installer.nvim", -- 安装工具(解决一些非lsp工具mason-lspconfig.nvim无法安装问题)
      "jay-babu/mason-nvim-dap.nvim",              -- mason dap
    },
    config = function()
      require("user.conf.mason")
    end,
  },

  -- 自动保存
  {
    "Pocco81/auto-save.nvim",
    config = function()
      require("user.conf.autosave")
    end,
  },

  -- Ros
  {
    "minhanghuang/ros.nvim",
    config = function()
      require("ros").setup({
        enabled = true,
        auto_generate_compile_commands = true
      })
    end,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    enabled = true,
    config = function()
      require("user.conf.autopairs")
    end,
  },

  -- Buffer
  {
    "akinsho/bufferline.nvim",
    config = function()
      require("user.conf.bufferline")
      -- 删除所有隐藏buffer
      vim.api.nvim_create_user_command('BdeleteHidden', function()
        require("snacks").bufdelete.invisible()
      end, { bang = true })
    end,
  },

  -- color颜色板
  {
    -- https://github.com/NvChad/nvim-colorizer.lua
    "NvChad/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
      require("colorizer").setup({
        filetypes = {
          "typescript",
          "typescriptreact",
          "javascript",
          "javascriptreact",
          "css",
          "sass",
          "html",
          "astro",
          "vue",
        },
      })
    end,
  },

  -- diffview
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    config = function()
      require("user.conf.diffview")
    end,
  },

  -- 搜索美化(显示[c/N])
  {
    "kevinhwang91/nvim-hlslens",
    event = "VeryLazy",
    config = function()
      require("user.conf.nvim-hlslens")
      vim.api.nvim_set_keymap('n', 'n',
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', 'N',
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Leader>l', ':noh<CR>', { noremap = true, silent = true })
      -- 光标停留在当前字符, 不会跳转至下一个匹配的字符
      -- keymap("n", "<C-f>", "g*", { silent = true })
      vim.keymap.set('n', '<C-f>', function()
        local cword = vim.fn.expand('<cword>')
        local pattern = [[\V\<]] .. vim.fn.escape(cword, [[\]]) .. [[\>]]
        vim.fn.setreg('/', pattern)
        vim.opt.hlsearch = true
        require('hlslens').start()
      end, { noremap = true, silent = true })
    end,
  },

  -- lint
  {
    -- https://github.com/mfussenegger/nvim-lint
    "mfussenegger/nvim-lint",
    event = "BufReadPre",
    config = function()
      require("user.conf.nvim-lint")
    end,
  },

  -- git
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      require("user.conf.nvim-gitsigns")
    end,
  },

  -- formatting
  {
    "mhartington/formatter.nvim",
    event = "VeryLazy",
    config = function()
      require("user.conf.formatter")
    end,
  },

  -- 缩进
  {
    -- https://github.com/shellRaining/hlchunk.nvim
    "shellRaining/hlchunk.nvim",
    config = function()
      require("hlchunk").setup({
        chunk = {
          -- https://github.com/shellRaining/hlchunk.nvim/blob/main/docs/zh_CN/chunk.md
          enable = true,
          style = {
            { fg = "#d47d26" },
            { fg = "#c21f30" },
          },
          -- 动画
          duration = 200,
          delay = 10,
        },
        indent = {
          enable = true,
        },
        line_num = {
          enable = false,
        },
      })
    end
  },

  -- 添加函数接口说明
  {
    -- https://github.com/danymat/neogen
    "danymat/neogen",
    event = "VeryLazy",
    config = function()
      require("neogen").setup({
        languages = {
          -- 修改Python模版
          python = {
            template = {
              annotation_convention = "reST",
            }
          },
        }
      })
    end,
  },

  -- 打开上次编辑位置
  {
    "ethanholz/nvim-lastplace",
    config = function()
      require("user.conf.nvim-lastplace")
    end,
  },

  -- icon
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("user.conf.nvim-web-devicons")
    end,
  },

  -- 文件树
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("user.conf.nvim-tree")
    end,
  },

  -- 语法解析
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = "patch -p1 --forward < ~/.config/nvim/patches/nvim-treesitter-0.12.patch || true",
    cmd = {
      "TSInstall",
      "TSInstallSync",
      "TSInstallInfo",
      "TSUpdate",
      "TSUpdateSync",
      "TSUninstall",
      "TSBufEnable",
      "TSBufDisable",
      "TSBufToggle",
      "TSEnable",
      "TSDisable",
      "TSToggle",
      "TSModuleInfo",
      "TSEditQuery",
      "TSEditQueryUserAfter",
    },
    -- 禁止设置VeryLazy, 会影响filetype.nvim插件
    -- event = "VeryLazy",
    -- dependencies = {
    --   {
    --     -- nvim-treesitter parser (https://github.com/minhanghuang/nvim/issues/23)
    --     "nathom/filetype.nvim",
    --     config = function()
    --       require("filetype").setup({})
    --     end,
    --   },
    -- },
    config = function()
      require("user.conf.nvim-treesitter")
    end,
  },
  -- 高亮补充
  {
    -- https://github.com/m-demare/hlargs.nvim
    "m-demare/hlargs.nvim",
    event = { 'BufRead' },
    config = function()
      require('hlargs').setup({})
    end,
  },

  -- 上下文
  {
    -- https://github.com/nvim-treesitter/nvim-treesitter-context
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    cmd = {
      "TSContextEnable",
      "TSContextDisable",
      "TSContextToggle",
    },
    config = function()
      require("treesitter-context").setup({
        enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20,     -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      })
      -- 跳转到上下文的上文
      vim.keymap.set("n", "[c", "<cmd>lua require('treesitter-context').go_to_context(vim.v.count1)<CR>")
    end,
  },

  -- 启动画面
  {
    "mhinz/vim-startify",
    config = function()
      require("user.conf.startify")
    end,
  },

  -- 搜索
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
      {
        -- lsp code-action
        -- Neovim 0.9+ https://github.com/nvim-telescope/telescope-ui-select.nvim/issues/29#issuecomment-1825841303
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-lua/plenary.nvim",
        "BurntSushi/ripgrep",
        "sharkdp/fd",
      },

    },
    config = function()
      require("user.conf.nvim-telescope")
      -- 历史命令
      vim.keymap.set("n", "<Leader>f;", "<cmd>lua require('telescope.builtin').command_history()<CR>")
      -- 搜索历史
      vim.keymap.set("n", "<Leader>f/", "<cmd>lua require('telescope.builtin').search_history()<CR>")
      -- 单词拼写建议
      vim.keymap.set("n", "<Leader>fe", "<cmd>lua require('telescope.builtin').spell_suggest()<CR>")
      -- 查看键盘映射
      vim.keymap.set("n", "<Leader>fm", "<cmd>lua require('telescope.builtin').keymaps()<CR>")
    end,
  },

  -- 替换
  {
    -- https://github.com/nvim-pack/nvim-spectre
    "nvim-pack/nvim-spectre",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("user.conf.nvim-spectre")
    end,
  },

  -- 剪切板管理器
  {
    -- https://github.com/AckslD/nvim-neoclip.lua
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      { 'kkharji/sqlite.lua',           module = 'sqlite' },
      { 'nvim-telescope/telescope.nvim' },
    },
    config = function()
      require("user.conf.nvim-neoclip")
    end,
  },

  -- TODO LIST
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    config = function()
      require("user.conf.todo-comments")
    end,
  },

  -- ui
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
      {
        "MunifTanjim/nui.nvim",
        lazy = true,
      }
    },
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  -- LSP增强
  {
    -- https://github.com/nvimdev/lspsaga.nvim
    "nvimdev/lspsaga.nvim",
    enable = true,
    cmd = { "Lspsaga" },
    event = "LspAttach",
    config = function()
      require("user.conf.lspsaga")
      -- 查看函数和变量
      vim.keymap.set("n", "<Leader><Tab>", "<cmd>Lspsaga outline<CR>")
      -- 跳转到下一个错误, code action
      vim.keymap.set("n", "<Leader>-", "<cmd>Lspsaga diagnostic_jump_next<CR>")
      -- 跳转到上一个错误, code action
      vim.keymap.set("n", "<Leader>=", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
      -- code action
      vim.keymap.set("n", "<Leader>ce", "<cmd>Lspsaga code_action<CR>")
      -- show diagnostic in floating window
      vim.keymap.set("n", "<Leader>di", "<cmd>Lspsaga show_line_diagnostics<CR>")
    end,
  },
  {
    -- https://github.com/folke/trouble.nvim
    "folke/trouble.nvim",
    enable = true,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Trouble",
    config = function()
      require("trouble").setup({
        -- global config
        auto_close = true, -- auto close when there are no items
      })
      -- 显示诊断列表(:lua vim.diagnostic.setqflist())
      vim.keymap.set("n", "<Leader>cl", "<cmd>Trouble diagnostics toggle focus=true win.type='split' filter.buf=0 <CR>")
      -- -- 查看函数和变量 ui界面不佳, 使用lspsaga
      -- vim.keymap.set("n", "<Leader><Tab>", "<cmd>Trouble symbols toggle focus=true win.type='split' filter.buf=0 <CR>")
    end,
  },

  {
    -- https://github.com/folke/snacks.nvim
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      bufdelete = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
        width = { min = 40, max = 0.4 },
        height = { min = 1, max = 0.6 },
        margin = { top = 0, right = 1, bottom = 0 },
        padding = true,
        sort = { "level", "added" },
        level = vim.log.levels.TRACE,
        icons = {
          error = " ",
          warn = " ",
          info = " ",
          debug = " ",
          trace = " ",
        },
        style = "compact",
        top_down = true,
        date_format = "%R",
        more_format = " ↓ %d lines ",
        refresh = 50,
        -- 自动展示 LSP 进度和 server 消息
        sources = {
          lsp = {
            -- -- LSP progress (/progress)
            -- progress = { enable = true, filter = { "client", "server" } },
            -- -- LSP server messages (window/showMessage)
            -- message = { enable = true, filter = { "warning", "error", "info" } },
            progress = { enable = false },
            message = { enable = false },
          },
        },
      },
      picker = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = {
        -- 符号列和行号之间间距
        enabled = false,
      },
      words = { enabled = true },
      styles = {
        notification = {
          -- wo = { wrap = true } -- Wrap notifications
        }
      }
    },
    keys = {
      -- Top Pickers & Explorer
      -- { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
      { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification History" },
      { "<leader>nd", function() Snacks.notifier.hide() end,         desc = "Dismiss All Notifications" },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          vim.notify = Snacks.notifier.notify
        end,
      })
    end,
  },
  {
    -- https://github.com/folke/which-key.nvim
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
    config = function()
      require("user.conf.witch-key")
    end
  },

  -- image, dependence: https://github.com/3rd/image.nvim?tab=readme-ov-file#imagemagick
  -- kitty terminal
  {
    "3rd/image.nvim",
    build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
    opts = {
      processor = "magick_cli",
    },
    config = function()
      require("user.conf.image")
    end,
  },

  -- leetcode
  {
    -- https://github.com/kawre/leetcode.nvim
    "kawre/leetcode.nvim",
    build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
    dependencies = {
      -- include a picker of your choice, see picker section for more details
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim",
      'nvim-treesitter/nvim-treesitter',
    },
    -- 如何在nvim中使用leetcode?
    --  1. 在终端输入: nvim leetcode
    --
    -- 如何登录? https://github.com/kawre/leetcode.nvim?tab=readme-ov-file#sign-in
    --  1. 使用浏览器打开leetcode.cn, 登录后, 打开开发者工具, 在Application->Cookies中(过略:graphql)找到cookie
    --  2. 打开leetcode.nvim, 在登录选项中选择"使用cookie登录", 然后将在浏览器中复制的cookie粘贴到输入框中
    opts = {
      -- configuration goes here
      -- default config: https://github.com/kawre/leetcode.nvim?tab=readme-ov-file#%EF%B8%8F-default-configuration
      arg = "leetcode",
      lang = "cpp",
      cn = { -- leetcode.cn
        enabled = true, ---@type boolean
        translator = true, ---@type boolean
        translate_problems = true, ---@type boolean
      },
      image_support = true,
    },
  },

  -- 书签
  {
    -- https://github.com/MattesGroeger/vim-bookmarks
    "MattesGroeger/vim-bookmarks",
    event = "VeryLazy",
    dependencies = {
      {
        -- https://github.com/tom-anders/telescope-vim-bookmarks.nvim
        -- 集成nvim-telescope
        "tom-anders/telescope-vim-bookmarks.nvim",
      }
    },
    init = function()
      vim.g.bookmark_sign = ''
      vim.g.bookmark_annotation_sign = ''
      vim.g.bookmark_highlight_lines = 1
      vim.g.bookmark_no_default_key_mappings = 1
    end,
    config = function()
      require('telescope').load_extension('vim_bookmarks')
    end,
  },

  -- 注释
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require('Comment').setup({
        toggler = {
          ---Line-comment toggle keymap
          line = 'gcc',
          ---Block-comment toggle keymap
          block = 'gbc',
        },
        ---LHS of operator-pending mappings in NORMAL and VISUAL mode
        opleader = {
          ---Line-comment keymap
          line = 'gc',
          ---Block-comment keymap
          block = 'gb',
        },
      })
    end,
  },

  -- 终端
  {
    "voldikss/vim-floaterm",
    event = "VeryLazy",
    init = function()
      vim.g.floaterm_wintype = 'split'
      vim.g.floaterm_position = 'belowright'
      vim.g.floaterm_width = 0.6
      vim.g.floaterm_height = 0.4
      vim.g.floaterm_title = 'Terminal: $1/$2'
    end,
  },

  -- Markdown preview
  {
    -- https://github.com/MeanderingProgrammer/render-markdown.nvim
    "MeanderingProgrammer/render-markdown.nvim",
    cmds = {
      "RenderMarkdown",
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons', -- if you prefer nvim-web-devicons
    },
    ft = { "markdown", "norg", "rmd", "org" },
    opts = {
      file_types = { "markdown", "norg", "rmd", "org" },
      render_modes = { "n", "c", "i", "v", "V" },
      heading = {
        -- 标题
        width = { 'full', 'block', 'full', 'block' },
        min_width = 30,
        -- icons = {}, -- disables icons
      },
      code = {
        -- 代码块
        enabled = true,
        sign = true,
        style = 'full',
        position = 'right',
        width = 'block',
        right_pad = 10,
        language_pad = 0,
        disable_background = { 'diff' },
        left_pad = 0,
        min_width = 0,
        border = 'thin',
        above = '▄',
        below = '▀',
        highlight = 'RenderMarkdownCode',
        highlight_inline = 'RenderMarkdownCodeInline',
      },
    },
    config = function()
      require('render-markdown').setup({
        enabled = true,
        file_types = { 'markdown', 'vimwiki' },
        completions = { lsp = { enabled = true } },
      })
    end
  },

  -- 单词拼写检查
  {
    "minhanghuang/spell.nvim",
    event = "VeryLazy",
    config = function()
      require("user.conf.spell")
      vim.keymap.set("n", "<Leader>ze", "<cmd>SpellTogglePlugin<CR>")
      vim.keymap.set("n", "<Leader>zs", "<cmd>SpellSuggest<CR>")
      vim.keymap.set("n", "<Leader>za", "<cmd>SpellAdd!<CR>")
      vim.keymap.set("n", "<Leader>zn", "<cmd>SpellNext<CR>")
      vim.keymap.set("n", "<Leader>zp", "<cmd>SpellPrev<CR>")
    end,
  },
  -- -- dev单词拼写检查
  -- {
  --   dir = "~/work/code/github/spell.nvim", -- 本地repo绝对路径
  --   event = "VeryLazy",
  --   config = function()
  --     require("user.conf.spell")
  --     vim.keymap.set("n", "<Leader>zt", "<cmd>SpellTogglePlugin<CR>")
  --     vim.keymap.set("n", "<Leader>zs", "<cmd>SpellSuggest<CR>")
  --     vim.keymap.set("n", "<Leader>za", "<cmd>SpellAdd!<CR>")
  --     vim.keymap.set("n", "<Leader>zn", "<cmd>SpellNext<CR>")
  --     vim.keymap.set("n", "<Leader>zp", "<cmd>SpellPrev<CR>")
  --   end,
  -- },

  -- 翻译
  {
    "voldikss/vim-translator",
    event = "VeryLazy",
    init = function()
      vim.g.translator_target_lang = "zh"
      vim.g.translator_default_engines = {
        'google',
        -- 'haici',
        -- 'youdao',
      }
    end,
  },

  -- 底部状态栏
  {
    "windwp/windline.nvim",
    enabled = true,
    config = function()
      require("user.conf.windline")
    end,
  },
}
