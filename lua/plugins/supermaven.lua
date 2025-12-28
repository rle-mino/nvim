return {
  {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = nil, -- We'll set up custom keybindings
          clear_suggestion = nil,
          accept_word = nil,
        },
        ignore_filetypes = { "fzf", "lazy" },
        color = {
          suggestion_color = "#808080",
          cterm = 244,
        },
      })

      -- Get the supermaven API
      local api = require("supermaven-nvim.completion_preview")

      -- Helper function to check if supermaven has a suggestion
      local function has_supermaven_suggestion()
        return api.has_suggestion()
      end

      -- Tab: Accept supermaven suggestion if available, otherwise handle cmp/luasnip
      vim.keymap.set("i", "<Tab>", function()
        if has_supermaven_suggestion() then
          api.on_accept_suggestion()
        else
          local cmp = require("cmp")
          local luasnip = require("luasnip")
          
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
          end
        end
      end, { desc = "Accept supermaven suggestion or Tab" })

      -- Escape: Deny supermaven suggestion if available, otherwise normal escape
      vim.keymap.set("i", "<Esc>", function()
        if has_supermaven_suggestion() then
          api.on_dispose_inlay()
          -- Stay in insert mode after dismissing suggestion
          return
        else
          -- Normal escape behavior
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
        end
      end, { desc = "Dismiss supermaven suggestion or Escape" })

      -- Enter: Accept cmp suggestion if available
      -- This is already configured in lsp.lua, but we'll make sure it doesn't conflict
      vim.keymap.set("i", "<CR>", function()
        local cmp = require("cmp")
        if cmp.visible() then
          cmp.confirm({ select = true })
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
        end
      end, { desc = "Accept cmp suggestion or Enter" })
    end,
  },
}
