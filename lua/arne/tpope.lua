return {
	{ "arnevm123/unimpaired.nvim",config = true, keys = { "[", "]", "yo" } },
	{ "tpope/vim-abolish", event = "CmdlineEnter" },
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "Gclog", "Gvdiff", "Gvdiffsplit", "Gdiffsplit" },
		keys = {

			{ "<leader>gc", ":Gvdiffsplit!<CR>", desc = "merge conflict vertical" },
			{ "<leader>gC", ":Gdiffsplit!<CR>", desc = "merge conflict horizontal" },
			{ "<leader>gb", ":0Gclog<cr>", desc = "Git history" },
			{ "<leader>gb", ":Gclog<cr>", desc = "Git history", mode = "x" },
		},
	},
	-- not useful in our project :/
	{
		"tpope/vim-dispatch",
		cmd = { "Dispatch", "Make" },
	},
}
