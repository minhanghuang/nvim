local status_ok, bdelete = pcall(require, "bufdelete")
if not status_ok then
  vim.notify("bufdelete not found!")
  return
end

-- 删除当前窗口之外的所有窗口
local function delete_hidden_buffers()
  local hidden_bufs = vim.tbl_filter(function(bufnr)
    return vim.fn.getbufinfo(bufnr)[1].hidden == 1
  end, vim.api.nvim_list_bufs())

  for _, bufnr in ipairs(hidden_bufs) do
    bdelete.bufdelete(bufnr)
  end
end

vim.api.nvim_create_user_command('BdeleteHidden', delete_hidden_buffers, { bang = true })
