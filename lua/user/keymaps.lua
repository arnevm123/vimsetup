local opts = { noremap = true, silent = true }


local silent = { silent = true }


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
--
--
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
-- keymap("n", "L", ":bn <CR>", opts)
-- keymap("n", "H", ":bp <CR>", opts)

-- Move text up and down
-- keymap("n", "<A-j>", ":m .+1<CR>==", opts)
-- keymap("n", "<A-k>", ":m .-2<CR>==", opts)
-- keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
-- keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
keymap("v", "<C-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<C-k>", ":m '<-2<CR>gv=gv", opts)

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)
keymap("n", "<leader>n", ":noh<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down

-- Visual Block --
-- Move text up and down
-- keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
-- keymap("x", "<A-j>", ":m '>+1<CR>gv-gv", opts)
-- keymap("x", "<A-k>", ":m '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", silent)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", silent)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", silent)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", silent)


-- doesn't overwrite yank
keymap('v', 'c', '"_c', opts)
keymap('n', 'c', '"_c', opts)

-- next greatest remap ever : asbjornHaland
keymap("n", "<leader>y", "\"+y", opts )
keymap("v","<leader>y", "\"+y", opts)
keymap("n", "<leader>Y", "\"+Y", silent)

keymap("v", "<leader>d", "\"_d", opts)
keymap("n", "<leader>d", "\"_d", opts)


keymap('n', 'gj', '<C-o>', opts)
keymap('n', 'gk', '<C-i>', opts)

keymap('n', 'n', 'nzztv', opts)
keymap('n', 'N', 'Nzztv', opts)

keymap('n', '<C-d>', '<C-d>zztv', opts)
keymap('n', '<C-u>', '<C-u>zztv', opts)

keymap('n', 'Q', 'gqq', opts)
keymap('n', 'g.', '`.', opts)
keymap('v', '<leader>re', '"hy:%s/<C-r>h//gc<left><left><left>', opts)

keymap('n', '<leader>w', ':w!<CR>', opts)
keymap('n', '<leader>q', ':bp<CR> :bd #<CR>', opts)
-- keymap('n', '<leader>q', '<Cmd>BufferClose<CR>', opts)
keymap('n', '<C-p>', ':Telescope find_files theme=dropdown<cr>', opts)
keymap('n', '<leader>b', ':Telescope buffers theme=dropdown<cr>', opts)
keymap('n', '<leader>o', ':Telescope oldfiles theme=dropdown<cr>', opts)
keymap('n', '<leader>f', ':Telescope live_grep<cr>', opts)
keymap('n', '<leader>s', ':Telescope<CR>', opts)
keymap('n', '<leader>;', ':Telescope registers theme=dropdown<cr>', opts)
keymap('n', '<leader>ed', ':NvimTreeToggle<cr>', opts)
keymap('n', '<leader>ee', ':GoIfErr<cr>', opts)
keymap('n', '<leader>el', ':GoLint<cr>', opts)
keymap('n', '<leader>ef', ':GoFillStruct<cr>', opts)
keymap('n', '<leader>db', ':GoDebug -a<cr>', opts)

-- remap to open the Telescope refactoring menu in visual mode
vim.api.nvim_set_keymap( "v", "<leader>rr", "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", { noremap = true })
vim.api.nvim_set_keymap( "n", "<leader>rr", "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", { noremap = true })

-- You can also use below = true here to to change the position ofhe printf
-- statement (or set two remaps for either one). This remap must be made in normal mode.
vim.api.nvim_set_keymap( "n", "<leader>pd", ":lua require('refactoring').debug.printf({below = true})<CR>", { noremap = true })
-- Remap in normal mode and passing { normal = true } will automatically find the variable under the cursor and print it
vim.api.nvim_set_keymap("n", "<leader>pv", ":lua require('refactoring').debug.print_var({ normal = true })<CR>", { noremap = true })
-- Remap in visual mode will print whatever is in the visual selection
vim.api.nvim_set_keymap("v", "<leader>pv", ":lua require('refactoring').debug.print_var({})<CR>", { noremap = true })
-- Cleanup function: this remap should be made in normal mode
vim.api.nvim_set_keymap("n", "<leader>pc", ":lua require('refactoring').debug.cleanup({})<CR>", { noremap = true })

-- -- git stuff
-- keymap('n', '<leader>gg', '<cmd>lua _LAZYGIT_TOGGLE()<CR>', opts)
-- keymap('n', '<leader>gj', '<cmd>lua require "gitsigns".next_hunk()<cr>', opts)
-- keymap('n', '<leader>gk', '<cmd>lua require "gitsigns".prev_hunk()<cr>', opts)
-- keymap('n', '<leader>gp', '<cmd>lua require "gitsigns".preview_hunk()<cr>', opts)
-- keymap('n', '<leader>gr', '<cmd>lua require "gitsigns".reset_hunk()<cr>', opts)
-- keymap('n', '<leader>gR', '<cmd>lua require "gitsigns".reset_buffer()<cr>', opts)
-- keymap('n', '<leader>gs', '<cmd>lua require "gitsigns".stage_hunk()<cr>', opts)
-- keymap('n', '<leader>gS', '<cmd>lua require "gitsigns".stage_buffer()<cr>', opts)
-- keymap('n', '<leader>gu', '<cmd>lua require "gitsigns".undo_stage_hunk()<cr>', opts)
-- keymap('n', '<leader>gU', '<cmd>lua require "gitsigns".undo_stage_buffer()<cr>', opts)
-- keymap('n', '<leader>go', '<cmd>Telescope git_status<cr>', opts)
-- keymap('n', '<leader>gb', '<cmd>Telescope git_branches<cr>', opts)
-- keymap('n', '<leader>gc', '<cmd>Telescope git_commits<cr>', opts)
-- keymap('n', '<leader>gd', '<cmd>Gitsigns diffthis HEAD<cr>', opts)
-- keymap('n', '<leader>gz', '<cmd>Gitsigns toggle_current_line_blame<CR>', opts)
-- keymap('n', '<leader>gw', ':lua require("telescope").extensions.git_worktree.git_worktrees()<CR>', opts)
-- keymap('n', '<leader>ge', ':lua require("telescope").extensions.git_worktree.create_git_worktree()<CR>', opts)

keymap('n', '<leader>pr', '<cmd>silent %!prettier --stdin-filepath %<CR>', opts)




keymap("n", "<leader>a", '<cmd>lua require("harpoon.mark").add_file()<CR>', opts)
keymap("n", "<leader>-", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', opts)
keymap("n", "<C-h>", '<cmd>lua require("harpoon.ui").nav_file(1)<CR>', opts)
keymap("n", "<C-j>", '<cmd>lua require("harpoon.ui").nav_file(2)<CR>', opts)
keymap("n", "<C-k>", '<cmd>lua require("harpoon.ui").nav_file(3)<CR>', opts)
keymap("n", "<C-l>", '<cmd>lua require("harpoon.ui").nav_file(4)<CR>', opts)
keymap("n", "<C-;>", '<cmd>lua require("harpoon.ui").nav_file(5)<CR>', opts)
