return {
  --mason
  {
    "mason-org/mason.nvim",
    version = "v2.1.0",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog", "MasonUpdate" },
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
    commit = '979b6c8',
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
    event = "VeryLazy",
    commit = '73540cb95f8d95aa1af3ed57713c6720c78af915', -- Neovim 0.10.0 stable更新
    dependencies = {
      {
        "famiu/bufdelete.nvim", -- delete buffer
        commit = '8933abc',
        config = function()
          local function delete_hidden_buffers()
            local hidden_bufs = vim.tbl_filter(function(bufnr)
              return vim.fn.getbufinfo(bufnr)[1].hidden == 1
            end, vim.api.nvim_list_bufs())

            for _, bufnr in ipairs(hidden_bufs) do
              require("bufdelete").bufdelete(bufnr)
            end
          end
          vim.api.nvim_create_user_command('BdeleteHidden', delete_hidden_buffers, { bang = true })
        end,
      },
    },
    config = function()
      require("user.conf.bufferline")
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
    commit = "63720aa",
    event = "VeryLazy",
    config = function()
      require("user.conf.diffview")
    end,
  },

  ---- 跳跃
  --{
  --  -- https://github.com/folke/flash.nvim
  --  "folke/flash.nvim",
  --  event = "VeryLazy",
  --  vscode = false,
  --  ---@type Flash.Config
  --  opts = {
  --    labels = "asdfghjklqwertyuiopzxcvbnm",
  --    -- labels = "asdfghjklqertyuiopzxcvnm", -- exlude: w b
  --    search = {
  --      forward = true,

  --      -- when `false`, find only matches in the given direction
  --      wrap = true,

  --      -- Each mode will take ignorecase and smartcase into account.
  --      -- * exact: exact match
  --      -- * search: regular search
  --      -- * fuzzy: fuzzy search
  --      mode = "exact",
  --    },
  --    label = {
  --      style = "inline", ---@type "eol" | "overlay" | "right_align" | "inline"
  --      rainbow = {
  --        -- label设置为彩虹🌈颜色
  --        enabled = true,
  --      }
  --    },
  --    jump = {
  --      -- jump position
  --      pos = "start", ---@type "start" | "end" | "range"
  --      -- automatically jump when there is only one match
  --      autojump = false,
  --    },
  --    modes = {
  --      char = {
  --        enabled = true,
  --        label = { exclude = "hjkliardc" },
  --        keys = { "f", "F", "t", "T", ";", "," },
  --        -- 修改快捷键
  --        -- keys = { "f", "F", "t", "T", [";"] = "w", [","] = "b" },
  --      },
  --    }
  --  },
  --  keys = {
  --    {
  --      "<C-s>",
  --      mode = { "n", "x", "o" },
  --      function()
  --        -- -- 跳转到任意字符
  --        require("flash").jump(
  --        -- 继续上次搜索
  --        -- { continue = true }
  --        )

  --        -- -- 跳转到某一行
  --        -- require("flash").jump({
  --        --   search = { mode = "search", max_length = 0 },
  --        --   label = { after = { 0, 0 } },
  --        --   pattern = "^"
  --        -- })

  --        -- -- 仅匹配每个字符串单词的开头
  --        -- -- http_status_ok: 只匹配ht..开头, 不匹配ok
  --        -- require("flash").jump({
  --        --   search = {
  --        --     wrap = true,
  --        --     mode = function(str)
  --        --       return "\\<" .. str
  --        --     end,
  --        --   },
  --        -- })
  --      end,
  --      desc = "匹配单词"
  --    },
  --    {
  --      "S",
  --      mode = { "n", "x", "o" },
  --      function()
  --        require("flash").treesitter()
  --      end,
  --      desc = "开启树状选择界面"
  --    },
  --    -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
  --    -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  --    -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  --  },
  --},

  -- 搜索美化(显示[c/N])
  {
    "kevinhwang91/nvim-hlslens",
    tag = 'v1.1.0',
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
      vim.api.nvim_set_keymap('n', '<C-f>', [[:let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'<CR> :set hls<CR>]],
        { noremap = true, silent = true })
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
    commit = '372d5cb',
    event = "VeryLazy",
    config = function()
      require("user.conf.gitsigns")
    end,
  },

  -- git UI
  {
    -- https://github.com/kdheepak/lazygit.nvim
    -- need install lazygit(https://github.com/jesseduffield/lazygit)
    -- https://github.com/jesseduffield/lazygit?tab=readme-ov-file#ubuntu
    "kdheepak/lazygit.nvim",
    event = "VeryLazy",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope.nvim",
        tag = '0.1.4',
      },
    },
    config = function()
      -- keymap
      -- 上下左右箭头
      require("telescope").load_extension("lazygit")
      vim.api.nvim_create_autocmd('BufEnter', {
        desc = 'makes sure any opened buffer inside a git repo will be tracked by lazygit',
        callback = function()
          require('lazygit.utils').project_root_dir()
        end,
        group = vim.api.nvim_create_augroup('Lazygit', { clear = false }),
      })
    end,
  },

  -- formatting
  {
    "mhartington/formatter.nvim",
    enabled = true,
    event = "VeryLazy",
    config = function()
      require("user.conf.formatter")
    end,
  },

  -- formatting
  {
    "sbdchd/neoformat",
    enabled = false,
    config = function()
      require("user.conf.neoformat")
    end,
  },

  -- -- 缩进提示
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   commit = '4541d69',
  --   event = "VeryLazy",
  --   config = function()
  --     vim.opt.list = true
  --     require("indent_blankline").setup {
  --       show_end_of_line = true,
  --       space_char_blankline = " ",
  --     }
  --   end,
  -- },
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
    commit = '9c17225',
    event = "VeryLazy",
    config = function()
      require("neogen").setup({
        languages = {
          -- 修改Python模版
          python = {
            template = {
              annotation_convention =
              "reST"
            }
          },
        }
      })
    end,
  },

  -- 打开上次编辑位置
  {
    "ethanholz/nvim-lastplace",
    commit = '75a2b78',
    config = function()
      require("user.conf.nvim-lastplace")
    end,
  },

  -- icon
  {
    "nvim-tree/nvim-web-devicons",
    commit = "b77921fdc44833c994fdb389d658ccbce5490c16", -- 解决自定义icos不生效问题(https://github.com/nvim-tree/nvim-web-devicons/issues/465)
    config = function()
      require("user.conf.nvim-web-devicons")
    end,
  },

  -- 文件树
  {
    "nvim-tree/nvim-tree.lua",
    tag = 'v1.3',
    -- commit = 'b601b5a',
    config = function()
      require("user.conf.nvim-tree")
    end,
  },

  -- 语法解析
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
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
      require('hlargs').setup()
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
    commit = '81e36c3',
    config = function()
      require("user.conf.startify")
    end,
  },

  -- 搜索
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    tag = '0.1.4',
    -- or, branch = '0.1.x',
    dependencies = {
      {
        -- lsp code-action
        -- Neovim 0.9+ https://github.com/nvim-telescope/telescope-ui-select.nvim/issues/29#issuecomment-1825841303
        "nvim-telescope/telescope-ui-select.nvim",
      },
      "nvim-lua/plenary.nvim",
      {
        "BurntSushi/ripgrep",
        commit = '0415448',
      },
      {
        "sharkdp/fd",
        commit = '072c9e5',
      },

    },
    config = function()
      require("user.conf.telescope")
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
    commit = '4651801',
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
    commit = '8febc60',
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
    end,
  },
  {
    -- https://github.com/folke/trouble.nvim
    "folke/trouble.nvim",
    enable = true,
    dependencies = {
      {
        "nvim-tree/nvim-web-devicons",
        commit = "b77921fdc44833c994fdb389d658ccbce5490c16",
      },
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
    config = function()
      vim.g.bookmark_sign = ''
      vim.g.bookmark_annotation_sign = ''
      vim.g.bookmark_highlight_lines = 1
      vim.g.bookmark_no_default_key_mappings = 1
      require('telescope').load_extension('vim_bookmarks')
    end,
  },

  -- 注释
  {
    "tpope/vim-commentary",
    commit = 'e87cd90',
    event = "VeryLazy",
    config = function()
    end,
  },

  -- 终端
  {
    "voldikss/vim-floaterm",
    commit = 'ff6a871',
    event = "VeryLazy",
    config = function()
      require("user.conf.vim-floaterm")
    end,
  },

  -- Markdown preview
  {
    -- https://github.com/ellisonleao/glow.nvim
    "ellisonleao/glow.nvim",
    commit = "238070a686c1da3bccccf1079700eb4b5e19aea4",
    event = "VeryLazy",
    cmd = "Glow",
    config = function()
      require("glow").setup({
        -- style = "dark",
        -- width = 120,
      })
    end,
  },

  {
    -- https://github.com/MeanderingProgrammer/render-markdown.nvim
    "MeanderingProgrammer/render-markdown.nvim",
    cmds = { "RenderMarkdown" },
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
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
  },

  -- 平滑滚动
  {
    "psliwka/vim-smoothie",
    event = "VeryLazy",
    config = function()
      require("user.conf.vim-smoothie")
    end,
  },

  -- 单词拼写检查
  {
    "minhanghuang/spell.nvim",
    event = "VeryLazy",
    config = function()
      require("user.conf.spell")
    end,
  },
  -- -- dev单词拼写检查
  -- {
  --   dir = "/Users/cox/work/code/github/spell.nvim", -- 本地repo绝对路径
  --   name = "nvim-spell",                            -- 可选,便于识别
  --   event = "VeryLazy",
  --   config = function()
  --     require("user.conf.spell")
  --   end,
  -- },

  -- 翻译
  {
    "voldikss/vim-translator",
    event = "VeryLazy",
    config = function()
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
