local M = {}
local dap = require 'dap'

-- refresh config
M.reload_continue = function()
  package.loaded['user.dap.dap-config'] = nil
  require('user.dap.dap-config').setup()
  dap.continue()
end

-- support passing args
M.find_next_start = function(str, cur_idx)
  while cur_idx <= #str and str:sub(cur_idx, cur_idx) == ' ' do
    cur_idx = cur_idx + 1
  end
  return cur_idx
end

--  vim.fn.split(argument_string, " ", true)
M.str2argtable = function(str)
  -- trim spaces
  str = string.gsub(str, '^%s*(.-)%s*$', '%1')
  local arg_list = {}

  local start = 1
  local i = 1
  local quote_refs_cnt = 0
  while i <= #str do
    local c = str:sub(i, i)
    if c == '"' then
      quote_refs_cnt = quote_refs_cnt + 1
      start = i
      i = i + 1
      -- find next quote
      while i <= #str and str:sub(i, i) ~= '"' do
        i = i + 1
      end
      if i <= #str then
        quote_refs_cnt = quote_refs_cnt - 1
        arg_list[#arg_list + 1] = str:sub(start, i)
        start = M.find_next_start(str, i + 1)
        i = start
      end
      -- find next start
    elseif c == ' ' then
      arg_list[#arg_list + 1] = str:sub(start, i - 1)
      start = M.find_next_start(str, i + 1)
      i = start
    else
      i = i + 1
    end
  end

  -- add last arg if possiable
  if start ~= i and quote_refs_cnt == 0 then
    arg_list[#arg_list + 1] = str:sub(start, i)
  end
  return arg_list
end

return M
