--structure is:
-- vim.keymap.set(mode, lhs, rhs, opts)
local opts = { noremap = true, silent = true }
--navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)             -- left
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)             -- down
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)             -- up
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)             -- right
vim.keymap.set("t", "<C-h>", "wincmd h", opts)           -- left
vim.keymap.set("t", "<C-j>", "wincmd j", opts)           -- down
vim.keymap.set("t", "<C-k>", "wincmd k", opts)           -- up
vim.keymap.set("t", "<C-l>", "wincmd l", opts)           -- right
--tmux navigation
vim.keymap.set("n", "<C-h>", ":TmuxNavigateleft", opts)  -- left
vim.keymap.set("n", "<C-j>", ":TmuxNavigatedown", opts)  -- down
vim.keymap.set("n", "<C-k>", ":TmuxNavigateup", opts)    -- up
vim.keymap.set("n", "<C-l>", ":TmuxNavigateright", opts) -- right
-- nvim tree
vim.keymap.set("n", "<leader>t", ":NvimTreeFocus<CR>", opts)
vim.keymap.set("n", "<leader>f", ":NvimTreeToggle<CR>", opts)
-- windows
vim.keymap.set("n", "<leader>sv", ":vsplit", opts) -- split vertically
vim.keymap.set("n", "<C-up>", ":resize +2", opts)
vim.keymap.set("n", "<C-down>", ":resize -2", opts)
vim.keymap.set("n", "<C-left>", ":vertical resize +2", opts)
vim.keymap.set("n", "<C-right>", ":vertical resize -2", opts)
