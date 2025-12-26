return {
  "Mofiqul/dracula.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local dracula = require("dracula")
    dracula.setup({
      colors = {
        bg = "#1A1B26",
        fg = "#F8F8F2",
        selection = "#3A3D4F",
        comment = "#6272A4",
        red = "#FF5555",
        orange = "#FFB86C",
        yellow = "#F1FA8C",
        green = "#50FA7B",
        purple = "#BD93F9",
        cyan = "#8BE9FD",
        pink = "#FF79C6",
        bright_red = "#FF6E6E",
        bright_green = "#69FF94",
        bright_yellow = "#FFFFA5",
        bright_blue = "#D6ACFF",
        bright_magenta = "#FF92DF",
        bright_cyan = "#A4FFFF",
        bright_white = "#FFFFFF",
        menu = "#161821",
        visual = "#2D3142",
        gutter_fg = "#5B6378",
        nontext = "#2A2E3A",
      },
      show_end_of_buffer = true,
      transparent_bg = false,
      italic_comment = true,
      overrides = {},
    })
    vim.cmd.colorscheme("dracula")
  end,
}

