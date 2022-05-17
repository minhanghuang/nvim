local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = false, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = false, -- bindings for folds, spelling and others prefixed with z
      g = false, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "W",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  s = {
    name = "Search",
    f = { "<cmd>Telescope find_files<cr>", "查找文件" },
    g = { "<cmd>Telescope live_grep<cr>", "查找字符" },
    h = { "<cmd>Telescope grep_string<cr>", "查找字符(光标所在单词)" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
  },
  r = {
    name = "Replace",
    r = { "<cmd>lua require('spectre').open_file_search()<CR>", "替换(当前文件)" },
    p = { "<cmd>lua require('spectre').open_visual({select_word=true})<CR>","替换光标所在单词(当前项目)" },
  },
  d = {
    name = "DisPlay",
    m = { ":MarkdownPreview<CR>", "Markdown Preview"},
    r = { ":NvimContextVtToggle<CR>", "括号归属"},
    t = { ":Translate<CR>", "翻译当前单词"},
  },
  g = {
    name = "Git",
      t = { ":Gitsigns toggle_current_line_blame<CR>", "(<Leader>gt)显示当前行提交记录" },
      n = { ":Gitsigns next_hunk<CR>", "下一个hunk" },
      p = { ":Gitsigns prev_hunk<CR>", "上一个hunk" },
      s = { ":Gitsigns stage_hunk<CR>", "保存hunk" },
      u = { ":Gitsigns reset_hunk<CR>", "撤销hunk" },
      h = { ":Gitsigns preview_hunk<CR>", "查看hunk" },
      d = { "<Leader>o<CR>:DiffviewOpen HEAD~", "(<Leader>gd)打开git diff" },
      c = { ":DiffviewClose<CR><Leader>o<CR>", "(<Leader>gc)关闭git diff" },
  },
  t = {
    name = "Tree",
    v = { "<C-v>", "(<C-v>)垂直打开新窗口" },   
    a = { "a", "新建文件/文件夹(文件夹后加下划线/)" },   
    o = { "o", "打开文件/文件夹" },   
    r = { "r", "修改文件名" },   
    x = { "x", "剪切" },   
    c = { "c", "复制" },   
    p = { "p", "粘贴" },   
    y = { "y", "拷贝文件名(系统剪切板)" },   
    Y = { "Y", "拷贝文件相对路径(系统剪切板)" },   
    g = { "gy", "(gy)拷贝文件绝对路径(系统剪切板)" },   
    d = { "d", "删除文件(确认)" },   
    R = { "R", "刷新" },   
    H = { "H", "显示/不显示⋅隐藏文件" },   
  },
  c = {
    name = "Code/Flod",
    g = { "<Plug>(coc-definition)", "(<Leader>gg)函数跳转" },
    r = { "<Plug>(coc-references)", "(<Leader>gr)函数引用" },
    f = { ":ClangFormat<CR>", "clang-format" },
    d = { ":Dox<CR>", "Doxygen" },
    R = { "zR", "(<S-r>)打开全部" },
    M = { "zM", "(<S-m>)折叠全部" },
    c = { "zc", "(<S-c>)折叠" },
    o = { "zo", "(<S-o>)打开" },
  },
  m = {
    name = "BookMark",
    m = { ":BookmarkToggle<CR>", "(mm)添加/取消书签" },
    t = { ":BookmarkAnnotate ", "(mt)添加书签,并注释" },
    n = { ":BookmarkNext<CR>", "(mn)下一个书签" },
    p = { ":BookmarkPrev<CR>", "(mp)上一个书签" },
    a = { ":BookmarkShowAll<CR>", "(ma)展示所有书签" },
    c = { ":BookmarkClearAll<CR>", "(mc)取消所有书签" },
  }
}

which_key.setup(setup)
which_key.register(mappings, opts)

