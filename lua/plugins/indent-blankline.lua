return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
        highlight = {
          "RainbowRed",
          "RainbowYellow",
          "RainbowBlue",
          "RainbowOrange",
          "RainbowGreen",
          "RainbowViolet",
          "RainbowCyan",
        },
      },
      scope = {
        enabled = true,
        show_start = true,
        show_end = false,
      },
      exclude = {
        filetypes = {
          "help",
          "lazy",
          "mason",
          "neo-tree",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
    config = function(_, opts)
      local hooks = require("ibl.hooks")
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#4A3A3A" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#4A4738" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#3A3F4A" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#4A4038" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#3A4A3A" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#443A4A" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#3A4547" })
      end)

      require("ibl").setup(opts)
    end,
  },
}
