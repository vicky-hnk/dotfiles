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
vim.keymap.set("n", "<leader>ff", ":NvimTreeToggle<CR>", opts)
-- windows
vim.keymap.set("n", "<leader>sv", ":vsplit", opts) -- split vertically
vim.keymap.set("n", "<C-up>", ":resize +2", opts)
vim.keymap.set("n", "<C-down>", ":resize -2", opts)
vim.keymap.set("n", "<C-left>", ":vertical resize +2", opts)
vim.keymap.set("n", "<C-right>", ":vertical resize -2", opts)

-- VimTeX key mappings

-- Compilation mappings
vim.keymap.set("n", "<leader>tl", ":VimtexCompile<CR>", opts)   -- Start/continue LaTeX compilation
vim.keymap.set("n", "<leader>tc", ":VimtexCompileSS<CR>", opts) -- Compile the document silently once
vim.keymap.set("n", "<leader>tk", ":VimtexStop<CR>", opts)      -- Stop LaTeX compilation
vim.keymap.set("n", "<leader>te", ":VimtexErrors<CR>", opts)    -- Show LaTeX errors

-- PDF viewing
vim.keymap.set("n", "<leader>tv", ":VimtexView<CR>", opts) -- Open the compiled PDF with forward search

-- Table of contents mappings
vim.keymap.set("n", "<leader>tt", ":VimtexTocToggle<CR>", opts) -- Toggle table of contents
vim.keymap.set("n", "<leader>to", ":VimtexTocOpen<CR>", opts)   -- Open TOC window
vim.keymap.set("n", "<leader>tq", ":VimtexTocClose<CR>", opts)  -- Close TOC window

-- Toggle automatic compilation
vim.keymap.set("n", "<leader>ta", ":VimtexCompileToggle<CR>", opts) -- Toggle automatic compilation on save

-- Cleaning files
vim.keymap.set("n", "<leader>tC", ":VimtexClean!<CR>", opts) -- Clean auxiliary and output files (PDF)
vim.keymap.set("n", "<leader>tx", ":VimtexClean<CR>", opts)  -- Clean auxiliary LaTeX files (changed from <leader>tc to avoid conflict)

-- Navigation through LaTeX errors in quickfix list
vim.keymap.set("n", "<leader>tn", ":cnext<CR>", opts)     -- Next LaTeX error
vim.keymap.set("n", "<leader>tp", ":cprevious<CR>", opts) -- Previous LaTeX error
vim.keymap.set("n", "<leader>tL", ":lopen<CR>", opts)     -- Open quickfix list
vim.keymap.set("n", "<leader>tq", ":cclose<CR>", opts)    -- Close quickfix list

-- PDF preview in a terminal split
vim.api.nvim_set_keymap("n", "<leader>tp", ":vsplit | terminal mupdf %:r.pdf<CR>", opts)

--Debugger
vim.api.nvim_set_keymap('n', '<F5>', '<Cmd>lua require("dap").continue()<CR>', opts)
vim.api.nvim_set_keymap('n', '<F10>', '<Cmd>lua require("dap").step_over()<CR>', opts)
vim.api.nvim_set_keymap('n', '<F11>', '<Cmd>lua require("dap").step_into()<CR>', opts)
vim.api.nvim_set_keymap('n', '<F12>', '<Cmd>lua require("dap").step_out()<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>b', '<Cmd>lua require("dap").toggle_breakpoint()<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>B',
  '<Cmd>lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', opts)
-- Toggle the DAP UI
vim.api.nvim_set_keymap("n", "<Leader>du", "<Cmd>lua require('dapui').toggle()<CR>", opts)
-- Open the DAP REPL (Read-Eval-Print Loop)
vim.api.nvim_set_keymap("n", "<Leader>dr", "<Cmd>lua require('dap').repl.open()<CR>", opts)
-- Toggle the DAP console
vim.api.nvim_set_keymap("n", "<Leader>dc", "<Cmd>lua require('dapui').eval()<CR>", opts)
