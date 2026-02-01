return {
	{
		"chrisgrieser/nvim-scissors",
		opts = {
			snippetDir = "~/.config/nvim/snippets",
		},
		keys = {
			{
				"<leader>se",
				function() require("scissors").editSnippet() end,
				{ desc = "Edit snippet" },
			},
			{
				"<leader>sa",
				function() require("scissors").addNewSnippet() end,
				{ desc = "Add new snippet" },
			},
		},
	},
}
