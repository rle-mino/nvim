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

      -- Constants
      local OPENCODE_FOCUS_DELAY = 100

      -- Helper function to find opencode window
      local function find_opencode_window()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          local buf_name = vim.api.nvim_buf_get_name(buf)
          if buf_name:match("opencode") or vim.api.nvim_get_option_value("buftype", { buf = buf }) == "terminal" then
            return win
          end
        end
        return nil
      end

      -- Helper function to focus window and enter insert mode
      local function focus_and_insert(win)
        vim.api.nvim_set_current_win(win)
        vim.cmd("startinsert")
      end

      -- Keymaps
      vim.keymap.set({ "n", "t" }, "<leader>oo", function()
        local current_buf = vim.api.nvim_get_current_buf()
        local is_in_opencode = vim.api.nvim_get_option_value("buftype", { buf = current_buf }) == "terminal"

        if is_in_opencode then
          vim.cmd("wincmd p")
          return
        end

        local opencode_win = find_opencode_window()
        if opencode_win then
          focus_and_insert(opencode_win)
        else
          require("opencode").toggle()
          vim.defer_fn(function()
            local win = find_opencode_window()
            if win then
              focus_and_insert(win)
            end
          end, OPENCODE_FOCUS_DELAY)
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

