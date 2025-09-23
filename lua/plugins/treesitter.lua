return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				branch = "main",
				lazy = false,
				config = function()
					-- configuration
					require("nvim-treesitter-textobjects").setup({
						select = {
							lookahead = true,
							selection_modes = {
								["@parameter.outer"] = "v",
								["@function.outer"] = "V",
								["@class.outer"] = "<c-v>",
							},
							include_surrounding_whitespace = false,
						},
					})
					vim.keymap.set({ "x", "o" }, "af", function()
						require("nvim-treesitter-textobjects.select").select_textobject(
							"@function.outer",
							"textobjects"
						)
					end)
					vim.keymap.set({ "x", "o" }, "if", function()
						require("nvim-treesitter-textobjects.select").select_textobject(
							"@function.inner",
							"textobjects"
						)
					end)
					vim.keymap.set({ "x", "o" }, "ac", function()
						require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
					end)
					vim.keymap.set({ "x", "o" }, "ic", function()
						require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
					end)
					vim.keymap.set("n", "]z", function()
						require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
					end)
					vim.keymap.set("n", "[z", function()
						require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.outer")
					end)
				end,
			},
			{
				"andymass/vim-matchup",
				config = function()
					vim.g.matchup_matchparen_offscreen = {}
				end,
			},
			"windwp/nvim-ts-autotag",
		},
		build = ":TSUpdate",
		lazy = false,
		config = true,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "VeryLazy",
		opts = {
			enable = true,
			max_lines = 5,
			trim_scope = "inner",
			min_window_height = 0,
			patterns = { default = { "class", "function", "method", "for", "while", "if", "switch", "case" } },
			zindex = 20,
			mode = "cursor",
			separator = nil,
		},
	},
}
