local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
  vim.notify("telescope not found!")
  return
end

local actions = require("telescope.actions")

telescope.setup {
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- 结果窗口 向上/下选择
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        -- 预览窗口 向上/下滚动
        ["<C-n>"] = actions.preview_scrolling_down,
        ["<C-p>"] = actions.preview_scrolling_up,
      }
    },
    -- other layout configuration here
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:

    -- find_files = {
    -- theme = "ivy",
    -- },
    live_grep = {
      theme = "dropdown",
    }
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
