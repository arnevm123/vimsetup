local utils = require("base.utils")
local nosilent = { noremap = true }
local opts = { noremap = true, silent = true }
local silent = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)

-- Resize with arrows
-- keymap("n", "<M-J>", ":resize +2<CR>", opts)
-- keymap("n", "<M-K>", ":resize -2<CR>", opts)
-- keymap("n", "<M-H>", ":vertical resize -2<CR>", opts)
-- keymap("n", "<M-L>", ":vertical resize +2<CR>", opts)

keymap("n", "<C-w>S", "<C-w>s<C-w>T", opts)
keymap("c", "<tab>", "<C-z>", nosilent)

-- Move text up and down
keymap("v", "<C-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<C-k>", ":m '<-2<CR>gv=gv", opts)

keymap("v", "*", '"ry/\\V<C-r>r<CR>', opts)
keymap("v", "#", '"ry?\\V<C-r>r<CR>', opts)
keymap("v", "u", "<Esc>u", opts)
keymap("v", "<C-r>", "<Esc><C-r>gv", opts)

keymap("n", "dd", utils.Smart_dd, { noremap = true, expr = true })
keymap("n", "gx", utils.Go_to_url, opts)

-- Clear highlights with esc
keymap("n", "<esc>", ":noh<CR><esc>", opts)
keymap("x", "<Leader>/", "<Esc>/\\%V")
keymap("n", "[c", ":diffget //2<CR>", opts)
keymap("n", "]c", ":diffget //3<CR>", opts)
keymap("n", "<leader>ex", ":Sexplore!<cr>", opts)
keymap("n", "yoe", ":Lexplore!<cr>", opts)
-- keymap("n", "yow", "<C-w>w", opts)
keymap("n", "yoq", function()
	utils.CToggle()
end, opts)
keymap("n", "<Leader>xp", ":call setreg('+', getreg('@'))<CR>", opts)
keymap(
	"n",
	"<Leader>xn",
	":call setreg('+', expand('%:.') .. ':' .. line('.'))<CR>",
	{ noremap = true, desc = "Copy Buffer name and path" }
)
keymap("n", "<Leader>xo", ":e <C-r>+<CR>", { noremap = true, desc = "Go to location in clipboard" })
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

-- next greatest remap ever : asbjornHaland
keymap("n", "<leader>y", '"+y', opts)
keymap("v", "<leader>y", '"+y', opts)
keymap("n", "<leader>Y", '"+Y', silent)

keymap("n", "<leader>p", '"+p', opts)
keymap("v", "<leader>p", '"+p', opts)
keymap("n", "<leader>P", '"+P', silent)
keymap("v", "<leader>P", '"+P', silent)

keymap("v", "<leader>d", '"_d', opts)
keymap("n", "<leader>d", '"_d', opts)
keymap("v", "<leader>c", '"_c', opts)
keymap("n", "<leader>c", '"_c', opts)


-- keymap("n", "n", "nzz", opts)
-- keymap("n", "N", "Nzz", opts)

keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

keymap("n", "Q", "@q", nosilent)
keymap("n", "<Leader>xc", ":g/console.lo/d<cr>", { noremap = true, silent = true, desc = "Remove console.log" })

-- search and replace stuff
keymap("x", "<leader>rk", ":s/\\(.*\\)/\\1", nosilent)
keymap("v", "<leader>re", '"hy:%s#<C-r>h#<C-r>h#c<left><left>', nosilent)
keymap("n", "<leader>re", ":%s/<C-r><C-w>/<C-r><C-w>/cI<Left><Left><Left>", nosilent)
keymap("n", "<leader>tm", ":let $VIM_DIR=expand('%:p:h')<CR>:silent !tmux split-window -hc $VIM_DIR<CR>", nosilent)

keymap("n", "<leader><leader>c", ":<up>", nosilent)
keymap("n", "<leader><leader>b", ":Cdlf<CR>:make build<CR>", nosilent)

