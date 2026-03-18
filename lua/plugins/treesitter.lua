return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			{
				"andymass/vim-matchup",
				config = function() vim.g.matchup_matchparen_offscreen = {} end,
			},
		},
		build = function()
			require("nvim-treesitter").install("stable")
			require("nvim-treesitter").update()
		end,
		event = "VeryLazy",
		config = function()
			require("nvim-treesitter").setup({
				modules = {},
				sync_install = true,
				auto_install = true,
				ensure_installed = "all",
				highlight = {
					enable = true,
					disable = function(_, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then return true end
					end,
				},
				autopairs = { enable = true },
				autotag = { enable = true },
				matchup = { enable = true, disable_virtual_text = true },
				indent = { enable = true, disable = { "css" } },
			})
		end,
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
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		event = "VeryLazy",
		dependencies = { "nvim-treesitter/nvim-treesitter", branch = "main" },
		init = function() vim.g.no_plugin_maps = true end,
		opts = {
			select = {
				lookahead = true,
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
					["@class.outer"] = "<c-v>", -- blockwise
				},
				include_surrounding_whitespace = false,
			},
		},
		keys = {
			{
				"af",
				function()
					require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
				end,
				mode = { "x", "o" },
			},
			{
				"if",
				function()
					require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
				end,
				mode = { "x", "o" },
			},
			{ "[e", function() require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner") end },
			{ "]e", function() require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.outer") end },
			{
				"]f",
				function()
					require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
				end,
				mode = { "n", "x", "o" },
			},
			{
				"[F",
				function()
					require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
				end,
				mode = { "n", "x", "o" },
			},
			{
				"[f",
				function()
					require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
				end,
				mode = { "n", "x", "o" },
			},
			{
				"]F",
				function() require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects") end,
				mode = { "n", "x", "o" },
			},
		},
	},
}
