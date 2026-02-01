local function setup_clipboard()
      -- 从Neovim 0.10.0开始, 支持原生OSC52, 不需要安装插件, 实现ssh远端复制粘贴功能
      -- https://github.com/neovim/neovim/pull/25872
      -- :h clipboard-osc52

    -- 1. 检测是否处于 SSH 连接中
    local is_ssh = os.getenv("SSH_CONNECTION") ~= nil or 
                   os.getenv("SSH_CLIENT") ~= nil or 
                   os.getenv("SSH_TTY") ~= nil

    -- 2. 检测系统类型
    local uname = vim.loop.os_uname().sysname
    local is_macos = (uname == "Darwin")
    local is_linux = (uname == "Linux")

    -- 【优先级 1】 SSH 远程环境：无论从哪连哪，统一用 OSC52
    -- 效果：在远程机器 y 复制，内容顺着 SSH 隧道传回到你面前那台物理机的剪贴板
    if is_ssh then
        if pcall(require, 'vim.ui.clipboard.osc52') then
            vim.g.clipboard = {
                name = 'OSC 52 (Remote)',
                copy = {
                    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
                    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
                },
                paste = { 
                    -- 不允许在终端内使用系统粘贴板, 防止出现长时间等待问题
                    -- Waiting for OSC 52 response from the terminal. Press Ctrl-C to interrupt...
                    -- https://github.com/neovim/neovim/pull/25872#issuecomment-1808182953
                    -- ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
                    -- ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
                    ["+"] = function() end,
                    ["*"] = function() end,
                },
            }
            end
        return
    end

    -- 【优先级 2】 macOS 物理机本地：通常也推荐 OSC52 (现代终端支持度极高)
    if is_macos then
        if pcall(require, 'vim.ui.clipboard.osc52') then
            vim.g.clipboard = {
                name = 'OSC 52 (macOS)',
                copy = {
                    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
                    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
                },
                paste = {
                    -- ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
                    -- ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
                    ["+"] = function() end,
                    ["*"] = function() end, 
                },
            }
        end
        return
    end

    -- 【优先级 3】 Ubuntu 物理机本地：使用 xclip 对接 X11 剪贴板
    if is_linux and os.getenv("DISPLAY") then
        vim.g.clipboard = {
            name = 'xclip (Linux)',
            copy = {
                ['+'] = 'xclip -selection clipboard',
                ['*'] = 'xclip -selection primary',
            },
            paste = {
                -- ['+'] = 'xclip -selection clipboard -o',
                -- ['*'] = 'xclip -selection primary -o',
                ["+"] = function() end,
                ["*"] = function() end,
            },
            cache_enabled = 1,
        }
    end
end

setup_clipboard()
