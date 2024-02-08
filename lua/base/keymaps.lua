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

keymap("n", "<leader>TC", ":tabclose<CR>", opts)
keymap("n", "<leader>TN", ":tabnew<CR>", opts)
keymap("n", "<leader>TO", ":tabonly<CR>", opts)

keymap("n", "<C-w>S", "<C-w>s<C-w>T", opts)
keymap("c", "<tab>", "<C-z>", nosilent)

-- Move text up and down
keymap("v", "<C-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<C-k>", ":m '<-2<CR>gv=gv", opts)

keymap("v", "<leader>A", ":%norm A", nosilent)
keymap("v", "<leader>I", ":%norm I", nosilent)

-- Add some help to visual mode
keymap("x", ".", ":norm .<CR>", nosilent)
keymap("x", "@", ":norm @q<CR>", nosilent)
keymap("x", "*", '"ry/\\V<C-r>r<CR>', nosilent)
keymap("x", "#", '"ry?\\V<C-r>r<CR>', nosilent)

keymap("n", "dd", utils.Smart_dd, expr)
keymap("n", "gx", utils.Go_to_url, opts)
keymap("n", "gw", utils.search_diagnostics_cody, opts)
keymap("v", "gw", utils.search_diagnostics_cody, opts)
keymap("n", "yoq", utils.CToggle, opts)
keymap("n", "yov", utils.VirtualTextToggle, opts)
keymap("n", "<leader>xu", utils.upload_go_playground, opts)
keymap("v", "<leader>xu", utils.upload_go_playground, opts)
keymap("n", "<leader>zg", function()
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

keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- search and replace stuff
keymap("x", "<leader>rk", ":s/\\(.*\\)/\\1<left><left><left><left><left><left><left><left><left>", nosilent)
keymap("n", "<leader>rk", ":s/\\(.*\\)/\\1<left><left><left><left><left><left><left><left><left>", nosilent)
keymap("v", "<leader>re", '"hy:%s/<C-r>h/<C-r>h/gc<left><left><left>', nosilent)
keymap("n", "<leader>re", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gcI<Left><Left><Left><Left>", nosilent)

keymap("n", "<leader>tm", ":let $VIM_DIR=expand('%:p:h')<CR>:silent !tmux split-window -hc $VIM_DIR<CR>", nosilent)
keymap("n", "<leader>tp", ":let $VIM_DIR=expand('%:p:h')<CR>:silent !tmux-popup.sh $VIM_DIR<CR>", nosilent)

keymap("n", "<leader>bu", ":wa<CR>:Make<CR>", nosilent)
keymap("n", "<leader>bi", ":wa<CR>:Dispatch<CR>", nosilent)
keymap("n", "<leader>bw", ":BuildWindows<CR>", nosilent)
keymap("n", "<leader>bv", ":BuildWindows ", nosilent)

vim.api.nvim_create_user_command("BuildWindows", function(o)
	local build
	local version
	if o.args then
		version = o.args:gsub("^%s*(.-)%s*$", "%1")
	end
	if not version or version == "" or #version == 0 then
		build = "Dispatch make build-windows && cp bin/lynxcontroller-windows.exe ~/remmina-shared"
	else
		build = "Dispatch make VERSION="
			.. o.args
			.. " build-windows && cp bin/lynxcontroller-windows.exe ~/remmina-shared"
	end
	vim.cmd("wa")
	vim.cmd(build)
end, { nargs = "*" })
