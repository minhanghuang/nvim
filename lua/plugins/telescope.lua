local actions = require "telescope.actions"

require('telescope').setup {
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- 结果窗口 向上/下选择
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        -- 预览窗口 向上/下滚动
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
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
  }
}
