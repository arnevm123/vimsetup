return {
	{
		"mcchrish/zenbones.nvim",
		priority = 1000,
		dependencies = { "rktjmp/lush.nvim" },
	},
	{
		"ramojus/mellifluous.nvim",
		priority = 1000,
		opts = {
			color_set = "mellifluous",
			styles = {
				comments = { italic = true },
				conditionals = { italic = true },
				folds = {},
				loops = { italic = true },
				functions = { italic = true },
				keywords = { italic = true },
				strings = { italic = true },
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
				operators = {},
			},
			transparent_background = {
				enabled = true,
			},
			flat_background = {
				line_numbers = true,
				floating_windows = false,
				file_tree = false,
				cursor_line_number = true,
			},
			plugins = {
				gitsigns = true,
				telescope = {
					enabled = false,
				},
			},
		},
	},
}
