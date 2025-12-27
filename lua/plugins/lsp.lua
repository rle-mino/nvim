local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, silent = true }

  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
  vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))

  local function lsp_references_grouped()
    local params = vim.lsp.util.make_position_params()
    local results = vim.lsp.buf_request_sync(0, "textDocument/references", params, 2000)
    local locations = {}

    for _, res in pairs(results or {}) do
      if res.result then
        for _, item in ipairs(res.result) do
          table.insert(locations, item)
        end
      end
    end

    if #locations == 0 then
      vim.notify("No references found", vim.log.levels.INFO)
      return
    end

    local file_groups = {}
    for _, loc in ipairs(locations) do
      local uri = loc.uri or loc.targetUri
      local range = loc.range or loc.targetRange
      local filename = vim.fn.fnamemodify(vim.uri_to_fname(uri), ":p")
      if not file_groups[filename] then
        file_groups[filename] = {
          filename = filename,
          uri = uri,
          locations = {},
        }
      end
      table.insert(file_groups[filename].locations, {
        line = range.start.line,
        character = range.start.character,
      })
    end

    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local previewers = require("telescope.previewers")

    local entries = {}
    for filename, data in pairs(file_groups) do
      table.insert(entries, {
        filename = filename,
        uri = data.uri,
        locations = data.locations,
        display = string.format("%s (%d refs)", vim.fn.fnamemodify(filename, ":~:."), #data.locations),
      })
    end

    pickers.new({}, {
      prompt_title = "References (grouped by file)",
      finder = finders.new_table({
        results = entries,
        entry_maker = function(entry)
          local first_loc = entry.locations[1] or { line = 0, character = 0 }
          return {
            value = entry,
            display = entry.display,
            ordinal = entry.filename,
            filename = entry.filename,
            path = entry.filename,
            lnum = first_loc.line + 1,
            col = first_loc.character,
          }
        end,
      }),
      sorter = conf.generic_sorter(),
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          width = 0.9,
          height = 0.9,
          preview_width = 0.50,
        },
      },
      previewer = previewers.new_buffer_previewer({
        define_preview = function(self, entry)
          conf.buffer_previewer_maker(entry.filename, self.state.bufnr, {})
        end,
      }),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          if selection and selection.value then
            local uri = selection.value.uri
            local loc = selection.value.locations[1]
            vim.cmd("edit " .. vim.uri_to_fname(uri))
            vim.api.nvim_win_set_cursor(0, { loc.line + 1, loc.character })
          end
        end)
        return true
      end,
    }):find()
  end

  vim.keymap.set("n", "gr", lsp_references_grouped, vim.tbl_extend("force", opts, { desc = "Go to references" }))

  vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Line diagnostics" }))
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
  vim.keymap.set("n", "<leader>lf", function()
    vim.lsp.buf.format({ async = true })
  end, vim.tbl_extend("force", opts, { desc = "Format buffer" }))
end

return {
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      -- Setup neodev for Lua LSP
      require("neodev").setup()

      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      -- Enhanced capabilities for autocompletion
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- Diagnostic configuration
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
        },
      })

      -- Diagnostic signs
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- Mason LSP setup
      mason_lspconfig.setup({
        ensure_installed = {
          "eslint",
          "biome",
          "lua_ls",
          "jsonls",
          "html",
          "cssls",
        },
        handlers = {
          -- Default handler
          function(server_name)
            lspconfig[server_name].setup({
              capabilities = capabilities,
              on_attach = on_attach,
            })
          end,


          -- ESLint
          ["eslint"] = function()
            lspconfig.eslint.setup({
              capabilities = capabilities,
              on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                -- Auto-fix on save
                vim.api.nvim_create_autocmd("BufWritePre", {
                  buffer = bufnr,
                  command = "EslintFixAll",
                })
              end,
              filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
            })
          end,

          -- Biome
          ["biome"] = function()
            lspconfig.biome.setup({
              capabilities = capabilities,
              on_attach = on_attach,
              filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "jsonc" },
            })
          end,

          -- Lua
          ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
              capabilities = capabilities,
              on_attach = on_attach,
              settings = {
                Lua = {
                  workspace = {
                    checkThirdParty = false,
                  },
                  completion = {
                    callSnippet = "Replace",
                  },
                  diagnostics = {
                    globals = { "vim" },
                  },
                  telemetry = {
                    enable = false,
                  },
                },
              },
            })
          end,

          -- JSON
          ["jsonls"] = function()
            local settings = {
              json = {
                validate = { enable = true },
              },
            }

            -- Add schemastore schemas if available
            local ok, schemastore = pcall(require, "schemastore")
            if ok then
              settings.json.schemas = schemastore.schemas()
            end

            lspconfig.jsonls.setup({
              capabilities = capabilities,
              on_attach = on_attach,
              filetypes = { "json", "jsonc" },
              settings = settings,
            })
          end,
        },
      })
    end,
  },

  -- TypeScript Tools (Replaces standard ts_ls setup for better functionality)
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      on_attach = on_attach,
      settings = {
        -- spawn_additional_tsserver_instance = true,
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },

  -- Mason - LSP/DAP/Linter/Formatter installer
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- JSON schemas
  {
    "b0o/schemastore.nvim",
    lazy = true,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = {
          "rafamadriz/friendly-snippets",
        },
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          -- Enter accepts cmp suggestion when cmp menu is visible
          ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = true })
            else
              fallback()
            end
          end, { "i", "s" }),
          -- Tab: prioritize Supermaven, then cmp navigation, then luasnip, then fallback
          -- Actual Tab behavior will be handled by supermaven.lua keybindings
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "nvim_lua" },
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = function(entry, item)
            -- First, get color item from nvim-highlight-colors
            local color_item = require("nvim-highlight-colors").format(entry, { kind = item.kind })
            
            -- Then apply lspkind formatting
            item = lspkind.cmp_format({
              mode = "symbol_text",
              maxwidth = 50,
              ellipsis_char = "...",
            })(entry, item)
            
            -- Finally, apply color highlighting if available
            if color_item.abbr_hl_group then
              item.kind_hl_group = color_item.abbr_hl_group
              item.kind = color_item.abbr
            end
            
            return item
          end,
        },
      })
    end,
  },
}
