require("illuminate").configure({
	providers = {
		"lsp",
		"treesitter",
		"regex",
	},
	delay = 0,
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
})
require("illuminate").toggle()

-- vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#4B4B4B" })
-- vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#4B4B4B" })
-- vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#4B4B4B" })
-- keymap("n", "yor", '<cmd>lua require("illuminate").toggle()<cr>', opts)
-- keymap("n", "]r", '<cmd>lua require("illuminate").goto_next_reference(wrap)<cr>', opts)
-- keymap("n", "[r", '<cmd>lua require("illuminate").goto_prev_reference(wrap)<cr>', opts)
