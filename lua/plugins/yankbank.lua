return {
	{
		"ptdewey/yankbank-nvim",
		lazy = false,
		config = function()
			require("yankbank").setup({
				persist_type = "sqlite",
			})
		end,
		keys = {
			{ "<leader>f;", "<cmd>YankBank<CR>", desc = "Yank bank" },
		},
	},
	{
		"kkharji/sqlite.lua",
		lazy = true,
	},
}
