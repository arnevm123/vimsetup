local opts = { noremap = true, silent = true }


local silent = { silent = true }


-- Shorten function name
local keymap = vim.keymap.set

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

-- Move text up and down
keymap("v", "<C-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<C-k>", ":m '<-2<CR>gv=gv", opts)

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)
-- Clear highlights with esc
keymap("n", "<esc>", ":noh<CR><esc>", opts)

keymap('n', ']b', ':bn<CR>', opts)
keymap('n', '[b', ':bp<CR>', opts)
keymap('n', ']g',  '<cmd>lua require "gitsigns".next_hunk()<cr>',  opts)
keymap('n', '[g',  '<cmd>lua require "gitsigns".prev_hunk()<cr>',  opts)

keymap("n", "<Leader>xn", ":let @+=@%<cr>", { noremap = true, silent = true, desc = "Copy Buffer name and path" })

keymap("n", "<Leader>xc", ":g/console.lo/d<cr>", { noremap = true, silent = true, desc = "Remove console.log" })

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)


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

keymap("n", "<leader>p", "\"+p", opts )
keymap("v","<leader>p", "\"+p", opts)
keymap("n", "<leader>P", "\"+P", silent)
keymap("v", "<leader>P", "\"+P", silent)

keymap('n', 'n', 'nzz', opts)
keymap('n', 'N', 'Nzz', opts)

keymap('n', '<C-d>', '<C-d>zztv', opts)
keymap('n', '<C-u>', '<C-u>zztv', opts)

keymap('n', 'Q', 'gqq', opts)
keymap('v', '<leader>re', '"hy:%s/<C-r>h//gc<left><left><left>', opts)

keymap('n', '<leader>w', ':w!<CR>', opts)
keymap('n', '<leader>q', ':bp<CR> :bd #<CR>', opts)

-- Telescope
keymap('n', '<leader>fp', ':Telescope find_files theme=dropdown<cr>', opts)
keymap('n', '<leader>fb', ':Telescope buffers theme=dropdown<cr>', opts)
keymap('n', '<leader>fc', ':lua Telescope_diff_master()<CR>', opts)
keymap('n', '<leader>fo', ':Telescope oldfiles theme=dropdown<cr>', opts)
keymap('n', '<leader>ff', ':Telescope live_grep<cr>', opts)
keymap('n', '<leader>fq', ':Telescope quickfix<cr>', opts)
keymap('n', '<leader>fs', ':Telescope<CR>', opts)
keymap('n', '<leader>ft', ':Telescope file_browser<cr>', opts)
keymap('n', '<leader>ft', ':Telescope file_browser path=%:p:h<cr>', opts)
keymap('n', '<leader>f/', ':Telescope current_buffer_fuzzy_find<CR>', opts)
keymap('n', '<leader>f"', ':Telescope registers theme=dropdown<cr>', opts)
keymap('n', '<leader>fg', ':Telescope git_branches  theme=dropdown<cr>', opts)
keymap('n', '<leader>f;', ':Telescope neoclip<cr>', opts)
keymap('n', '<leader>fa', ':lua require("telescope.builtin").live_grep({grep_open_files=true})<CR>', opts)
keymap("n", "<leader>fw", "<cmd>lua Delta_git_commits()<CR>", opts)
keymap('n', '<leader>fdf', ':Telescope dap frames<CR>', opts)
keymap('n', '<leader>fdc', ':Telescope dap commands<CR>', opts)
keymap('n', '<leader>fdb', ':Telescope dap list_breakpoints<CR>', opts)
keymap('n', '<leader>fdv', ':Telescope dap variables<CR>', opts)

keymap('n', '<leader>eu', ':UndotreeToggle<cr>', opts)
keymap('n', '<leader>ex', ':Explore<cr>', opts)
keymap('n', '<leader>ee', ':GoIfErr<cr>', opts)
keymap('n', '<leader>el', ':GoLint<cr>', opts)
keymap('n', '<leader>ef', ':GoFillStruct<cr>', opts)
keymap('n', '<leader>ei', ':GoImport<cr>', opts)
keymap('n', '<leader>eb', ':GoDebug -a<cr>', opts)
keymap('n', '<leader>et', ':lua require("dapui").toggle()<cr>', opts)
keymap('n', '<leader>ecd', ':cd platform/scripts/local-full<cr>', opts)
-- You can also use below = true here to to change the position ofhe printf
-- statement (or set two remaps for either one). This remap must be made in normal mode.
keymap( "n", "<leader>ek", ":lua require('refactoring').debug.printf({below = true})<CR>", opts)
-- Remap in normal mode and passing { normal = true } will automatically find the variable under the cursor and print it
keymap("n", "<leader>ev", ":lua require('refactoring').debug.print_var({ normal = true })<CR>", opts)
-- Remap in visual mode will print whatever is in the visual selection
keymap("v", "<leader>ev", ":lua require('refactoring').debug.print_var({})<CR>", opts)
-- Cleanup function: this remap should be made in normal mode
keymap("n", "<leader>ec", ":lua require('refactoring').debug.cleanup({})<CR>", opts)
keymap('n', '<leader>es', '<cmd>setlocal spell!<CR>', opts)

