local opt = vim.opt

-- Line numbers (default relative, autocmd handles insert mode)
opt.number = true
opt.relativenumber = true

-- Tabs & Indentation
-- TODO: Should be overridden by editorconfig
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Line wrapping
opt.wrap = false

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Behavior
opt.hidden = true
opt.errorbells = false
opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.stdpath("data") .. "/undodir"
opt.undofile = true
opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.splitright = true
opt.splitbelow = true
opt.updatetime = 50
opt.timeoutlen = 300

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }
