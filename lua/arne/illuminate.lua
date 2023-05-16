return {
	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({
				providers = { "lsp", "treesitter", "regex" },
				delay = 0,
				filetype_overrides = {},
				filetypes_denylist = {
					"dirvish",
					"fugitive",
					"alpha",
					"NvimTree",
					"packer",
					"neogitstatus",
					"Trouble",
					"lir",
					"Outline",
					"spectre_panel",
					"toggleterm",
					"DressingSelect",
					"TelescopePrompt",
				},
				filetypes_allowlist = {},
				modes_denylist = {},
				modes_allowlist = {},
				providers_regex_syntax_denylist = {},
				providers_regex_syntax_allowlist = {},
				under_cursor = false,
				large_file_cutoff = nil,
				large_file_overrides = nil,
				min_count_to_highlight = 1,
			})
			--stylua: ignore
			vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#4B4B4B" })
			vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#4B4B4B" })
			vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#4B4B4B" })
			vim.keymap.set("n", "yor", '<cmd>lua require("illuminate").toggle()<cr>', { noremap = true, silent = true })
			vim.keymap.set(
				"n",
				"]r",
				'<cmd>lua require("illuminate").goto_next_reference(wrap)<cr>',
				{ noremap = true, silent = true }
			)
			vim.keymap.set(
				"n",
				"[r",
				'<cmd>lua require("illuminate").goto_prev_reference(wrap)<cr>',
				{ noremap = true, silent = true }
			)
			require("illuminate").toggle()
		end,
		event = "BufReadPost",
	},
}
