return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
      local project_name = "Project"
      if vim.v.shell_error == 0 and git_root then
        project_name = vim.fn.fnamemodify(git_root, ":t")
      end

      require("bufferline").setup({
        options = {
          mode = "buffers",
          themable = true,
          offsets = {
            {
              filetype = "neo-tree",
              text = project_name,
              highlight = "Normal",
              separator = true,
            },
          },
          separator_style = "thin",
          show_buffer_close_icons = true,
          show_close_icon = false,
          diagnostics = "nvim_lsp",
          diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,
        },
      })
    end,
  },
}
