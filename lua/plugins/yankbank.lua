return {
	{
		"arnevm123/yankbank-nvim",
		branch = "add-snacks-picker",
		lazy = false,
		dependencies = { "folke/snacks.nvim" },
		config = function()
			require("yankbank").setup({
				persist_type = "sqlite",
				pickers = {
					snacks = true,
				},
			})
		end,
		keys = {
			{ "<leader>f;", "<cmd>lua Snacks.picker.yankbank()<CR>", desc = "Yank bank" },
		},
	},
	{
		"kkharji/sqlite.lua",
		lazy = true,
	},
}
