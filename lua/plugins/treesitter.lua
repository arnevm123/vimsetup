return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			{
				"andymass/vim-matchup",
				config = function()
					vim.g.matchup_matchparen_offscreen = {}
				end,
			},
			"windwp/nvim-ts-autotag",
		},
		build = ":TSUpdate",
		event = "VeryLazy",
		config = function()
			require("nvim-treesitter.configs").setup({
				modules = {},
				sync_install = true,
				auto_install = true,
				ensure_installed = "all",
				ignore_install = {},
				highlight = {
					enable = true,
					disable = function(_, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
				},
				autopairs = { enable = true },
				autotag = { enable = true },
				matchup = { enable = true, disable_virtual_text = true },
				indent = { enable = true, disable = { "css" } },
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@comment.outer",
							["ic"] = "@comment.inner",
						},
						selection_modes = {
							["@function.outer"] = "V", -- linewise
						},
						include_surrounding_whitespace = false,
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_end = { ["]F"] = "@function.outer" },
						goto_next_start = { ["]f"] = "@function.outer" },
						goto_previous_end = { ["[F"] = "@function.outer" },
						goto_previous_start = { ["[f"] = "@function.outer" },
					},
					swap = {
						enable = true,
						swap_next = { ["]s"] = "@parameter.inner" },
						swap_previous = { ["[s"] = "@parameter.inner" },
					},
				},
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
}

-- return {
-- 	{
-- 		"nvim-treesitter/nvim-treesitter",
-- 		dependencies = {
-- 			{
-- 				"nvim-treesitter/nvim-treesitter-textobjects",
-- 				branch = "main",
-- 				lazy = false,
-- 				config = function()
-- 					-- configuration
-- 					require("nvim-treesitter-textobjects").setup({
-- 						select = {
-- 							lookahead = true,
-- 							selection_modes = {
-- 								["@parameter.outer"] = "v",
-- 								["@function.outer"] = "V",
-- 								["@class.outer"] = "<c-v>",
-- 							},
-- 							include_surrounding_whitespace = false,
-- 						},
-- 					})
-- 					vim.keymap.set({ "x", "o" }, "af", function()
-- 						require("nvim-treesitter-textobjects.select").select_textobject(
-- 							"@function.outer",
-- 							"textobjects"
-- 						)
-- 					end)
-- 					vim.keymap.set({ "x", "o" }, "if", function()
-- 						require("nvim-treesitter-textobjects.select").select_textobject(
-- 							"@function.inner",
-- 							"textobjects"
-- 						)
-- 					end)
-- 					vim.keymap.set({ "x", "o" }, "ac", function()
-- 						require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
-- 					end)
-- 					vim.keymap.set({ "x", "o" }, "ic", function()
-- 						require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
-- 					end)
-- 					vim.keymap.set("n", "]z", function()
-- 						require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
-- 					end)
-- 					vim.keymap.set("n", "[z", function()
-- 						require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.outer")
-- 					end)
-- 				end,
-- 			},
-- 			{
-- 				"andymass/vim-matchup",
-- 				config = function()
-- 					vim.g.matchup_matchparen_offscreen = {}
-- 				end,
-- 			},
-- 			"windwp/nvim-ts-autotag",
-- 		},
-- 		build = ":TSUpdate",
-- 		branch = "main",
-- 		lazy = false,
-- 		config = true,
-- 	},
-- 	{
-- 		"nvim-treesitter/nvim-treesitter-context",
-- 		event = "VeryLazy",
-- 		opts = {
-- 			enable = true,
-- 			max_lines = 5,
-- 			trim_scope = "inner",
-- 			min_window_height = 0,
-- 			patterns = { default = { "class", "function", "method", "for", "while", "if", "switch", "case" } },
-- 			zindex = 20,
-- 			mode = "cursor",
-- 			separator = nil,
-- 		},
-- 	},
-- }

-- vim.api.nvim_create_autocmd("FileType", {
-- 	desc = "User: enable treesitter highlighting",
-- 	callback = function(ctx)
-- 		local hasStarted = pcall(vim.treesitter.start) -- errors for filetypes with no parser
-- 		local noIndent = {}
-- 		if hasStarted and not vim.list_contains(noIndent, ctx.match) then
-- 			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
-- 		end
-- 	end,
-- })
