return {
	{
		"chrisgrieser/nvim-scissors",
		opts = {
			snippetDir = vim.fn.stdpath("config") .. "/snippets",
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
