return {
  "kdheepak/lazygit.nvim",
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
  },
  config = function()
    vim.g.lazygit_floating_window_winblend = 0
    vim.g.lazygit_floating_window_scaling_factor = 0.9
    vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
    vim.g.lazygit_floating_window_use_plenary = 0
    vim.g.lazygit_use_neovim_remote = 1

    -- Configure LazyGit to use delta or diff-so-fancy for syntax highlighting
    vim.g.lazygit_config_file_path = vim.fn.stdpath("config") .. "/lazygit_config.yml"

    -- Use dracula theme for lazygit if config exists
    if vim.fn.has("nvim") and vim.fn.executable("lazygit") then
      vim.g.lazygit_use_custom_config_file_path = 1
    end
  end,
}
