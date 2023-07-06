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
			dim_inactive = true,
			color_set = "mellifluous",
			styles = { -- see :h attr-list for options. set {} for NONE, { option = true } for option
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
				floating_windows = false,
				telescope = false,
				file_tree = true,
				cursor_line = true,
				status_line = false,
			},
			flat_background = {
				line_numbers = true,
				floating_windows = false,
				file_tree = false,
				cursor_line_number = true,
			},
			plugins = {
				cmp = true,
				gitsigns = true,
				indent_blankline = false,
				nvim_tree = {
					enabled = false,
					show_root = false,
				},
				telescope = {
					enabled = true,
					nvchad_like = false,
				},
				startify = false,
			},
		},
	},
}
