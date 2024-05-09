local has_nvim_tree, nvim_tree = pcall(require, "nvim-tree")
if not has_nvim_tree then
  vim.notify("nvim-tree.lua not found!")
  return
end

local api = require("nvim-tree.api")

-- local function live_grep_the_node_cb(node)
--   require('user.util').telescope('live_grep',
--     { prompt_title = "Search Path:" .. node.absolute_path, search_dirs = { node.absolute_path } })
-- end
-- local function find_files_the_node_cb(node)
--   require('user.util').telescope('find_files',
--     { search_dirs = { node.absolute_path } })
-- end

local function live_grep_the_node_cb()
  local node = api.tree.get_node_under_cursor()
  require('user.util').telescope('live_grep',
    { prompt_title = "Search Path:" .. node.absolute_path, search_dirs = { node.absolute_path } })
end

local function find_files_the_node_cb()
  local node = api.tree.get_node_under_cursor()
  require('user.util').telescope('find_files',
    { search_dirs = { node.absolute_path } })
end

local function on_attach(bufnr)
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- 不使用默认快捷键, 默认快捷键会和自定义的快捷键产生冲突
  -- default mappings
  -- api.config.mappings.default_on_attach(bufnr)

  -- removals mappings
  -- vim.keymap.del('n', '<C-]>', { buffer = bufnr })

  -- custom mappings
  vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opts('Open: In Place'))
  -- 显示当前文件信息, 快捷键有冲突
  -- vim.keymap.set('n', '<C-k>', api.node.show_info_popup, opts('Info'))
  vim.keymap.set('n', '<C-f>', api.node.show_info_popup, opts('Info'))
  vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
  vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
  vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
  vim.keymap.set('n', '<C-o>', api.node.navigate.parent_close, opts('Close Directory'))
  -- vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
  vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
  vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
  vim.keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))
  vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
  vim.keymap.set('n', 'a', api.fs.create, opts('Create File Or Directory'))
  vim.keymap.set('n', 'bd', api.marks.bulk.delete, opts('Delete Bookmarked'))
  vim.keymap.set('n', '<C-f>', api.node.show_info_popup, opts('Info'))
  vim.keymap.set('n', 'bt', api.marks.bulk.trash, opts('Trash Bookmarked'))
  vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
  vim.keymap.set('n', 'B', api.tree.toggle_no_buffer_filter, opts('Toggle Filter: No Buffer'))
  vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
  vim.keymap.set('n', 'C', api.tree.toggle_git_clean_filter, opts('Toggle Filter: Git Clean'))
  vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
  vim.keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
  vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
  vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
  vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
  vim.keymap.set('n', 'e', api.fs.rename_basename, opts('Rename: Basename'))
  vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
  vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
  vim.keymap.set('n', 'F', api.live_filter.clear, opts('Live Filter: Clear'))
  -- vim.keymap.set('n', 'f', api.live_filter.start, opts('Live Filter: Start'))
  vim.keymap.set('n', 'fa', api.live_filter.start, opts('Live Filter: Start'))
  vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
  vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
  vim.keymap.set('n', 'ge', api.fs.copy.basename, opts('Copy Basename'))
  vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Filter: Dotfiles'))
  vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Filter: Git Ignore'))
  vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
  vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
  vim.keymap.set('n', 'L', api.node.open.toggle_group_empty, opts('Toggle Group Empty'))
  vim.keymap.set('n', 'M', api.tree.toggle_no_bookmark_filter, opts('Toggle Filter: No Bookmark'))
  vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
  vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
  vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
  vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
  -- vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
  vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
  vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
  vim.keymap.set('n', 's', api.node.run.system, opts('Run System'))
  vim.keymap.set('n', 'S', api.tree.search_node, opts('Search'))
  vim.keymap.set('n', 'u', api.fs.rename_full, opts('Rename: Full Path'))
  vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Filter: Hidden'))
  vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
  vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
  vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
  vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
  vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))

  -- 自定义方法
  vim.keymap.set('n', 'fs', live_grep_the_node_cb, opts("live grep"))
  vim.keymap.set('n', 'ff', find_files_the_node_cb, opts("find files"))
end