keymap('n', '<leader>k', '<cmd>:TSJSplit<CR>', opts)
keymap('n', '<leader>j', '<cmd>:TSJJoin<CR>', opts)

-- HARPOON
keymap("n", "<leader>a", '<cmd>lua require("harpoon.mark").add_file()<CR>', opts)
keymap("n", "<leader>-", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', opts)

keymap("n", "<C-h>", '<cmd>lua require("harpoon.ui").nav_file(1)<CR>', opts)
keymap("n", "<C-j>", '<cmd>lua require("harpoon.ui").nav_file(2)<CR>', opts)
keymap("n", "<C-k>", '<cmd>lua require("harpoon.ui").nav_file(3)<CR>', opts)
keymap("n", "<C-l>", '<cmd>lua require("harpoon.ui").nav_file(4)<CR>', opts)
keymap("n", "<C-;>", '<cmd>lua require("harpoon.ui").nav_file(5)<CR>', opts)


keymap("n", "gx", ":lua Go_to_url()<CR>", opts)

--LSP
keymap("n", "<leader>la" ,"<cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", opts)
keymap("n", "<leader>ld" ,"<cmd>Telescope diagnostics<CR>", opts)
keymap("n", "<leader>lw", "<cmd>Telescope lsp_workspace_diagnostics<cr>", opts)
keymap("n", "<leader>lf", "<cmd>LspZeroFormat<cr>", opts)
keymap("n", "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", opts)
keymap("n", "<leader>lq", "<cmd>Telescope quickfix<cr>", opts)
keymap("n", "<leader>lr", "<<cmd>lua vim.lsp.buf.rename()<cr>", opts)
keymap("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", opts)
keymap("n", "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", opts)
-- Database
keymap("n", "<leader>Du", "<Cmd>DBUIToggle<Cr>", opts)
keymap("n", "<leader>Df", "<Cmd>DBUIFindBuffer<Cr>", opts)
keymap("n", "<leader>Dr", "<Cmd>DBUIRenameBuffer<Cr>", opts)
keymap("n", "<leader>Dq", "<Cmd>DBUILastQueryInfo<Cr>", opts)
--GIT
keymap("n", "<leader>gg", "<cmd>Neogit<CR>", opts)
keymap("n", "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", opts)
keymap("n", "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", opts)
keymap("n", "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", opts)
keymap("n", "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", opts)
keymap("n", "<leader>gS", "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", opts)
keymap("n", "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", opts)
keymap("n", "<leader>gU", "<cmd>lua require 'gitsigns'.undo_stage_buffer()<cr>", opts)
keymap("n", "<leader>go", "<cmd>Telescope git_status<cr>", opts)
keymap("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", opts)
keymap("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", opts)
keymap("n", "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", opts)
keymap("n", "<leader>gD", "<cmd>Gitsigns diffthis master<cr>", opts)
keymap("n", "<leader>gw", ":lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", opts)
keymap("n", "<leader>gz", ":lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>", opts)
keymap("n", "<leader>ge", "<cmd>Gitsigns toggle_current_line_blame<CR>", opts)
-- Stylesheets
keymap("n", "<leader>oi", "<cmd>:lua require('nvim-quick-switcher').find('.+css|.+scss|.+sass', { regex = true, prefix='full' })<CR>",
    { noremap = true, silent = true, desc = "Go to stylesheet" })

-- Angular
-- Using find over switch to look backwards incase in a redux-like folder "/state"
keymap("n", "<leader>os", "<cmd>:lua require('nvim-quick-switcher').find('.service.ts')<CR>", { noremap = true, silent = true, desc = "Go to service" })
keymap("n", "<leader>ou", "<cmd>:lua require('nvim-quick-switcher').find('.component.ts')<CR>", { noremap = true, silent = true, desc = "Go to TS" })
keymap("n", "<leader>oo", "<cmd>:lua require('nvim-quick-switcher').find('.component.html')<CR>", { noremap = true, silent = true, desc = "Go to html" })
keymap("n", "<leader>op", "<cmd>:lua require('nvim-quick-switcher').find('.module.ts')<CR>", { noremap = true, silent = true, desc = "Go to module" })
-- Golang Test switcher
keymap('n', '<leader>ot', ':GoAlt!<cr>', opts)

-- Switches for - or _ e.g. controller-util.lua
keymap("n", "<leader>ol", "<cmd>:lua require('nvim-quick-switcher').find('*util.*', { prefix='short' })<CR>", { noremap = true, silent = true, desc = "Go to util" })

local previewers = require("telescope.previewers")
local builtin = require("telescope.builtin")

local delta = previewers.new_termopen_previewer({
	get_command = function(entry)
		return { "git", "-c", "core.pager=delta", "-c", "delta.side-by-side=false", "diff", entry.value .. "^!" }
	end,
})

Delta_git_commits = function(options)
	options = options or {}
	options.previewer = {
		delta,
		previewers.git_commit_message.new(options),
		previewers.git_commit_diff_as_was.new(options),
	}
	builtin.git_commits(options)
end


