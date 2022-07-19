local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<leader>k", ":bnext<CR>", opts)
keymap("n", "<leader>j", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- Press jk fast to exit insert mode 
keymap("i", "jk", "<ESC>", opts)
keymap("n", "<leader>n", ":noh<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- Visual Block --
-- Move text up and down
-- keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)


-- doesn't overwrite yank
keymap('v', 'c', '"_c', opts)
keymap('v', '<leader>d', '"_d', opts)
keymap('n', 'c', '"_c', opts)
keymap('n', '<leader>d', '"_d', opts)
keymap('v', '<leader>s', '"_s', opts)
keymap('v', '<leader>x', '"_x', opts)
keymap('n', '<leader>s', '"_s', opts)
keymap('n', '<leader>x', '"_x', opts)
keymap('v', '<leader>p', 'pyiw', opts)

keymap('n', 'gj', '<C-o>', opts)
keymap('n', 'gk', '<C-i>', opts)

keymap('n', 'n', 'nzzzv', opts)
keymap('n', 'N', 'Nzzzv', opts)

keymap('n', 'Q', 'gqq', opts)
keymap('n', 'g.', '`.', opts)
keymap('v', '<leader>r', '"hy:%s/<C-r>h//gc<left><left><left>', opts)

keymap('n', '<leader>w', ':w!<CR>', opts)
keymap('n', '<leader>q', ':q!<CR>', opts)
keymap('n', '<leader>f', ':Telescope find_files theme=dropdown<cr>', opts)
keymap('n', '<leader>F', ':Telescope live_grep<cr>', opts)
keymap('n', '<leader>a', ':Alpha<cr>', opts)
keymap('n', '<leader>e', ':NvimTreeToggle<cr>', opts)
keymap('n', '<leader>s', ':Telescope<CR>', opts)
keymap('n', '<leader>;', ':Telescope registers theme=dropdown<cr>', opts)
keymap('n', '<C-f>;', ':Telescope current_buffer_fuzzy_find theme=dropdown<cr>', opts)


-- git stuff
keymap('n', '<leader>gg', '<cmd>lua _LAZYGIT_TOGGLE()<CR>', opts)
keymap('n', '<leader>gj', '<cmd>lua require "gitsigns".next_hunk()<cr>', opts)
keymap('n', '<leader>gk', '<cmd>lua require "gitsigns".prev_hunk()<cr>', opts)
keymap('n', '<leader>gp', '<cmd>lua require "gitsigns".preview_hunk()<cr>', opts)
keymap('n', '<leader>gr', '<cmd>lua require "gitsigns".reset_hunk()<cr>', opts)
keymap('n', '<leader>gR', '<cmd>lua require "gitsigns".reset_buffer()<cr>', opts)
keymap('n', '<leader>gs', '<cmd>lua require "gitsigns".stage_hunk()<cr>', opts)
keymap('n', '<leader>gS', '<cmd>lua require "gitsigns".stage_buffer()<cr>', opts)
keymap('n', '<leader>gu', '<cmd>lua require "gitsigns".undo_stage_hunk()<cr>', opts)
keymap('n', '<leader>gU', '<cmd>lua require "gitsigns".undo_stage_buffer()<cr>', opts)
keymap('n', '<leader>go', '<cmd>Telescope git_status<cr>', opts)
keymap('n', '<leader>gb', '<cmd>Telescope git_branches<cr>', opts)
keymap('n', '<leader>gc', '<cmd>Telescope git_commits<cr>', opts)
keymap('n', '<leader>gd', '<cmd>Gitsigns diffthis HEAD<cr>', opts)
