local bdelete = require('bufdelete').bufdelete

-- 删除当前窗口之外的所有窗口
local function delete_hidden_buffers()
  local hidden_bufs = vim.tbl_filter(function(bufnr)
    return vim.fn.getbufinfo(bufnr)[1].hidden == 1
  end, vim.api.nvim_list_bufs())

  for _, bufnr in ipairs(hidden_bufs) do
    bdelete(bufnr)
  end
end

vim.api.nvim_create_user_command('BdeleteHidden', delete_hidden_buffers, { bang = true })

