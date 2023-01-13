require("base.keymapFunctions")
local opts = { noremap = true, silent = true }
local silent = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- move to windows with arrow keys
keymap("n", "<left>", "<C-w>h", opts)
keymap("n", "<down>", "<C-w>j", opts)
keymap("n", "<up>", "<C-w>k", opts)
keymap("n", "<right>", "<C-w>l", opts)

-- Move text up and down
keymap("v", "<C-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<C-k>", ":m '<-2<CR>gv=gv", opts)

keymap("v", "*", '"ry/\\V<C-r>r<CR>', opts)
keymap("v", "#", '"ry?\\V<C-r>r<CR>', opts)
keymap("v", "u", "<Esc>u", opts)
keymap("v", "<C-r>", "<Esc><C-r>gv", opts)

-- Clear highlights with esc
keymap("n", "<esc>", ":noh<CR><esc>", opts)
keymap("x", "<Leader>/", "<Esc>/\\%V")
keymap("n", "<Leader>sa", "ggVG")
keymap("x", "<Leader>sa", "<esc>ggVG")
keymap("n", "]g", '<cmd>lua require "gitsigns".next_hunk()<cr>', opts)
keymap("n", "[g", '<cmd>lua require "gitsigns".prev_hunk()<cr>', opts)
keymap("n", "yor", '<cmd>lua require("illuminate").toggle()<cr>', opts)
keymap("n", "]r", '<cmd>lua require("illuminate").goto_next_reference(wrap)<cr>', opts)
keymap("n", "[r", '<cmd>lua require("illuminate").goto_prev_reference(wrap)<cr>', opts)
keymap("n", "yow", "<C-w>w", opts)
keymap("n", "yoq", "<cmd>lua CToggle()<CR>", opts)
keymap(
	"n",
	"<Leader>xn",
	":call setreg('+', expand('%:.'))<CR>",
	{ noremap = true, silent = true, desc = "Copy Buffer name and path" }
)
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
keymap("v", "c", '"_c', opts)
keymap("n", "c", '"_c', opts)

-- next greatest remap ever : asbjornHaland
keymap("n", "<leader>y", '"+y', opts)
keymap("v", "<leader>y", '"+y', opts)
keymap("n", "<leader>Y", '"+Y', silent)

keymap("n", "<leader>p", '"+p', opts)
keymap("v", "<leader>p", '"+p', opts)
keymap("n", "<leader>P", '"+P', silent)
keymap("v", "<leader>P", '"+P', silent)

keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)

keymap("n", "<C-d>", "<C-d>zztv", opts)
keymap("n", "<C-u>", "<C-u>zztv", opts)

