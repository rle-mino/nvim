return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- Input prompts (used by opencode.nvim)
      input = {},
      -- Picker/selector (used by opencode.nvim)
      picker = {},
      -- Terminal integration (used by opencode.nvim)
      terminal = {},
      -- Notification system
      notifier = {
        enabled = true,
        timeout = 3000,
        style = "fancy",
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup vim.notify to use snacks
          vim.notify = function(msg, level, opts)
            return require("snacks").notifier.notify(msg, level, opts)
          end
        end,
      })
    end,
  },
}
