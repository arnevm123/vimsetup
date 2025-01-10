local utils = require("base.utils")
local nosilent = { noremap = true }
local opts = { noremap = true, silent = true }
local expr = { noremap = true, expr = true }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)

-- Resize with Shift-arrows
keymap("n", "<C-down>", "<cmd>resize +2<CR>", opts)
keymap("n", "<C-up>", "<cmd>resize -2<CR>", opts)
keymap("n", "<C-left>", "<cmd>vertical resize -2<CR>", opts)
keymap("n", "<C-right>", "<cmd>vertical resize +2<CR>", opts)

keymap("n", "<leader>TC", "<cmd>tabclose<CR>", opts)
keymap("n", "<leader>TN", "<cmd>tabnew<CR>", opts)
keymap("n", "<leader>TO", "<cmd>tabonly<CR>", opts)

keymap("n", "<C-w>S", "<C-w>s<C-w>T", opts)
keymap("c", "<tab>", "<C-z>", nosilent)

-- Move text up and down
keymap("v", "<C-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<C-k>", ":m '<-2<CR>gv=gv", opts)

-- Add some help to visual mode
keymap("v", ".", ":normal .<CR>", nosilent)
keymap("x", "@", ":normal @q<CR>", nosilent)
keymap("x", "*", '"ry/\\V<C-r>r<CR>', nosilent)
keymap("x", "#", '"ry?\\V<C-r>r<CR>', nosilent)

keymap("n", "dd", utils.Smart_dd, expr)
keymap("n", "gx", utils.Go_to_url, opts)
keymap("n", "yoq", utils.CToggle, opts)
keymap("n", "yov", utils.VirtualTextToggle, opts)
keymap("n", "<leader>zg", function()
	---@diagnostic disable-next-line: param-type-mismatch
	utils.cspell_add(vim.fn.expand("<cword>"))
end, nosilent)

keymap("n", "<leader>rg", utils.rg, nosilent)
keymap("v", "<leader>rg", utils.rg, nosilent)
keymap("n", "<leader>rd", utils.fzf_fd, nosilent)

keymap("n", "<leader>rf", function()
	utils:rg({ ask_folder = true })
end, nosilent)

keymap("n", "<leader>ru", function()
	utils:rg({ search_string = vim.fn.expand("<cword>") })
end, nosilent)

keymap("n", "<leader>RG", function()
	utils:rg({ case_insensitive = true })
end, nosilent)

keymap("v", "<leader>RG", function()
	utils:rg({ case_insensitive = true })
end, nosilent)

keymap("n", "<leader>RF", function()
	utils:rg({ ask_folder = true, case_insensitive = true })
end, nosilent)

keymap("n", "<leader>RU", function()
	utils:rg({ search_string = vim.fn.expand("<cword>"), case_insensitive = true })
end, nosilent)

keymap("n", "<leader>ro", utils.open_last_file, nosilent)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("n", "[c", "<cmd>diffget //2<CR>", opts)
keymap("n", "]c", "<cmd>diffget //3<CR>", opts)
keymap("n", "<Leader>xp", "<cmd>call setreg('+', getreg('@'))<CR>", opts)
keymap("n", "<Leader>xc", "<cmd>call setreg('+', expand('%:.') .. ':' .. line('.'))<CR>", opts)
keymap("n", "<Leader>xo", ":e <C-r>+<CR>", { noremap = true, desc = "Go to location in clipboard" })

-- next greatest remap ever : asbjornHaland
keymap("n", "<leader>y", '"+y', opts)
keymap("v", "<leader>y", '"+y', opts)

keymap("n", "<leader>p", '"+p', opts)
keymap("v", "<leader>p", '"+p', opts)
keymap("n", "<leader>P", '"+P', opts)
keymap("v", "<leader>P", '"+P', opts)

keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- search and replace stuff
keymap("x", "<leader>rk", ":s/\\(.*\\)/\\1<left><left><left><left><left><left><left><left><left>", nosilent)
keymap("n", "<leader>rk", ":s/\\(.*\\)/\\1<left><left><left><left><left><left><left><left><left>", nosilent)
keymap("v", "<leader>re", '"hy:%s/<C-r>h/<C-r>h/gc<left><left><left>', nosilent)
keymap("n", "<leader>re", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gcI<Left><Left><Left><Left>", nosilent)

keymap("n", "<leader>tm", "<cmd>let $VIM_DIR=expand('%:p:h')<CR>:silent !tmux split-window -hc $VIM_DIR<CR>", nosilent)
keymap("n", "<leader>tp", "<cmd>let $VIM_DIR=expand('%:p:h')<CR>:silent !tmux-popup.sh $VIM_DIR<CR>", nosilent)

keymap("n", "<leader>GU", "<cmd>call setenv('GOOS', '')<CR>:LspRestart<CR>", nosilent)
keymap("n", "<leader>GW", "<cmd>call setenv('GOOS', 'windows')<CR>:LspRestart<CR>", nosilent)
keymap("n", "<leader>GL", "<cmd>call setenv('GOOS', 'linux')<CR>:LspRestart<CR>", nosilent)

-- TPOPE RSI
keymap("i", "<C-B>", "<Left>", opts)
keymap("i", "<C-F>", "<Right>", opts)
keymap("c", "<C-B>", "<Left>", opts)
keymap("c", "<C-F>", "<Right>", opts)

keymap("i", "<C-A>", "<C-O>^", opts)
keymap("i", "<C-D>", "<Del>", opts)
keymap("i", "<C-E>", "<End>", opts)

keymap("n", "<leader>bu", function()
	vim.cmd("wa")
	local cwd = vim.loop.cwd()
	local build_root
	build_root = vim.lsp.get_clients()[1].config.cmd_cwd
	if build_root then
		vim.api.nvim_set_current_dir(build_root)
	end
	vim.cmd("Make")
	if build_root and cwd then
		vim.api.nvim_set_current_dir(cwd)
	end
end, nosilent)

keymap("n", "<leader>bt", function()
	vim.cmd("wa")
	local cwd = vim.loop.cwd()
	local build_root
	build_root = vim.lsp.get_clients()[1].config.cmd_cwd
	if build_root then
		vim.api.nvim_set_current_dir(build_root)
	end
	vim.cmd("Dispatch make test")
	if build_root and cwd then
		vim.api.nvim_set_current_dir(cwd)
	end
end, nosilent)

keymap("n", "<leader>bl", function()
	vim.cmd("wa")
	local cwd = vim.loop.cwd()
	local build_root
	build_root = vim.lsp.get_clients()[1].config.cmd_cwd
	if build_root then
		vim.api.nvim_set_current_dir(build_root)
	end
	vim.cmd("Dispatch make lint")
	if build_root and cwd then
		vim.api.nvim_set_current_dir(cwd)
	end
	vim.cmd("cfile .lint.txt")
end, nosilent)
