return {
  {
    -- https://github.com/milanglacier/minuet-ai.nvim
    "milanglacier/minuet-ai.nvim",
    enabled = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("minuet").setup({
        -- One completion at a time keeps DeepSeek FIM cost minimal.
        n_completions    = 1,
        -- Throttle and debounce reduce API calls while still feeling responsive.
        throttle         = 1000, -- ms between request bursts
        debounce         = 400,  -- ms of idle before triggering
        request_timeout  = 3,    -- seconds before giving up
        cmp              = {
          enable_auto_complete = true,
        },
        blink            = {
          enable_auto_complete = false,
        },
        provider         = "openai_fim_compatible",
        provider_options = {
          openai_fim_compatible = {
            name = "Deepseek",
            api_key = "DEEPSEEK_API_KEY",
            end_point = "https://api.deepseek.com/beta/completions",
            model = "deepseek-v4-flash",
            optional = {
              max_tokens = 256,
              top_p = 0.9,
            },
          },
        },
      })
    end,
  },
}
