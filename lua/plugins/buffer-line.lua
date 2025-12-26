return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      local project_name = "Project"
      local ok, git_root = pcall(vim.fn.systemlist, "git rev-parse --show-toplevel")
      if ok and git_root and #git_root > 0 and vim.v.shell_error == 0 then
        project_name = vim.fn.fnamemodify(git_root[1], ":t")
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
