return {
	{
		"dmtrKovalenko/fff.nvim",
		build = function() require("fff.download").download_or_build_binary() end,
		lazy = false, -- make fff initialize on startup
	},

	{
		"madmaxieee/fff-snacks.nvim",
		lazy = false, -- lazy loaded by design
		keys = {
			{
				"ff",
				function() require("fff-snacks").find_files() end,
				desc = "FFF find files",
			},
			{
				"fw",
				function() require("fff-snacks").live_grep() end,
				desc = "FFF live grep",
			},
			{
				mode = "v",
				"fw",
				function() require("fff-snacks").grep_word() end,
				desc = "FFF grep word",
			},
			{
				"fz",
				function()
					require("fff-snacks").live_grep({
						grep_mode = { "fuzzy", "plain", "regex" },
					})
				end,
				desc = "FFF live grep (fuzzy)",
			},
		},
	},
}
