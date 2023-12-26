return {
	{
		"mcchrish/zenbones.nvim",
		priority = 1000,
		dependencies = { "rktjmp/lush.nvim" },
	},
	{
		"yorickpeterse/nvim-grey",
		priority = 1000,
		config = function()
			vim.g.gruvbox_baby_telescope_theme = 1
		end,
	},
	{
		"rose-pine/neovim",
		priority = 1000,
		config = function()
			require("rose-pine").setup({ disable_background = true })
		end,
	},
	{
		"wansmer/serenity.nvim",
		priority = 1000,
		config = true,
	},
	{
		"ramojus/mellifluous.nvim",
		priority = 1000,
		opts = {
			color_set = "mellifluous",
			styles = {
				comments = { italic = true },
				conditionals = { italic = true },
				loops = { italic = true },
				functions = { italic = true },
				keywords = { italic = true },
				strings = { italic = true },
			},
			flat_background = {
				line_numbers = true,
				floating_windows = false,
				file_tree = false,
				cursor_line_number = true,
			},
			plugins = {
				gitsigns = true,
			},
		},
	},
}
