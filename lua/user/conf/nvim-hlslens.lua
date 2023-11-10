local kopts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', 'n',
  [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
  kopts)
vim.api.nvim_set_keymap('n', 'N',
  [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
  kopts)
vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

vim.api.nvim_set_keymap('n', '<Leader>l', ':noh<CR>', kopts)

-- require('hlslens').setup({
--     override_lens = function(render, posList, nearest, idx, relIdx)
--         local sfw = vim.v.searchforward == 1
--         local indicator, text, chunks
--         local absRelIdx = math.abs(relIdx)
--         if absRelIdx > 1 then
--             indicator = ('%d%s'):format(absRelIdx, sfw ~= (relIdx > 1) and '▲' or '▼')
--         elseif absRelIdx == 1 then
--             indicator = sfw ~= (relIdx == 1) and '▲' or '▼'
--         else
--             indicator = ''
--         end

--         local lnum, col = unpack(posList[idx])
--         if nearest then
--             local cnt = #posList
--             if indicator ~= '' then
--                 text = ('[%s %d/%d]'):format(indicator, idx, cnt)
--             else
--                 text = ('[%d/%d]'):format(idx, cnt)
--             end
--             chunks = {{' ', 'Ignore'}, {text, 'HlSearchLensNear'}}
--         else
--             text = ('[%s %d]'):format(indicator, idx)
--             chunks = {{' ', 'Ignore'}, {text, 'HlSearchLens'}}
--         end
--         render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
--     end
-- })
