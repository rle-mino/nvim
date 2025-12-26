return {
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Use snacks.nvim for terminal provider
        provider = {
          enabled = "snacks",
          snacks = {
            win = {
              position = "right",
              width = 0.3, -- 30% of screen width
              height = 1, -- Full height
              border = "rounded",
            },
            enter = true, -- Auto-focus when opening
          },
        },
      }

      -- Required for automatic buffer reloading when opencode edits files
      vim.o.autoread = true

      -- Keymaps
      vim.keymap.set({ "n", "t" }, "<leader>oo", function()
        local current_win = vim.api.nvim_get_current_win()
        local current_buf = vim.api.nvim_win_get_buf(current_win)
        local is_in_opencode = vim.api.nvim_get_option_value("buftype", { buf = current_buf }) == "terminal"

        if is_in_opencode then
          -- If we're in opencode, just switch to the previous window (main buffer)
          vim.cmd("wincmd p")
        else
          -- Check if opencode window already exists
          local opencode_win = nil
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            local buf_name = vim.api.nvim_buf_get_name(buf)
            if buf_name:match("opencode") or vim.api.nvim_get_option_value("buftype", { buf = buf }) == "terminal" then
              opencode_win = win
              break
            end
          end

          if opencode_win then
            -- If opencode window exists, just focus it
            vim.api.nvim_set_current_win(opencode_win)
            vim.cmd("startinsert")
          else
            -- If opencode window doesn't exist, toggle it and focus
            require("opencode").toggle()
            -- Give opencode a moment to open, then focus the terminal
            vim.defer_fn(function()
              for _, win in ipairs(vim.api.nvim_list_wins()) do
                local buf = vim.api.nvim_win_get_buf(win)
                local buf_name = vim.api.nvim_buf_get_name(buf)
                if buf_name:match("opencode") or vim.api.nvim_get_option_value("buftype", { buf = buf }) == "terminal" then
                  vim.api.nvim_set_current_win(win)
                  vim.cmd("startinsert")
                  break
                end
              end
            end, 100)
          end
        end
      end, { desc = "Open/Focus opencode" })

      vim.keymap.set({ "n", "x" }, "<leader>ol", function()
        require("opencode").prompt("@this")
      end, { desc = "Add selected lines to opencode" })

      vim.keymap.set({ "n", "x" }, "<leader>oa", function()
        require("opencode").select()
      end, { desc = "Execute opencode action" })

      vim.keymap.set("n", "<leader>of", function()
        local filepath = vim.fn.expand("%:.")
        if filepath ~= "" then
          require("opencode").prompt("@" .. filepath)
        end
      end, { desc = "Add current file to opencode" })
    end,
  },
}

