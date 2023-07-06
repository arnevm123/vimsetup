return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-context",
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-lua/plenary.nvim",
	},
	event = "VeryLazy",
	config = function()
		local status_ok, configs = pcall(require, "nvim-treesitter.configs")
		if not status_ok then
			return
		end

		configs.setup({
			ensure_installed = "all", -- one of "all" or a list of languages
			ignore_install = { }, -- List of parsers to ignore installing
			highlight = {
				enable = true, -- false will disable the whole extension
				disable = { "" }, -- list of language that will be disabled
			},
			autopairs = {
				enable = true,
			},
			indent = { enable = true, disable = { "css" } },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<c-space>",
					node_incremental = "<c-space>",
					node_decremental = "<c-\\>",
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
						["al"] = "@loop.outer",
						["il"] = "@loop.inner",
						["ac"] = "@conditional.outer",
						["ic"] = "@conditional.inner",
					},
					selection_modes = {
						["@function.outer"] = "V", -- linewise
						["@class.outer"] = "V", -- blockwise
					},
					include_surrounding_whitespace = false,
				},
				move = {
					enable = true,
					set_jumps = true,

					goto_next_start = {
						["]f"] = "@function.outer",
						["]i"] = "@conditional.outer",
						["]l"] = "@loop.outer",
					},
					goto_next_end = {
						["]F"] = "@function.outer",
						["]I"] = "@conditional.outer",
						["]L"] = "@loop.outer",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[i"] = "@conditional.outer",
						["[l"] = "@loop.outer",
					},
					goto_previous_end = {
						["[I"] = "@conditional.outer",
						["[F"] = "@function.outer",
						["[L"] = "@loop.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["]a"] = "@parameter.inner",
					},
					swap_previous = {
						["[a"] = "@parameter.inner",
					},
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
				tex = { "chapter", "section", "subsection", "subsubsection" },
				rust = { "impl_item", "struct", "enum" },
				scala = { "object_definition" },
				vhdl = { "process_statement", "architecture_body", "entity_declaration" },
				markdown = { "section" },
				elixir = {
					"anonymous_function",
					"arguments",
					"block",
					"do_block",
					"list",
					"map",
					"tuple",
					"quoted_content",
				},
				json = { "pair" },
				yaml = { "block_mapping_pair" },
			},
			zindex = 20, -- The Z-index of the context window
			mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
			separator = nil,
		})
	end,
}
