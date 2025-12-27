return {
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "JoosepAlvworste/nvim-ts-context-commentstring",
    },
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        -- Disable all default mappings
        mappings = {
          basic = false,
          extra = false,
        },
      })

      -- Set up custom keybinding for <leader>/
      local api = require("Comment.api")
      vim.keymap.set("n", "<leader>/", function()
        api.toggle.linewise.current()
        vim.cmd("normal! j")  -- Move to next line after commenting
      end, { desc = "Toggle comment" })
      vim.keymap.set("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = "Toggle comment" })
    end,
  },
}
