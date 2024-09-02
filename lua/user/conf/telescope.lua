local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
  vim.notify("telescope not found!")
  return
end

local actions = require("telescope.actions")
local sorters = require('telescope.sorters')
-- local trouble = require("trouble.sources.telescope")

-- 参考: https://github.com/sxyazi/dotfiles/blob/main/nvim/lua/plugins/ui.lua#L267
telescope.setup {
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      -- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua#L133
      i = {
        -- 关闭telescope窗口
        ["<esc>"] = actions.close,
        -- 结果窗口 向上/下选择
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        -- 预览窗口 向上/下滚动
        ["<C-n>"] = actions.preview_scrolling_down,
        ["<C-p>"] = actions.preview_scrolling_up,
        -- 查看历史
        ["<C-u>"] = actions.cycle_history_prev,
        ["<C-e>"] = actions.cycle_history_next,
      }
    },
    -- other layout configuration here
  },
  -- sorter using fzy algorithm
  file_sorter = sorters.get_fuzzy_file,
  generic_sorter = require 'telescope.sorters'.get_generic_fuzzy_sorter,

  file_ignore_patterns = { '__pycache__', 'node_modules', '.cache', 'build' },

  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- themes: dropdown cursor ivy

    find_files = {
      -- theme = "ivy",
      previewer = true,
    },
    live_grep = {
      theme = "dropdown",
    },

    -- lsp_references = { theme = "ivy" },
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure


    -- lsp code-action
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      },
      -- pseudo code / specification for writing custom displays, like the one
      -- for "codeactions"
      -- specific_opts = {
      --   [kind] = {
      --     make_indexed = function(items) -> indexed_items, width,
      --     make_displayer = function(widths) -> displayer
      --     make_display = function(displayer) -> function(e)
      --     make_ordinal = function(e) -> string
      --   },
      --   -- for example to disable the custom builtin "codeactions" display
      --      do the following
      --   codeactions = false,
      -- }
    }
  }
}

require("telescope").load_extension("ui-select")
