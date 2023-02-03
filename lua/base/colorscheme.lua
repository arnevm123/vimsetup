function SetupColorscheme(color, fix_search, fix_diagnostics, fix_telescope)
	color = color or "seoulbones"
	fix_search = fix_search or true
	fix_diagnostics = fix_diagnostics or true
	fix_telescope = fix_telescope or true

	vim.cmd.colorscheme(color)

	-- Remove background and add better colorcolumn & cursorline matching
	vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#2B2B2B" })
	vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2B2B2B" })
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
	vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
	vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
	vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

	if fix_search then
		vim.api.nvim_set_hl(0, "IncSearch", { bg = "#5B5B5B" })
		vim.api.nvim_set_hl(0, "Search", { bg = "#4B4B4B" })
		-- fix match parenthesis
		vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#4B4B4B" })
	end
	if fix_search then
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#e388a3", bg = "none" })
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#a5a6c5", bg = "none" })
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#97bdde", bg = "none" })
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#ffdf9b", bg = "none" })
		vim.api.nvim_set_hl(0, "netrwDir", { fg = "#97bdde" })
	end

	if fix_telescope then
		vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = "#97bdde" })
		vim.api.nvim_set_hl(0, "TelescopePreviewMatch", { fg = "#97bdde", bg = "#4B4B4B" })
		vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { fg = "#97bdde", bg = "#4B4B4B" })
		vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = "#97bdde", bg = "#4B4B4B" })

		vim.api.nvim_set_hl(0, "TelescopePreviewLine", { bg = "#4B4B4B" })

		vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "#3B3B3B" })
		vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#4B4B4B", bg = "#3B3B3B" })
		vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#4B4B4B", bg = "#3B3B3B" })

		vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "#3B3B3B" })

		vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = "#3B3B3B", bg = "#97bdde" })
		vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = "#3B3B3B", bg = "#97bdde" })
		vim.api.nvim_set_hl(0, "TelescopeTitle", { fg = "#3B3B3B", bg = "#97bdde" })
	end
end

return {
	{
		"mcchrish/zenbones.nvim",
		priority = 1000,
		dependencies = { "rktjmp/lush.nvim" },
	},
}
