-- https://github.com/rcarriga/nvim-notify
local notify_opts = {
    -- 动画样式
    -- fade_in_slide_out
    -- fade
    -- slide
    -- static
    stages = "fade",
    -- 超时时间，默认 5s
    timeout = 2000
}

-- 如果是透明背景，则需要设置背景色
if vim.g.background_transparency then
    notify_opts.background_colour = "#ffffff"
end

vim.notify = require("notify")

vim.notify.setup(notify_opts)
-- 使用案例：
-- 信息、级别、标题
-- 级别有：info、warn、error、debug、trace
-- 示例：
-- vim.notify("hello world", "info", {title = "info"})

-- 显示历史弹窗记录
vim.keybinds.gmap(
    "n",
    "<leader>fn",
    "<cmd>lua require('telescope').extensions.notify.notify()<CR>",
    vim.keybinds.opts
)