nvim_tree.setup({
  on_attach           = on_attach,
  -- disables netrw completely
  disable_netrw       = false,
  -- hijack netrw window on startup
  hijack_netrw        = true,
  -- open the tree when running this setup function
  -- open_on_setup       = true,
  -- will not open on setup if the filetype is in this list
  -- ignore_ft_on_setup  = {},
  -- closes neovim automatically when the tree is the last **WINDOW** in the view
  -- auto_close          = false, -- 新版本插件删除自动关闭功能
  -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
  open_on_tab         = true,
  -- hijacks new directory buffers when they are opened.
  -- update_to_buf_dir   = {
  -- 	-- enable the feature
  -- 	enable = true,
  -- 	-- allow to open the tree if it was previously closed
  -- 	auto_open = true,
  -- },
  -- hijack the cursor in the tree to put it at the start of the filename
  hijack_cursor       = false,
  -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
  update_cwd          = false,
  -- show lsp diagnostics in the signcolumn
  -- lsp_diagnostics     = false,
  -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
  update_focused_file = {
    -- enables the feature
    enable      = false,
    -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
    -- only relevant when `update_focused_file.enable` is true
    update_cwd  = false,
    -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
    -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
    ignore_list = {}
  },
  -- configuration options for the system open command (`s` in the tree by default)
  system_open         = {
    -- the command to run this, leaving nil should work in most cases
    cmd  = nil,
    -- the command arguments as a list
    args = {}
  },
  git                 = {
    enable = true,
    -- 显示被git忽略的文件
    ignore = false,
    timeout = 500,
  },
  view                = {
    -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
    width = 30,
    -- height of the window, can be either a number (columns) or a string in `%`, for top or bottom side placement
    -- height = 30,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left',
    -- if true the tree will resize itself after opening a file
    -- auto_resize = true,
    -- -----
    -- v1.3后删除mappings
    -- -----
    -- mappings = {
    --   -- custom only false will merge the list with the default mappings
    --   -- if true, it will only use your list to set the mappings
    --   custom_only = true,
    --   -- list of mappings to set on the tree manually
    --   list = {
    --     { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
    --     { key = "<C-e>",                          action = "edit_in_place" },
    --     { key = { "O" },                          action = "edit_no_picker" },
    --     { key = { "<2-RightMouse>", "<C-]>" },    action = "cd" },
    --     { key = "<C-v>",                          action = "vsplit" },
    --     { key = "<C-x>",                          action = "split" },
    --     { key = "<C-t>",                          action = "tabnew" },
    --     { key = "<",                              action = "prev_sibling" },
    --     { key = ">",                              action = "next_sibling" },
    --     { key = "P",                              action = "parent_node" },
    --     { key = "<C-o>",                          action = "close_node" },
    --     { key = "<Tab>",                          action = "preview" },
    --     { key = "K",                              action = "first_sibling" },
    --     { key = "J",                              action = "last_sibling" },
    --     { key = "I",                              action = "toggle_git_ignored" },
    --     { key = "H",                              action = "toggle_dotfiles" },
    --     { key = "R",                              action = "refresh" },
    --     { key = "a",                              action = "create" },
    --     { key = "d",                              action = "remove" },
    --     { key = "D",                              action = "trash" },
    --     { key = "r",                              action = "rename" },
    --     { key = "<C-r>",                          action = "full_rename" },
    --     { key = "x",                              action = "cut" },
    --     { key = "c",                              action = "copy" },
    --     { key = "p",                              action = "paste" },
    --     { key = "y",                              action = "copy_name" },
    --     { key = "Y",                              action = "copy_path" },
    --     { key = "gy",                             action = "copy_absolute_path" },
    --     { key = "[c",                             action = "prev_git_item" },
    --     { key = "]c",                             action = "next_git_item" },
    --     { key = "-",                              action = "dir_up" },
    --     { key = "fs",                             action = "live_grep_the_node",  action_cb = live_grep_the_node_cb },
    --     { key = "ff",                             action = "find_files_the_node", action_cb = find_files_the_node_cb },
    --     { key = "S",                              action = "search_node" },
    --     { key = "F",                              action = "clear_live_filter" },
    --     { key = "q",                              action = "close" },
    --     { key = "g?",                             action = "toggle_help" },
    --     { key = "W",                              action = "collapse_all" },
    --     { key = "K",                              action = "toggle_file_info" },
    --     { key = ".",                              action = "run_file_command" }
    --   }
    -- }
  }
})
