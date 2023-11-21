return {
  -- CMP
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- nvim-cmp
      "hrsh7th/cmp-nvim-lsp", -- 内置lsp补全
      "hrsh7th/cmp-buffer",   -- 代码片段
      "hrsh7th/cmp-path",     -- 路径补全
      "hrsh7th/cmp-cmdline",  -- 解析命令行的来源
      {
        -- For luasnip users.
        "saadparwaiz1/cmp_luasnip",
        dependencies = {
          "L3MON4D3/LuaSnip",
        }
      },
      -- lspkind
      "onsails/lspkind-nvim", -- 分类选项icon

      -- {
      --   "ray-x/lsp_signature.nvim",
      --   config = function()
      --   end
      -- }
    },
    config = function()
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      local cmp = require("cmp")

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      vim.o.completeopt = "menu,menuone,noselect"

      cmp.setup({
        ghost_text = { enabled = true },

        -- 代码片段
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          end,
        },

        -- 窗口UI
        window = {
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
          { name = 'nvim_lsp', priority = 50 },
          { name = 'path',     priority = 40 },
          { name = 'luasnip',  priority = 30 },
          {
            { name = "buffer", priority = 50, keyword_length = 5, max_item_count = 5 },
            { name = 'emoji',  insert = true, priority = 20 },
          },
        }),

        -- 设置补全显示的格式,非代码格式化
        formatting = {
          fields = { cmp.ItemField.Menu, cmp.ItemField.Abbr, cmp.ItemField.Kind },
          format = lspkind.cmp_format({
            with_text = true,
            menu = {
              nvim_lsp = "",
              nvim_lua = "",
              path = "ﱮ",
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
