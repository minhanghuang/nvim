return {
  {
    -- https://github.com/zbirenbaum/copilot.lua
    "zbirenbaum/copilot.lua",
    enabled = true,
    cmd = {
      "Copilot",
      "Copilot auth",
    },
    event = "InsertEnter",
    dependencies = {
      {
        -- https://github.com/zbirenbaum/copilot-cmp
        "zbirenbaum/copilot-cmp",
        after = {
          "copilot.lua",
          "nvim-cmp",
        },
        build = "patch -p1 --forward < ~/.config/nvim/patches/copilot-cmp.patch || true",
        config = function()
          require("copilot_cmp").setup()
        end
      },
      {
        -- https://github.com/copilotlsp-nvim/copilot-lsp
        "copilotlsp-nvim/copilot-lsp",
        after = {
          "copilot.lua",
          "nvim-cmp",
        },
        config = function()
          require('copilot-lsp').setup({})
          vim.keymap.set("n", "<esc>", function()
            if not require("copilot-lsp.nes").clear() then
              -- fallback to other functionality
            end
          end, { desc = "Clear Copilot suggestion or fallback" })
        end
      },
    },
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = false,
        },
        panel = {
          enabled = true,
        },
      })
    end
  },
}
