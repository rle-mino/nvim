return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")

    wk.setup({
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = true,
          motions = true,
          text_objects = true,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },
      win = {
        border = "rounded",
        padding = { 2, 2, 2, 2 },
        -- Position at bottom left
        col = 0,
        row = math.huge,
        -- Narrower width for vertical list
        width = { min = 20, max = 30 },
        height = { min = 4, max = 75 },
      },
      layout = {
        width = { min = 20, max = 30 },
        spacing = 3,
        align = "left",
      },
    })

    -- Register key groups
    wk.add({
      { "<leader>b", group = "Buffer" },
      { "<leader>c", group = "Code" },
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>l", group = "LSP" },
      { "<leader>o", group = "Opencode" },
      { "<leader>e", desc = "File Explorer" },
      { "<leader>w", desc = "Save" },
      { "<leader>q", desc = "Quit" },
    })
  end,
}

