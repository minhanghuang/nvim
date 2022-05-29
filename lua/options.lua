local options = {
    number = true;            -- set numbered lines
    cursorline = true;        -- highlight the current line
    shiftwidth = 2;           -- the number of spaces inserted for each indentation
    expandtab = true;         -- convert tabs to spaces  
    termguicolors = true,     -- set term gui colors (most terminals support this)
    history = 1024; 
    showcmd = true;
    showmatch = true;
    showfulltag = true;
    ruler = true;
    autoread = true;
    hlsearch = true;
    ignorecase = true;         -- ignore case in search patterns
    -- noignorecase = true;
    cmdheight = 1;             -- more space in the neovim command line for displaying messages
    encoding = "utf-8";
    fileencodings = "utf-8,gbk2312,gbk,gb18030,cp936";
    clipboard = "unnamedplus"; -- allows neovim to access the system clipboard 
    laststatus=3; -- 全局状态栏(NeoVim0.7)
    foldmethod = "expr", -- 折叠 
    foldexpr = "nvim_treesitter#foldexpr()",
    foldenable = false, 
    foldlevel = 99,
    mouse = "a",               -- allow the mouse to be used in neovim
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
    vim.opt[k] = v
end
