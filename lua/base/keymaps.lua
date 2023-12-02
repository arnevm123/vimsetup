local utils = require("base.utils")
local nosilent = { noremap = true }
local opts = { noremap = true, silent = true }
local expr = { noremap = true, expr = true }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)

-- Resize with Shift-arrows
keymap("n", "<S-down>", ":resize +2<CR>", opts)
keymap("n", "<S-up>", ":resize -2<CR>", opts)
keymap("n", "<S-left>", ":vertical resize -2<CR>", opts)
keymap("n", "<S-right>", ":vertical resize +2<CR>", opts)

keymap("n", "<C-w>S", "<C-w>s<C-w>T", opts)
keymap("c", "<tab>", "<C-z>", nosilent)

-- Move text up and down
keymap("v", "<C-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<C-k>", ":m '<-2<CR>gv=gv", opts)

keymap("x", ".", ":norm .<CR>", nosilent)
keymap("x", "Q", ":norm @q<CR>", nosilent)
keymap("n", "Q", "q", nosilent)
keymap("n", "q", "<nop>", nosilent)
keymap("n", "<leader>q", "@q", nosilent)

keymap("x", "*", '"ry/\\V<C-r>r<CR>', nosilent)
keymap("x", "#", '"ry?\\V<C-r>r<CR>', nosilent)
keymap("x", "<leader>/", "<Esc>/\\%V", nosilent)

keymap("n", "dd", utils.Smart_dd, expr)
keymap("n", "gx", utils.Go_to_url, opts)
keymap("n", "yoq", utils.CToggle, opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Clear highlights with esc
keymap("n", "<esc>", ":noh<CR><esc>", opts)
keymap("n", "[c", ":diffget //2<CR>", opts)
keymap("n", "]c", ":diffget //3<CR>", opts)
keymap("n", "<Leader>xp", ":call setreg('+', getreg('@'))<CR>", opts)
keymap("n", "<Leader>xc", ":call setreg('+', expand('%:.') .. ':' .. line('.'))<CR>", opts)
keymap("n", "<Leader>xo", ":e <C-r>+<CR>", { noremap = true, desc = "Go to location in clipboard" })

-- next greatest remap ever : asbjornHaland
keymap("n", "<leader>y", '"+y', opts)
keymap("v", "<leader>y", '"+y', opts)
keymap("n", "<leader>Y", '"+Y', opts)

keymap("n", "<leader>p", '"+p', opts)
keymap("v", "<leader>p", '"+p', opts)
keymap("n", "<leader>P", '"+P', opts)
keymap("v", "<leader>P", '"+P', opts)

keymap("v", "<leader>d", '"_d', opts)
keymap("n", "<leader>d", '"_d', opts)
keymap("v", "<leader>D", '"_D', opts)
keymap("n", "<leader>D", '"_D', opts)

keymap("v", "<leader>c", '"_c', opts)
keymap("n", "<leader>c", '"_c', opts)
keymap("v", "<leader>C", '"_C', opts)
keymap("n", "<leader>C", '"_C', opts)

keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- search and replace stuff
keymap("x", "<leader>rk", ":s/\\(.*\\)/\\1", nosilent)
keymap("v", "<leader>re", '"hy:%s#<C-r>h#<C-r>h#gc<left><left><left>', nosilent)
keymap("n", "<leader>re", ":%s/<C-r><C-w>/<C-r><C-w>/gcI<Left><Left><Left><Left>", nosilent)

keymap("n", "<leader>tm", ":let $VIM_DIR=expand('%:p:h')<CR>:silent !tmux split-window -hc $VIM_DIR<CR>", nosilent)
keymap("n", "<leader>bu", ":wa<CR>:Make<CR>", nosilent)
keymap("n", "<leader>bi", ":wa<CR>:Dispatch<CR>", nosilent)

keymap("n", "<leader>lv", ":lua vim.diagnostic.config({virtual_text = false})<CR>")
keymap("n", "<leader>LV", ":lua vim.diagnostic.config({virtual_text = true})<CR>")
