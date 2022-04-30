-- https://github.com/mfussenegger/nvim-dap
-- WARN: dap 手动下载调试器
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation

local dap = require("dap")
-- 设置断点样式
local dap_breakpoint = {
    error = {
      -- text = "🧘🛑⊚⭕🟢🔵🚫👉⭐️⛔️🔴",
      text = "🔴",
      texthl = "LspDiagnosticsSignError",
      linehl = "",
      numhl = "",
    },
    rejected = {
      text = "",
      texthl = "LspDiagnosticsSignHint",
      linehl = "",
      numhl = "",
    },
    stopped = {
      text = "👉", 
      texthl = "LspDiagnosticsSignInformation",
      linehl = "DiagnosticUnderlineInfo",
      numhl = "LspDiagnosticsSignInformation",
  },
}

vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)

-- 加载调试器配置
local dap_config = {
    -- python = require("dap.python"),
    cpp = require("dap.cpp")
}

-- 设置调试器
for dap_name, dap_options in pairs(dap_config) do
    dap.adapters.cppdbg = dap_options.adapters
    dap.configurations.cpp = dap_options.configurations
    dap.configurations.c = dap.configurations.cpp
end

