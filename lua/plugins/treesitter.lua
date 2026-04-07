return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			{
				"andymass/vim-matchup",
				config = function() vim.g.matchup_matchparen_offscreen = {} end,
			},
		},
		build = ":TSUpdate",
		lazy = false,
		config = function()
			require("nvim-treesitter").install("stable")

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter.setup", {}),
				callback = function(args)
					local buf = args.buf
					local filetype = args.match
					local language = vim.treesitter.language.get_lang(filetype) or filetype
					if not vim.treesitter.language.add(language) then return end
					vim.wo.foldmethod = "expr"
					vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.treesitter.start(buf, language)
					vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
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
