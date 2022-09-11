local ftMap = {
    vim = 'indent',
    python = {'indent'},
    git = ''
}

require('ufo').setup({
open_fold_hl_timeout = 150,
    close_fold_kinds = {'imports', 'comment'},
    preview = {
        win_config = {
          border = {'', '─', '', '', '', '─', '', ''},
          winhighlight = 'Normal:Folded',
          winblend = 0
        },
    },
    provider_selector = function(bufnr, filetype, buftype)
      return ftMap[filetype]
    end
})

vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

