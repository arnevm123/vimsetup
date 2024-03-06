return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"andymass/vim-matchup",
		"danymat/neogen",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/playground",
		"nvim-treesitter/nvim-treesitter-context",
		"windwp/nvim-ts-autotag",
		"nvim-treesitter/nvim-treesitter-textobjects",
		-- {
		-- 	"Wansmer/sibling-swap.nvim",
		-- 	opts = { use_default_keymaps = true },
		-- 	keys = {
		-- 		{ "[a", ":lua require('sibling-swap.swap').swap_with('left')<CR>", desc = "Swap with left" },
		-- 		{ "]a", ":lua require('sibling-swap.swap').swap_with('right')<CR>", desc = "Swap with right" },
		-- 		{ "[A", ":lua require('sibling-swap.swap').swap_with('left')<CR>", desc = "Swap + operator with left" },
		-- 		{
		-- 			"]A",
		-- 			":lua require('sibling-swap.swap').swap_with('right')<CR>",
		-- 			desc = "Swap + operator with right",
		-- 		},
		-- 	},
		-- },
	},
	event = "VeryLazy",
	config = function()
		require("neogen").setup({ snippet_engine = "luasnip" })
		local status_ok, configs = pcall(require, "nvim-treesitter.configs")
		vim.keymap.set("n", "<Leader>nf", ':lua require("neogen").generate({ type = "func"})<CR>')
		vim.keymap.set("n", "<Leader>nt", ':lua require("neogen").generate({ type = "type"})<CR>')
		if not status_ok then
			return
		end
		configs.setup({
			modules = {},
			sync_install = true,
			auto_install = true,
			ensure_installed = "all", -- one of "all" or a list of languages
			ignore_install = {}, -- List of parsers to ignore installing
			highlight = {
				enable = true, -- false will disable the whole extension
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
			incremental_selection = {
				enable = true,
				keymaps = {
					node_incremental = "<leader>v",
					node_decremental = "<leader>V",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["af"] = "@function.outer",
						["if"] = "@function.inner",
					},
					selection_modes = {
						["@function.outer"] = "V", -- linewise
					},
					include_surrounding_whitespace = false,
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_end = { ["]f"] = "@function.outer" },
					goto_next_start = { ["]F"] = "@function.outer" },
					goto_previous_end = { ["[f"] = "@function.outer" },
					goto_previous_start = { ["[F"] = "@function.outer" },
				},
				swap = {
					enable = true,
					swap_next = { ["]s"] = "@parameter.inner" },
					swap_previous = { ["[s"] = "@parameter.inner" },
				},
			},
		})

		require("treesitter-context").setup({
			enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
			max_lines = 5, -- How many lines the window should span. Values <= 0 mean no limit.
			trim_scope = "inner", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
			min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
			patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
				default = { "class", "function", "method", "for", "while", "if", "switch", "case" },
				rust = { "impl_item", "struct", "enum" },
				markdown = { "section" },
				json = { "pair" },
				yaml = { "block_mapping_pair" },
			},
			zindex = 20, -- The Z-index of the context window
			mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
			separator = nil,
		})
	end,
}
