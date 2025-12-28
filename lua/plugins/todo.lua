return {
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "<leader>tt", "<cmd>TodoFzfLua<cr>", desc = "Find TODOs" },
    },
    opts = {},
  },
}
