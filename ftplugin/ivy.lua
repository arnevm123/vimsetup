vim.api.nvim_set_keymap(
	"n",
	"<esc>",
	"<cmd>lua vim.ivy.destroy()<CR>",
	{ noremap = true, silent = true, nowait = true }
)

vim.api.nvim_set_keymap(
	"n",
	"<C-j>",
	"<cmd>lua vim.ivy.next(); vim.ivy.checkpoint()<CR>",
	{ noremap = true, silent = true, nowait = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<C-k>",
	"<cmd>lua vim.ivy.previous(); vim.ivy.checkpoint()<CR>",
	{ noremap = true, silent = true, nowait = true }
)
