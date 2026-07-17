vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap.set

-- ============================================================
-- Movement & Navigation
-- ============================================================

-- Fast vertical movement (10 lines)
keymap("n", "<C-j>", "10j", { desc = "Move 10 lines down", silent = true })
keymap("v", "<C-j>", "10j", { desc = "Move 10 lines down", silent = true })
keymap("n", "<C-k>", "10k", { desc = "Move 10 lines up", silent = true })
keymap("v", "<C-k>", "10k", { desc = "Move 10 lines up", silent = true })

-- Jump to line start/end
keymap("n", "<C-h>", "^", { desc = "Jump to line start", silent = true })
keymap("n", "<C-l>", "$", { desc = "Jump to line end", silent = true })
keymap("v", "<C-h>", "^", { desc = "Jump to line start", silent = true })
keymap("v", "<C-l>", "$", { desc = "Jump to line end", silent = true })

-- Insert mode arrow keys
keymap("i", "<C-h>", "<Left>", { desc = "Move left", silent = true })
keymap("i", "<C-j>", "<Down>", { desc = "Move down", silent = true })
keymap("i", "<C-k>", "<Up>", { desc = "Move up", silent = true })
keymap("i", "<C-l>", "<Right>", { desc = "Move right", silent = true })

-- Insert mode paging
keymap("i", "<C-b>", "<PageUp>", { desc = "Page up", silent = true })
keymap("i", "<C-f>", "<PageDown>", { desc = "Page down", silent = true })

-- Buffer cycling
keymap("n", "<C-n>", ":BufferLineCycleNext<CR>", { desc = "Next buffer", silent = true })
keymap("i", "<C-n>", "<Esc>:BufferLineCycleNext<CR>i", { desc = "Next buffer", silent = true })
keymap("n", "<C-p>", ":BufferLineCyclePrev<CR>", { desc = "Previous buffer", silent = true })
keymap("i", "<C-p>", "<Esc>:BufferLineCyclePrev<CR>i", { desc = "Previous buffer", silent = true })

-- ============================================================
-- Editing Operations
-- ============================================================

-- Preserve visual selection after indent/dedent
keymap("v", ">", ">gv", { desc = "Indent and reselect", silent = true })
keymap("v", "<", "<gv", { desc = "Dedent and reselect", silent = true })

-- Select all
keymap("n", "<C-a>", "ggVG$", { desc = "Select all", silent = true })
keymap("i", "<C-a>", "<Esc>ggVG$", { desc = "Select all", silent = true })

-- Duplicate line
keymap("n", "<C-d>", "yyp", { desc = "Duplicate line", silent = true })

-- Open line below without leaving normal mode
keymap("n", "o", "o<Esc>", { desc = "Insert line below", silent = true })

-- Fix common diw mistype (dwi → diw)
keymap("n", "dwi", "diw", { desc = "Delete inner word", silent = true })

-- Clear search highlight (keep silent=false to show ":nohlsearch" feedback)
-- keymap("n", "<C-c>", ":nohlsearch<CR>", { desc = "Clear search highlight", silent = false })
keymap("n", "<C-c>", function()
  Snacks.notifier.hide()
  vim.cmd('nohlsearch')
  vim.api.nvim_echo({ { ":nohlsearch", "Normal" } }, false, {})
end, { desc = "Clear search highlight", silent = false })

-- ============================================================
-- System Clipboard
-- ============================================================

keymap("n", "<Leader><Leader>y", '"+y', { desc = "Yank to system clipboard", silent = true })
keymap("n", "<Leader><Leader>p", '"+p', { desc = "Paste from system clipboard", silent = true })

-- ============================================================
-- Window Resizing
-- ============================================================

keymap({ "n", "t" }, "<S-Up>", function() vim.cmd('resize +2') end, { desc = "Decrease window height", silent = true })
keymap({ "n", "t" }, "<S-Down>", function() vim.cmd('resize -2') end, { desc = "Increase window height", silent = true })
keymap("n", "<S-Left>", function() vim.cmd('NvimTreeResize -2') end, { desc = "Decrease NvimTree width", silent = true })
keymap("n", "<S-Right>", function() vim.cmd('NvimTreeResize +2') end, { desc = "Increase NvimTree width", silent = true })

-- ============================================================
-- Escape / Mode Switching
-- ============================================================

-- <C-[> 取代 <C-;>
keymap({ "i", "v" }, "<C-;>", "<Esc>", { desc = "Exit to normal mode", silent = true })
keymap("t", "<C-;>", "<C-\\><C-n>", { desc = "Exit terminal mode", silent = true })
keymap({ "i", "v" }, "<C-[>", "<Esc>", { desc = "Exit to normal mode", silent = true })
keymap("t", "<C-[>", "<C-\\><C-n>", { desc = "Exit terminal mode", silent = true })
keymap("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode", silent = true })

