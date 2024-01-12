local config = require("user.lsp.config")

return {
  capabilities = config.capabilities,
  on_attach = config.on_attach,
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#clangd
  cmd = {
    "clangd",
    "--background-index",               -- 后台建立索引，并持久化到disk
    "--completion-style=detailed",      -- 用于在代码补全时提供更详细的信息
    "--clang-tidy",                     -- 检查代码是否符合 clang-tidy 的代码规范
    "--cross-file-rename=true",         -- 用于夸文件重命名
    "--header-insertion=iwyu",          -- 用于在头文件中自动插入#include 语句(include-what-you-use)
    "--pch-storage=memory",             -- 将预编译头文件存储在内存中，而不是在磁盘上。这可以提高 clangd 的启动速度和索引构建速度
    "--function-arg-placeholders=true", -- 用于在代码补全时显示函数参数的占位符
    "--ranking-model=decision_forest",  -- 用于设置代码补全的排序策略(decision_forest 是一种基于决策树的排序算法)
    "--header-insertion-decorators",    -- 插入头文件时添加装饰器，以避免重复插入同一个头文件
    "--fallback-style=Google",          -- 代码格式化的风格，当clang-format不可用时使用
    "-j=8",                             -- 使用8个线程来执行索引构建和代码分析
    "--log=verbose",                    -- 日志相关
    "--pretty",                         -- 日志相关
  }
}
