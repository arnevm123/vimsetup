return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"andymass/vim-matchup",
		"danymat/neogen",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter-context",
		"nvim-treesitter/nvim-treesitter-textobjects",
		"windwp/nvim-ts-autotag",
	},
	event = "VeryLazy",
	config = function()
		require("neogen").setup({ snippet_engine = "luasnip" })
		local status_ok, configs = pcall(require, "nvim-treesitter.configs")
		vim.keymap.set("n", "<leader>nn", ':lua require("neogen").generate()<CR>')
		vim.keymap.set("n", "<leader>nf", ':lua require("neogen").generate({ type = "func"})<CR>')
		vim.keymap.set("n", "<leader>nt", ':lua require("neogen").generate({ type = "type"})<CR>')
		if not status_ok then
			return
		end
		configs.setup({
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
			enable = true,
			max_lines = 5,
			trim_scope = "inner",
			min_window_height = 0,
			patterns = {
				default = { "class", "function", "method", "for", "while", "if", "switch", "case" },
				rust = { "impl_item", "struct", "enum" },
				markdown = { "section" },
				json = { "pair" },
				yaml = { "block_mapping_pair" },
			},
			zindex = 20,
			mode = "cursor",
			separator = nil,
		})
	end,
}