keymap("n", "Q", "@a", opts)
keymap("v", "<leader>re", '"hy:%s/<C-r>h//c <left><left><left>', opts)
keymap("n", "<leader>re", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/cI<Left><Left><Left>")

-- keymap("n", "<leader>w", ":w!<CR>", opts)

keymap("n", "<leader>w", function()
	vim.lsp.buf.formatting_sync()
	vim.cmd.w()
	print(
		'"'
			.. vim.fn.expand("%"):gsub(vim.fn.expand("~"), "~")
			.. '" '
			.. vim.fn.line("$")
			.. "L, "
			.. vim.fn.getfsize(vim.fn.expand("%"))
			.. "B "
			.. "written & formatted"
	)
end, opts)
keymap("n", "<leader>qq", ":Bdelete!<CR>", opts)

-- Telescope
keymap("n", "<C-p>", ":Telescope find_files<cr>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<cr>", opts)
keymap("n", "<leader>fc", ":TelescopeDiffMaster<CR>", opts)
keymap("n", "<leader>fr", ":Telescope oldfiles<cr>", opts)
keymap("n", "<leader>ff", ":Telescope live_grep<cr>", opts)
keymap("n", "<leader>fq", ":Telescope quickfix<cr>", opts)
keymap("n", "<leader>fs", ":Telescope<CR>", opts)
keymap("n", "<leader>fk", ":Telescope keymaps<CR>", opts)
keymap("n", "<leader>ft", ":Telescope file_browser<cr>", opts)
keymap("n", "<leader>fo", ":Telescope file_browser path=%:p:h<cr>", opts)
keymap("n", "<leader>f/", ":Telescope current_buffer_fuzzy_find<CR>", opts)
keymap("n", '<leader>f"', ":Telescope registers<cr>", opts)
keymap("n", "<leader>f;", ":Telescope neoclip<cr>", opts)
keymap("n", "<leader>fa", ':lua require("telescope.builtin").live_grep({grep_open_files=true})<CR>', opts)
keymap("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
keymap("n", "<leader>fw", ":TelescopeDelta<CR>", opts)
keymap("n", "<leader>fdf", ":Telescope dap frames<CR>", opts)
keymap("n", "<leader>fdc", ":Telescope dap commands<CR>", opts)
keymap("n", "<leader>fdb", ":Telescope dap list_breakpoints<CR>", opts)
keymap("n", "<leader>fdv", ":Telescope dap variables<CR>", opts)

keymap("n", "<leader>eu", ":UndotreeToggle<cr>", opts)
keymap("n", "<leader>ex", ":Sexplore!<cr>", opts)
keymap("n", "yoe", ":Lexplore!<cr>", opts)
keymap("n", "yod", ':lua require("dapui").toggle()<cr>', opts)
keymap("n", "<leader>ee", ":GoIfErr<cr>", opts)
keymap("n", "<leader>eb", ":GoDebug -a<cr>", opts)
-- You can also use below = true here to to change the position ofhe printf
-- statement (or set two remaps for either one). This remap must be made in normal mode.
keymap("n", "<leader>ek", ":lua require('refactoring').debug.printf({below = true})<CR>", opts)
-- Remap in normal mode and passing { normal = true } will automatically find the variable under the cursor and print it
keymap("n", "<leader>ev", ":lua require('refactoring').debug.print_var({ normal = true })<CR>", opts)
-- Remap in visual mode will print whatever is in the visual selection
keymap("v", "<leader>ev", ":lua require('refactoring').debug.print_var({})<CR>", opts)
-- Cleanup function: this remap should be made in normal mode
keymap("n", "<leader>ec", ":lua require('refactoring').debug.cleanup({})<CR>", opts)

keymap("n", "gj", "<cmd>TSJJoin<CR>", opts)
keymap("n", "gs", "<cmd>TSJSplit<CR>", opts)

-- HARPOON
keymap("n", "<leader>a", '<cmd>lua require("harpoon.mark").add_file()<CR>', opts)
keymap("n", "<leader>-", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', opts)

keymap("n", "<C-h>", '<cmd>lua require("harpoon.ui").nav_file(1)<CR>', opts)
keymap("n", "<C-j>", '<cmd>lua require("harpoon.ui").nav_file(2)<CR>', opts)
keymap("n", "<C-k>", '<cmd>lua require("harpoon.ui").nav_file(3)<CR>', opts)
keymap("n", "<C-l>", '<cmd>lua require("harpoon.ui").nav_file(4)<CR>', opts)
keymap("n", "<C-;>", '<cmd>lua require("harpoon.ui").nav_file(5)<CR>', opts)

--LSP
keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
keymap("n", "<leader>lg", "<cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", opts)
keymap("n", "<leader>ld", "<cmd>Telescope diagnostics<CR>", opts)
keymap("n", "<leader>lw", "<cmd>Telescope lsp_workspace_diagnostics<cr>", opts)
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<cr>", opts)
keymap("n", "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", opts)
keymap("n", "<leader>lq", "<cmd>Telescope quickfix<cr>", opts)
keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
keymap("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", opts)
keymap("n", "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", opts)
keymap("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
keymap("n", "<leader>lI", "<cmd>Mason<cr>", opts)
-- Database
keymap("n", "<leader>Du", "<Cmd>DBUIToggle<Cr>", opts)
keymap("n", "<leader>Df", "<Cmd>DBUIFindBuffer<Cr>", opts)
keymap("n", "<leader>Dr", "<Cmd>DBUIRenameBuffer<Cr>", opts)
keymap("n", "<leader>Dq", "<Cmd>DBUILastQueryInfo<Cr>", opts)
-- GIT
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
keymap("n", "<leader>gb", "<cmd>0Gclog<cr>", opts)
keymap("n", "<leader>gm", "<cmd>Gitsigns diffthis master<cr>", opts)
-- keymap("n", "<leader>gw", ":lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", opts)
-- keymap("n", "<leader>gz", ":lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>", opts)
keymap("n", "yob", "<cmd>Gitsigns toggle_current_line_blame<CR>", opts)
-- Stylesheets
keymap(
	"n",
	"<leader>oi",
	"<cmd>:lua require('nvim-quick-switcher').find('.+css|.+scss|.+sass', { regex = true, prefix='full' })<CR>",
	{ noremap = true, silent = true, desc = "Go to stylesheet" }
)

-- Angular
-- Using find over switch to look backwards incase in a redux-like folder "/state"
keymap(
	"n",
	"<leader>os",
	"<cmd>:lua require('nvim-quick-switcher').find('.service.ts')<CR>",
	{ noremap = true, silent = true, desc = "Go to service" }
)
keymap(
	"n",
	"<leader>ou",
	"<cmd>:lua require('nvim-quick-switcher').find('.component.ts')<CR>",
	{ noremap = true, silent = true, desc = "Go to TS" }
)
keymap(
	"n",
	"<leader>oo",
	"<cmd>:lua require('nvim-quick-switcher').find('.component.html')<CR>",
	{ noremap = true, silent = true, desc = "Go to html" }
)
keymap(
	"n",
	"<leader>op",
	"<cmd>:lua require('nvim-quick-switcher').find('.module.ts')<CR>",
	{ noremap = true, silent = true, desc = "Go to module" }
)

-- Golang Test switcher
-- keymap("n", "<leader>ot", "<cmd>:lua require('nvim-quick-switcher').find('.+test|.+spec', { regex = true, prefix='full' })<CR>", opts)
keymap("n", "<leader>ot", ":GoAlt!<cr>", opts)

-- Switches for - or _ e.g. controller-util.lua
keymap(
	"n",
	"<leader>ol",
	"<cmd>:lua require('nvim-quick-switcher').find('*util.*', { prefix='short' })<CR>",
	{ noremap = true, silent = true, desc = "Go to util" }
)

keymap("n", "<Leader>ng", ":lua require('neogen').generate()<CR>", opts)
keymap("n", "<Leader>nc", ":lua require('neogen').generate({ type = 'class' })<CR>", opts)
keymap("n", "<Leader>nf", ":lua require('neogen').generate({ type = 'func' })<CR>", opts)
keymap("n", "<Leader>nt", ":lua require('neogen').generate({ type = 'type' })<CR>", opts)

-- debug
keymap("n", "<F5>", ":lua require'dap'.continue()<CR>", opts)
keymap("n", "<F9>", ":lua require'dap'.run_to_cursor()<CR>", opts)
keymap("n", "<F10>", ":lua require'dap'.step_over()<CR>")
keymap("n", "<F11>", ":lua require'dap'.step_into()<CR>")
keymap("n", "<F12>", ":lua require'dap'.step_out()<CR>")
keymap("n", "<F7>", ":lua require'go.dap'.run()<CR>")
keymap("n", "<F6>", ":lua require'go.dap'.stop()<CR>")
keymap("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
keymap("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
keymap("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>")
keymap("n", "<leader>df", ":lua require('dapui').float_element('breakpoints')<CR>")

keymap("n", "dd", Smart_dd, { noremap = true, expr = true })
keymap("n", "gx", "<cmd>lua Go_to_url()<CR>", opts)
keymap("n", "yoz", ":lua require('zen-mode').toggle()<CR>", opts)
