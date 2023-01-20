return {
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "Gclog", "Gvdiff", "Gvdiffsplit", "Gdiffsplit" },
		keys = {

			{ "<leader>gc", ":Gvdiffsplit!<CR>", desc = "merge conflict vertical" },
			{ "<leader>gC", ":Gdiffsplit!<CR>", desc = "merge conflict horizontal" },
			{ "<leader>gb", ":0Gclog<cr>", desc = "Git history" },
		},
	},
	{
		"tpope/vim-unimpaired",
		keys = { "[", "]", "yo" },
	},
}