-- Terminal window switch
keymap("t", "<C-w>", "<C-\\><C-n><C-w>w", { desc = "Switch window", silent = true })

-- ============================================================
-- File Explorer (NvimTree)
-- ============================================================

keymap("n", "<Leader>o", function() vim.cmd('NvimTreeToggle') end, { desc = "Toggle NvimTree", silent = true })
keymap("n", "<Leader><Leader>o", function() require('user.util').nvim_tree_find_file() end,
  { desc = "Find file in NvimTree", silent = true })
keymap("n", "<Leader><Leader>r", function() require('user.util').nvim_tree_goto_root() end,
  { desc = "Go to project root in NvimTree", silent = true })

-- ============================================================
-- Search & Find (Telescope)
-- ============================================================

keymap("n", "<Leader>ff", function() require('user.util').telescope('find_files', {}) end,
  { desc = "Find files", silent = true })
keymap("n", "<Leader>fs", function() require('user.util').telescope('live_grep', {}) end,
  { desc = "Live grep (all files)", silent = true })
keymap("n", "<Leader>fj", function() require('user.util').telescope('live_grep', { grep_open_files = true }) end,
  { desc = "Live grep (open files)", silent = true })
keymap("n", "<Leader>ft", function() vim.cmd('TodoTelescope') end, { desc = "Search TODOs", silent = true })
keymap("n", "<Leader>fc", function() vim.cmd('Telescope neoclip') end,
  { desc = "Search clipboard history", silent = true })

-- ============================================================
-- Search & Replace (Spectre)
-- ============================================================

keymap("n", "<Leader>wr", function() require('spectre').toggle() end,
  { desc = "Toggle Spectre", silent = true })
keymap("n", "<Leader>wc", function() require('spectre').open_visual({ select_word = true }) end,
  { desc = "Spectre: search word under cursor", silent = true })
keymap("n", "<Leader>wf", function() require('spectre').open_file_search({ select_word = true }) end,
  { desc = "Spectre: search in current file", silent = true })

-- ============================================================
-- Debugging (DAP)
-- ============================================================

keymap("n", "<Leader>db", function()
    require('persistent-breakpoints.api').toggle_breakpoint()
    vim.cmd('normal! j')
  end,
  { desc = "Toggle breakpoint", silent = true })
keymap("n", "<Leader>dB", function() require('persistent-breakpoints.api').clear_all_breakpoints() end,
  { desc = "Clear all breakpoints", silent = true })
keymap("n", "<Leader>de", function() require('dapui').eval() end,
  { desc = "Evaluate variable under cursor", silent = true })
keymap("n", "<Leader>dg", function() require('dap').continue() end,
  { desc = "Continue / start debugging", silent = true })
keymap("n", "<Leader>di", function() require('dap').step_into() end,
  { desc = "Step into", silent = true })
keymap("n", "<Leader>dn", function() require('dap').step_over() end,
  { desc = "Step over", silent = true })
keymap("n", "<Leader>do", function() require('dap').step_out() end,
  { desc = "Step out", silent = true })
keymap("n", "<Leader>dp", function() require('dap').step_back() end,
  { desc = "Step back", silent = true })
keymap("n", "<Leader>dr", function() require('dap').run_last() end,
  { desc = "Run last configuration", silent = true })
keymap("n", "<Leader>dc", function() require('dap').run_to_cursor() end,
  { desc = "Run to cursor", silent = true })
keymap("n", "<Leader>dd", function() require('user.dap.util').close_all() end,
  { desc = "Close DAP session", silent = true })
keymap("n", "<Leader>ds", function() require('user.dap.util').clear_breakpoints_and_continue() end,
  { desc = "Clear breakpoints and continue", silent = true })

-- ============================================================
-- Buffer Management
-- ============================================================

keymap("n", "<Leader>fd", function() Snacks.bufdelete({ force = true }) end,
  { desc = "Delete buffer", silent = true })
keymap("n", "<Leader>bmn", function() vim.cmd('BufferLineMoveNext') end,
  { desc = "Move buffer right", silent = true })
keymap("n", "<Leader>bmp", function() vim.cmd('BufferLineMovePrev') end, { desc = "Move buffer left", silent = true })
keymap("n", "<Leader>bb", function() vim.cmd('BufferLineSortByDirectory') end,
  { desc = "Sort buffers by directory", silent = true })
keymap("n", "<Leader>bo", function() vim.cmd('BdeleteHidden') end, { desc = "Delete hidden buffers", silent = true })

-- ============================================================
-- Git
-- ============================================================

keymap("n", "<Leader>gt", function() vim.cmd("Gitsigns toggle_current_line_blame") end,
  { desc = "Toggle current line blame", silent = true })
keymap("n", "<Leader>gn", function() vim.cmd("Gitsigns nav_hunk next") end,
  { desc = "Next hunk", silent = true })
