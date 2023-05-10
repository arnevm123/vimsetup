require("base.keymapFunctions")
local nosilent = { noremap = true }
local opts = { noremap = true, silent = true }
local silent = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
keymap("n", "z{", "zfa{", opts)

-- move to windows with arrow keys
keymap("n", "<left>", "<C-w>h", opts)
keymap("n", "<down>", "<C-w>j", opts)
keymap("n", "<up>", "<C-w>k", opts)
keymap("n", "<right>", "<C-w>l", opts)
keymap("n", "<C-w>S", "<C-w>s<C-w>T", opts)
keymap("c", "<tab>", "<C-z>", nosilent)
keymap("n", "<leader><tab>", "<C-^>", nosilent)

-- Move text up and down
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

keymap("v", "*", '"ry/\\V<C-r>r<CR>', opts)
keymap("v", "#", '"ry?\\V<C-r>r<CR>', opts)
keymap("v", "u", "<Esc>u", opts)
keymap("v", "<C-r>", "<Esc><C-r>gv", opts)

keymap("n", "dd", Smart_dd, { noremap = true, expr = true })
keymap("n", "gx", ":lua Go_to_url()<CR>", opts)

-- Clear highlights with esc
keymap("n", "<esc>", ":noh<CR><esc>", opts)
keymap("x", "<Leader>/", "<Esc>/\\%V")
keymap("n", "[c", ":diffget //2<CR>", opts)
keymap("n", "]c", ":diffget //3<CR>", opts)
keymap("n", "<leader>ex", ":Sexplore!<cr>", opts)
keymap("n", "yoe", ":Lexplore!<cr>", opts)
-- keymap("n", "yow", "<C-w>w", opts)
keymap("n", "yoq", ":lua CToggle()<CR>", opts)
keymap(
	"n",
	"<Leader>xn",
	":call setreg('+', expand('%:.') .. ':' .. line('.'))<CR>",
	{ noremap = true, desc = "Copy Buffer name and path" }
)
keymap( "n", "<Leader>xN", ":e <C-r>+<CR>", { noremap = true, desc = "Go to location in clipboard" })
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

-- keymap("n", "n", "nzz", opts)
-- keymap("n", "N", "Nzz", opts)

keymap("n", "<C-d>", "<C-d>zztv", opts)
keymap("n", "<C-u>", "<C-u>zztv", opts)

keymap("n", "Q", "@q", nosilent)
keymap("n", "<Leader>xc", ":g/console.lo/d<cr>", { noremap = true, silent = true, desc = "Remove console.log" })

-- search and replace stuff
keymap("x", "<leader>rk", ":s/\\(.*\\)/\\1", nosilent)
keymap("v", "<leader>re", '"hy:%s#<C-r>h#<C-r>h#c<left><left>', nosilent)
keymap("n", "<leader>re", ":%s/<C-r><C-w>/<C-r><C-w>/cI<Left><Left><Left>", nosilent)
keymap("n", "<leader>tt", ":let $VIM_DIR=expand('%:p:h')<CR>:vsp<CR>:terminal<CR>Acd $VIM_DIR<CR>", nosilent)
keymap("n", "<leader>tm", "::let $VIM_DIR=expand('%:p:h')<CR>:silent !tmux split-window -hc $VIM_DIR<CR>", nosilent)

keymap("n", "<leader>ot", ":GoAlt<CR>", opts)
keymap("n", "<leader>w", ":w!<CR>", opts)
-- keymap("n", "<leader>w", function()
-- 	vim.lsp.buf.format()
-- 	vim.cmd.w()
-- 	print(
-- 		'"'
-- 			.. vim.fn.expand("%"):gsub(vim.fn.expand("~"), "~")
-- 			.. '" '
-- 			.. vim.fn.line("$")
-- 			.. "L, "
-- 			.. vim.fn.getfsize(vim.fn.expand("%"))
-- 			.. "B "
-- 			.. "written & formatted"
-- 	)
-- end, opts)
