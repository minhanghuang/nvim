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
    config = function()
      require("user.conf.autopairs")
    end,
    enabled = true,
    dependencies = { "nvim-treesitter/nvim-treesitter", "hrsh7th/nvim-cmp" },
  },

  -- 删除Buffer
  {
    "famiu/bufdelete.nvim",
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

  -- Buffer
  {
    "akinsho/bufferline.nvim",
    commit = '417b303',
    config = function()
      require("user.conf.bufferline")
    end,
  },

  -- Coc
  {
    "neoclide/coc.nvim",
    tag = "v0.0.81",
    config = function()
      vim.g.coc_global_extensions = {
        'coc-vetur', -- vue
        'coc-sumneko-lua@0.0.30',
        'coc-json',
        'coc-css@1.3.0',
        'coc-clangd@0.25.0',
        'coc-cmake',
        'coc-yaml',
        'coc-sh@1.0.0',
        'coc-highlight@1.3.0',
        'coc-markdownlint',
        'coc-emmet',
        'coc-html',
        'coc-pyright',
        'coc-translator',
        'coc-snippets',
        'coc-xml',
        'coc-spell-checker', -- 单词校验
      }

      -- <C-j> <C-k> 冲突
      vim.g.coc_snippet_prev = '<S-j>'
      vim.g.coc_snippet_next = '<S-k>'
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

  -- {
  --   "L3MON4D3/LuaSnip",
  --   version = "2.*",
  --   dependencies = { "rafamadriz/friendly-snippets" },
  --   event = "VeryLazy",
  --   config = function()
  --     require("luasnip").setup({
  --       history = true,
  --       delete_check_events = "TextChanged,TextChangedI",
  --     })
  --     require("luasnip.loaders.from_vscode").lazy_load()
  --     -- 自定义代码片段需要将`endsnippet`删除并缩进一级(https://github.com/L3MON4D3/LuaSnip/wiki/Migrating-from-UltiSnips#snippets)
  --     -- 这将和coc.snippets冲突
  --     require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
  --   end,
  -- },

  -- 添加函数接口说明
  {
    "danymat/neogen",
    commit = '9c17225',
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

  -- icon
  {
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("user.conf.nvim-web-devicons")
    end,
  },

  -- 断点持久化
  {
    "Weissle/persistent-breakpoints.nvim",
    commit = 'a6091f7',
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
    commit = '6258d50',
    dependencies = {
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
    "MattesGroeger/vim-bookmarks",
    commit = '9cc5fa7',
    config = function()
      require("user.conf.vim-bookmarks")
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

  -- 底部状态栏
  {
    "windwp/windline.nvim",
    commit = '20d628f',
    config = function()
      local windline = require('windline')
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
