-- https://github.com/nvim-treesitter/nvim-treesitter

require("nvim-treesitter.configs").setup( {
        -- 安装的高亮支持来源
        -- ensure_installed = "maintained",
        ensure_installed = { "c", "cpp", "python", "bash", "cmake", "lua", "css", "json", "javascript", "make", "vue", "yaml", "vim", "html"}, 
        -- 同步下载高亮支持
        sync_install = false,
        -- 高亮相关
        highlight = {
            -- 启用高亮支持
            enable = true,
            -- 使用 treesitter 高亮而不是 neovim 内置的高亮
            additional_vim_regex_highlighting = false
        },
        -- 启用增量选择
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<CR>',
          node_incremental = '<CR>',
          node_decremental = '<BS>',
          scope_incremental = '<TAB>',
        }
      },
    }
)