keymap("n", "<Leader>gp", function() vim.cmd("Gitsigns nav_hunk prev") end,
  { desc = "Previous hunk", silent = true })
keymap("n", "<Leader>gs", function() vim.cmd("Gitsigns stage_hunk") end,
  { desc = "Stage hunk", silent = true })
keymap("n", "<Leader>gu", function() vim.cmd("Gitsigns reset_hunk") end,
  { desc = "Reset hunk", silent = true })
keymap("n", "<Leader>gh", function() vim.cmd("Gitsigns preview_hunk") end,
  { desc = "Preview hunk", silent = true })
keymap("n", "<Leader>gb", function() vim.cmd("Gitsigns blame") end,
  { desc = "Git blame (full)", silent = true })
keymap("n", "<Leader>gj",
  function()
    require('gitsigns').blame_line({ full = true, ignore_whitespace = true })
  end,
  { desc = "Git blame line", silent = true })
keymap("n", "<Leader>gd", function()
    vim.cmd("NvimTreeToggle")
    vim.cmd("DiffviewOpen HEAD~")
  end,
  { desc = "Open git diff", silent = true })
keymap("n", "<Leader>gc", function()
    vim.cmd("DiffviewClose")
    vim.cmd("NvimTreeToggle")
  end,
  { desc = "Close git diff", silent = true })
keymap("n", "<Leader>gg", function() vim.cmd("LazyGit") end, { desc = "Open LazyGit UI", silent = true })

-- ============================================================
-- Terminal
-- ============================================================

keymap("t", "<Leader>tw", "<C-\\><C-n>:FloatermNew<CR>", { desc = "New floaterm", silent = true })
keymap("t", "<Leader>tt", "<C-\\><C-n>:FloatermToggle<CR>", { desc = "Toggle floaterm", silent = true })
keymap("n", "<Leader>tt", ":FloatermToggle<CR>", { desc = "Toggle floaterm", silent = true })
keymap("t", "<Leader>tk", "<C-\\><C-n>:FloatermKill<CR>:FloatermToggle<CR>", { desc = "Kill floaterm", silent = true })

-- ============================================================
-- Comments
-- ============================================================

-- C-/ toggle comment (normal, insert, visual)
keymap("n", "<C-/>", "gcc<CR>", { desc = "Toggle comment", silent = true, remap = true })
keymap("i", "<C-/>", "<Esc>gcc<CR>i", { desc = "Toggle comment", silent = true, remap = true })
keymap("v", "<C-/>", "gc", { desc = "Toggle comment", silent = true, remap = true })

-- C-_ toggle comment (Ubuntu desktop compatibility alias)
keymap("n", "<C-_>", "gcc<CR>", { desc = "Toggle comment", silent = true, remap = true })
keymap("i", "<C-_>", "<Esc>gcc<CR>i", { desc = "Toggle comment", silent = true, remap = true })
keymap("v", "<C-_>", "gc", { desc = "Toggle comment", silent = true, remap = true })

-- ============================================================
-- Folding
-- ============================================================

keymap("n", "<S-c>", "zc", { desc = "Fold close", silent = true })
keymap("n", "<S-o>", "zo", { desc = "Fold open", silent = true })
keymap("n", "<S-r>", "zR", { desc = "Fold open all", silent = true })
keymap("n", "<S-m>", "zM", { desc = "Fold close all", silent = true })

-- ============================================================
-- Bookmarks
-- ============================================================

keymap("n", "mm", function() vim.cmd("BookmarkToggle") end, { desc = "Toggle bookmark", silent = true })
keymap("n", "mt", function() vim.cmd("BookmarkAnnotate") end, { desc = "Add bookmark annotation", silent = true })
keymap("n", "mc", function() vim.cmd("BookmarkClear") end, { desc = "Clear buffer bookmarks", silent = true })
keymap("n", "mx", function() vim.cmd("BookmarkClearAll") end, { desc = "Clear all bookmarks", silent = true })
keymap("n", "mn", function() vim.cmd("BookmarkNext") end, { desc = "Next bookmark", silent = true })
keymap("n", "mp", function() vim.cmd("BookmarkPrev") end, { desc = "Previous bookmark", silent = true })
keymap("n", "ma", function() require("telescope").extensions.vim_bookmarks.current_file() end,
  { desc = "Show bookmarks (current file)", silent = true })

-- ============================================================
-- Code Generation & Translation
-- ============================================================

-- Generate annotations (neogen)
keymap("n", "<Leader>aa", function() require('neogen').generate() end, { desc = "Generate annotations", silent = true })

-- Translate (zh)
keymap("n", "<C-t>", function() vim.cmd("TranslateW") end, { desc = "Translate word", silent = true })
keymap("v", "<C-t>", function() vim.cmd("TranslateWV") end, { desc = "Translate selection", silent = true })
