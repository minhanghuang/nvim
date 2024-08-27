return {
  -- CMP
  {
    "hrsh7th/nvim-cmp",
    event = "VeryLazy",
    dependencies = {
      -- nvim-cmp
      "hrsh7th/cmp-nvim-lsp",                -- 内置lsp补全
      "hrsh7th/cmp-nvim-lua",                -- vim.lsp补全
      "hrsh7th/cmp-buffer",                  -- 代码片段
      "hrsh7th/cmp-path",                    -- 路径补全
      "hrsh7th/cmp-cmdline",                 -- 解析命令行的来源
      "hrsh7th/cmp-nvim-lsp-signature-help", -- 补全参数提示
      "hrsh7th/cmp-emoji",                   -- emoji表情(使用:xxx)
      {
        -- For luasnip users.
        "saadparwaiz1/cmp_luasnip",
        dependencies = {
          {
            "L3MON4D3/LuaSnip", -- snippets engine(不支持UltiSnip类型代码片段)
            version = "v2.*",   -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            build = "make install_jsregexp",
            dependencies = {
              {
                "honza/vim-snippets", -- 代码片段(snipMate & UltiSnip)
              },
              {
                "rafamadriz/friendly-snippets", -- 代码片段(LuaSnip)
              },
            },
          },
        }
      },
      -- lspkind
      "onsails/lspkind-nvim", -- 分类选项icon

      -- -- 补全排序
      -- {
      --   'tzachar/cmp-tabnine',
      --   build = './install.sh',
      -- },

      -- {
      --   "ray-x/lsp_signature.nvim",
      --   config = function()
      --   end
      -- }

      -- clangd拓展插件
      {
        -- https://github.com/p00f/clangd_extensions.nvim
        "p00f/clangd_extensions.nvim",
      }
    },
    config = function()
      local autopairs = require("nvim-autopairs.completion.cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      -- local compare = require('cmp.config.compare')
      local types = require("cmp.types")
      local cmp = require("cmp")

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local deprioritize_snippet = function(entry1, entry2)
        if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then
          return false
        end
        if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then
          return true
        end
      end

      -- auto pair
      cmp.event:on("confirm_done", autopairs.on_confirm_done { map_char = { tex = "" } })

      -- snippets
      luasnip.setup({
        history = true,
        delete_check_events = "TextChanged,TextChangedI",
      })
      require("luasnip.loaders.from_lua").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_snipmate").lazy_load()
      require("luasnip.loaders.from_snipmate").lazy_load({ paths = { vim.fn.stdpath("config") .. "/lua/user/cmp/snippets" } })

      -- menu: 一个弹出菜单，列出可能的自动补全项
      -- menuone: 即使只有一个匹配项，该选项也会显示弹出菜单。这对于提供有关自动补全的附加信息很有用
      -- noselect: 用户需要明确选择一个自动补全项，通过导航并按 Enter 键
      vim.opt.completeopt = { "menu", "menuone", "noselect" }

      cmp.setup({
        ghost_text = { enabled = true },

        -- 代码片段
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
          end,
        },

        -- 窗口UI
        window = {
          ---- 使用cmp.config.window 会导致悬浮窗口遮住源代码
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),

          completion = {
            border = "rounded",
            winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,FloatBorder:FloatBorder,Search:None",
            col_offset = -3,
            side_padding = 1,
            scrollbar = false,
            scrolloff = 8,
          },
          documentation = {
            border = "rounded",
            winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,Search:None",
            max_width = vim.o.columns / 2, -- 弹窗文档提示最大宽度
          },
        },

        mapping = {
          -- i: 输入模式
          -- c: 命令行模式
          -- s: 选择模式
          -- 选择下一个
          ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c", "s" }),
          -- 选择上一个
          ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c", "s" }),

          -- 向上翻页
          -- ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
          -- 向下翻页
          -- ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),

          -- 取消补全
          ["<C-e>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          },

          -- 出现补全
          -- ["<C-Space>"] = cmp.mapping.complete(),

          -- 确认使用某个补全项
          ["<CR>"] = cmp.mapping.confirm({ select = true }),

          -- 选择下一个snippet
          ["<S-j>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
              -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
              -- that way you will only jump inside the snippet region
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),

          -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
          -- 选择上一个snippet
          ["<S-k>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

        },

        -- 补全来源
        sources = cmp.config.sources({
          { name = 'nvim_lsp',                priority = 50 },
          { name = 'nvim_lua',                priority = 50 },
          { name = 'buffer',                  priority = 40 },
          { name = 'path',                    priority = 30 },
          { name = 'luasnip',                 priority = 20 },
          { name = 'emoji',                   priority = 10 },
          -- { name = 'cmp_tabnine',             priority = 10 },
          { name = 'nvim_lsp_signature_help', priority = 10 },
        }),

        sorting = {
          -- final_score = orig_score + ((#sources - (source_index - 1)) * sorting.priority_weight)
          priority_weight = 2,
          comparators = {                            -- 定义了多个比较函数，用于确定补全项的顺序。这些函数按照列表中的顺序依次应用
            -- deprioritize_snippet,                    -- 降低代码片段 (snippets) 的优先级
            cmp.config.compare.offset,               -- 补全项在文件中的位置（偏移量）进行排序
            cmp.config.compare.exact,                -- 补全项与用户输入的文本的匹配度进行排序
            cmp.config.compare.recently_used,        -- 最近使用
            require("clangd_extensions.cmp_scores"), -- clangd extensions tools
            cmp.config.compare.sort_text,            -- 补全项的排序文本进行排序
            cmp.config.compare.kind,                 -- 补全项的数据类型进行排序
            cmp.config.compare.length,               -- 补全项的长度进行排序
            cmp.config.compare.order,                -- 插件内部的预定义顺序对补全项进行排序
            cmp.config.compare.locality,             -- 局部
            cmp.config.compare.score,                -- 补全项的得分进行排序
          },
        },


        -- sorting = {
        --   priority_weight = 2,
        --   comparators = {
        --     -- require('cmp_tabnine.compare'), -- tabnine智能补全
        --     compare.locality,
        --     compare.offset,
        --     compare.exact,
        --     compare.score,
        --     compare.recently_used,
        --     compare.kind,
        --     compare.sort_text,
        --     compare.length,
        --     compare.order,
        --   },
        -- },

        -- 设置补全显示的格式,非代码格式化
        formatting = {
          fields = { cmp.ItemField.Kind, cmp.ItemField.Menu, cmp.ItemField.Abbr, },
          format = lspkind.cmp_format({
            maxwidth = vim.o.columns / 2, -- prevent the popup from showing more than provided characters
            with_text = true,
            menu = {
              nvim_lsp = "",
              nvim_lua = "",
              path = "",
              buffer = "﬘",
              vsnip = "",
              treesitter = "",
              zsh = "",
            },
          }),
        },
        experimental = { native_menu = false, ghost_text = { enabled = true } },
      })

      --根据文件类型来选择补全来源
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'buffer' }
        })
      })


      -- 命令模式下输入 `/` 启用补全
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- 命令模式下输入 `:` 启用补全
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }, {
          { name = 'cmdline' }
        })
      })
    end,
  },
}
