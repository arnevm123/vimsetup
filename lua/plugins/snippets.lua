return {
	{
		"chrisgrieser/nvim-scissors",
		opts = {
			snippetDir = "~/.config/nvim/snippets",
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets" } })
		end,
		keys = {
			{
				"<leader>se",
				function()
					require("scissors").editSnippet()
				end,
				{ desc = "Edit snippet" },
			},
			{
				"<leader>sa",
				function()
					require("scissors").addNewSnippet()
				end,
				{ desc = "Add new snippet" },
			},
		},
	},
}
