return {
	{
		"supermaven-inc/supermaven-nvim",
		lazy = false,
		-- event = "VeryLazy",
		config = function()
			require("supermaven-nvim").setup({
				keymaps = {
					accept_suggestion = "<C-;>",
					clear_suggestion = "<C-/>",
					accept_word = "<C-.>",
				},
				color = {
					suggestion_color = "#6B6B6B",
					cterm = 244,
				},
			})
		end,
	},
}
