local options = {
    number = true;
    cursorline = true;
    shiftwidth = 2;
    expandtab = true;
    history = 1024;
    showcmd = true;
    showmatch = true;
    showfulltag = true;
    ruler = true;
    autoread = true;
    hlsearch = true;
    ignorecase = true;
    -- noignorecase = true;
    cmdheight = 1;
    encoding = "utf-8";
    fileencodings = "utf-8,gbk2312,gbk,gb18030,cp936";
    clipboard = "unnamedplus"; -- allows neovim to access the system clipboard 
}


for k, v in pairs(options) do
  vim.opt[k] = v
end

