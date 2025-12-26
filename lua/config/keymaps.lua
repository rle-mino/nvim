local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Buffer navigation
keymap("n", "<S-l>", ":bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
keymap("n", "<S-h>", ":bprevious<CR>", { noremap = true, silent = true, desc = "Previous buffer" })
keymap("n", "<leader>x", ":bprevious | bdelete #<CR>", { noremap = true, silent = true, desc = "Close current buffer" })

-- Move text up and down
keymap("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move line(s) down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move line(s) up" })

-- Clear search highlight
keymap("n", "<leader>nh", ":nohlsearch<CR>", { desc = "Clear search highlight" })

-- Save file
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file" })

-- Quit
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })
