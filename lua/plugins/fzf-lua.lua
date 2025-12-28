return {
  "ibhagwan/fzf-lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>ff", "<cmd>lua require('fzf-lua').files()<cr>", desc = "Find files" },
    { "<leader>fg", "<cmd>lua require('fzf-lua').live_grep()<cr>", desc = "Live grep" },
    { "<leader>fb", "<cmd>lua require('fzf-lua').buffers()<cr>", desc = "Find buffers" },
    { "<leader>fr", "<cmd>lua require('fzf-lua').oldfiles()<cr>", desc = "Recent files" },
    { "<leader>fc", "<cmd>lua require('fzf-lua').grep_cword()<cr>", desc = "Find word under cursor" },
    { "<leader>fd", "<cmd>lua require('fzf-lua').diagnostics_document()<cr>", desc = "Document diagnostics" },
    { "<leader>fD", "<cmd>lua require('fzf-lua').diagnostics_workspace()<cr>", desc = "Workspace diagnostics" },
    { "<leader>fs", "<cmd>lua require('fzf-lua').lsp_document_symbols()<cr>", desc = "Document symbols" },
    { "<leader>fS", "<cmd>lua require('fzf-lua').lsp_workspace_symbols()<cr>", desc = "Workspace symbols" },
    { "<leader>fe", "<cmd>lua require('fzf-lua').files({ prompt='Env Files> ', cmd='fd --color=never --type f --hidden --no-ignore --follow --exclude .git -g \".env*\"' })<cr>", desc = "Find .env files" },
    { "<leader>gh", "<cmd>lua require('fzf-lua').git_bcommits()<cr>", desc = "Git current file history" },
  },
  config = function()
    require("fzf-lua").setup({
      winopts = {
        height = 0.80,
        width = 0.87,
        row = 0.35,
        col = 0.50,
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        preview = {
          layout = "horizontal",
          horizontal = "right:55%",
        },
      },
      fzf_opts = {
        ["--layout"] = "reverse",
        ["--info"] = "inline",
      },
      grep = {
        prompt = "   ",
        input_prompt = "Grep  ",
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden --glob=!.git/",
        rg_glob = true,
        glob_flag = "--iglob",
        glob_separator = "%s%-%-",
      },
      files = {
        prompt = "   ",
        git_icons = true,
        file_icons = true,
        color_icons = true,
        fd_opts = "--color=never --type f --hidden --follow --exclude .git",
      },
      keymap = {
        builtin = {
          ["<C-d>"] = "preview-page-down",
          ["<C-u>"] = "preview-page-up",
        },
        fzf = {
          ["ctrl-q"] = "select-all+accept",
        },
      },
      buffers = {
        prompt = "   ",
        actions = {
          ["ctrl-d"] = { fn = function(selected) require("fzf-lua").actions.buf_del(selected) end, reload = true },
        },
      },
      oldfiles = {
        prompt = "   ",
        cwd_only = false,
        include_current_session = true,
      },
      lsp = {
        prompt_postfix = "   ",
        symbols = {
          symbol_style = 1,
        },
      },
      diagnostics = {
        prompt = "   ",
      },
      git = {
        bcommits = {
          prompt = "   ",
        },
      },
    })
  end,
}
