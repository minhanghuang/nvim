return {
  -- 自动保存
  {
    "Pocco81/auto-save.nvim",
    commit = '979b6c8',
    config = function()
      require("user.conf.autosave")
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
    commit = '417b303',
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

  -- diffview
  {
    "sindrets/diffview.nvim",
    commit = "63720aa",
    config = function()
      require("user.conf.diffview")
    end,
  },

  -- git
  {
    "lewis6991/gitsigns.nvim",
    commit = '372d5cb',
    config = function()
      require("user.conf.gitsigns")
    end,
  },

  -- formatting
  {
    "mhartington/formatter.nvim",
    config = function()
      require("user.conf.formatter")
    end,
  },

  -- -- formatting
  -- {
  --   "sbdchd/neoformat",
  --   config = function()
  --     require("user.conf.neoformat")
  --   end,
  -- },

  -- 缩进提示
  {
    "lukas-reineke/indent-blankline.nvim",
    commit = '4541d69',
    config = function()
      vim.opt.list = true
      require("indent_blankline").setup {
        show_end_of_line = true,
        space_char_blankline = " ",
      }
    end,
  },

  -- snippets engine
  {
    "L3MON4D3/LuaSnip",
    version = "2.*",
    dependencies = {
      "honza/vim-snippets",          -- 代码片段(snipMate & UltiSnip)
      "rafamadriz/friendly-snippets" -- 代码片段(LuaSnip)
    },
    event = "VeryLazy",
    build = "make install_jsregexp",
    config = function()
      require("luasnip").setup({
        history = true,
        delete_check_events = "TextChanged,TextChangedI",
      })
      require("luasnip.loaders.from_lua").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_snipmate").lazy_load()
      require("luasnip.loaders.from_snipmate").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
    end,
  },

  -- 添加函数接口说明
  {
    "danymat/neogen",
    commit = '9c17225',
    event = "VeryLazy",
    config = function()
      require("neogen").setup()
    end,
  },

  -- 搜索美化
  {
    "kevinhwang91/nvim-hlslens",
    commit = '1b629c0c28c4c5aa7923043e00a9e388b0ad937a',
    config = function()
      require("user.conf.nvim-hlslens")
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

  -- 文件树
  {
    "nvim-tree/nvim-tree.lua",
    commit = 'b601b5a',
    config = function()
      require("user.conf.nvim-tree")
    end,
  },

  -- 语法解析
  {
    "nvim-treesitter/nvim-treesitter",
    commit = '0efa55a',
    config = function()
      require("user.conf.nvim-treesitter")
    end,
  },

  -- 显示代码上下文
  {
    -- https://github.com/nvim-treesitter/nvim-treesitter-context
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("user.conf.nvim-treesitter-context")
    end,
  },

  -- icon
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("user.conf.nvim-web-devicons")
    end,
  },

  -- 断点持久化
  {
    "Weissle/persistent-breakpoints.nvim",
    commit = 'a6091f7',
    event = "VeryLazy",
    config = function()
      require("user.conf.persistent-breakpoints")
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
    tag = '0.1.4',
    -- or, branch = '0.1.x',
    dependencies = {
      {
        -- lsp code-action
        -- Neovim 0.9+ https://github.com/nvim-telescope/telescope-ui-select.nvim/issues/29#issuecomment-1825841303
        "nvim-telescope/telescope-ui-select.nvim",
      },
      {
        "nvim-lua/plenary.nvim",
        commit = '9ac3e95',
      },
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
    end,
  },

  -- TODO LIST
  {
    "folke/todo-comments.nvim",
    commit = '8febc60',
    config = function()
      require("user.conf.todo-comments")
    end,
  },

  -- 书签
  {
    -- https://github.com/MattesGroeger/vim-bookmarks
    "MattesGroeger/vim-bookmarks",
    commit = '9cc5fa7',
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
    config = function()
      require("user.conf.vim-commentary")
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

  -- 平滑滚动
  {
    "psliwka/vim-smoothie",
    config = function()
      require("user.conf.vim-smoothie")
    end,
  },

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
    commit = '20d628f',
    config = function()
      require('wlsample.airline')
      -- require('wlsample.airline_anim')
      -- require('wlsample.airline_luffy')
      -- require('wlsample.basic')
      -- require('wlsample.wind')
      -- require('wlsample.bubble')
      -- require('wlsample.bubble2')
      -- require('wlsample.simple')
      -- require('wlsample.vscode')
      -- require('wlsample.rainbow')
    end,
  },
}
