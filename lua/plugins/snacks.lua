return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- Input prompts (used by opencode.nvim)
      input = {},
      -- Picker/selector (used by opencode.nvim)
      picker = {},
      -- Terminal integration (used by opencode.nvim)
      terminal = {},
      -- Notification system
      notifier = {
        enabled = true,
        timeout = 3000,
        style = "fancy",
      },
      -- Dashboard
      dashboard = {
        enabled = true,
        wo = {
          cursorline = true, -- enable cursor line
        },
        preset = {
          header = [[
██████╗ ██╗     ███████╗   ███╗   ██╗██╗   ██╗██╗███╗   ███╗
██╔══██╗██║     ██╔════╝   ████╗  ██║██║   ██║██║████╗ ████║
██████╔╝██║     █████╗     ██╔██╗ ██║██║   ██║██║██╔████╔██║
██╔══██╗██║     ██╔══╝     ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║  ██║███████╗███████╗██╗██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═╝╚══════╝╚══════╝╚═╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
          ]],
          keys = {
            { icon = "🔍", key = "f", desc = "Find File", action = ":lua require('fzf-lua').files()" },
            { icon = "📄", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = "🔎", key = "g", desc = "Find Text", action = ":lua require('fzf-lua').live_grep()" },
            { icon = "📂", key = "r", desc = "Recent Files", action = ":lua require('fzf-lua').oldfiles()" },
            { icon = "⚙️ ", key = "c", desc = "Config", action = ":lua require('fzf-lua').files({cwd = vim.fn.stdpath('config')})" },
            { icon = "💤", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = "👋", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup vim.notify to use snacks
          vim.notify = function(msg, level, opts)
            return require("snacks").notifier.notify(msg, level, opts)
          end
        end,
      })


       -- Open dashboard on startup when no files are opened
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          -- Check if we opened with no arguments or a directory
          if vim.fn.argc() == 0 or vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
            -- Wait for Neo-tree to open (it has its own VimEnter autocmd)
            vim.defer_fn(function()
              -- Find the main window (not neo-tree)
              for _, win in ipairs(vim.api.nvim_list_wins()) do
                local buf = vim.api.nvim_win_get_buf(win)
                local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
                if ft ~= "neo-tree" then
                  -- Set current window to the main window
                  vim.api.nvim_set_current_win(win)
                  -- Open dashboard in the current buffer (not floating)
                  require("snacks").dashboard.open({ win = win, buf = buf })
                  break
                end
              end
            end, 100)
          end
        end,
      })
    end,
  },
}
