function SetupColorscheme(color, fix_search, fix_diagnostics, fix_telescope)
	color = color or "seoulbones"
	fix_search = fix_search or true
	fix_diagnostics = fix_diagnostics or true
	fix_telescope = fix_telescope or true

	vim.cmd.colorscheme(color)

	-- Remove background and add better colorcolumn & cursorline matching
	vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#242424" })
	vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#2B2B2B" })
	vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#2B2B2B" })
	vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
	vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
	vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#DDDDDD", bold = true })
	vim.api.nvim_set_hl(0, "LineNr", { fg = "#8B8B8B", italic = true })
	vim.api.nvim_set_hl(0, "comment", { fg = "#8B8B8B", italic = true })

	if fix_search then
		vim.api.nvim_set_hl(0, "IncSearch", { bg = "#6B6B6B" })
		vim.api.nvim_set_hl(0, "Search", { bg = "#3B3B3B" })
		-- fix match parenthesis
		vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#2B2B2B" })
	end
	if fix_search then
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#E388A3", italic = true, bg = "none" })
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#A5A6C5", italic = true, bg = "none" })
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#97BDDE", italic = true, bg = "none" })
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#FFDF9B", italic = true, bg = "none" })
		vim.api.nvim_set_hl(0, "netrwDir", { fg = "#97bdde" })
	end

	if fix_telescope then
		vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = "#97BDDE", bg = "#3B3B3B" })
		vim.api.nvim_set_hl(0, "TelescopePreviewMatch", { fg = "#97BDDE", bg = "#3B3B3B" })
		vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { fg = "#97BDDE", bg = "#3B3B3B" })
		vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = "#97BDDE", bg = "#3B3B3B" })

		vim.api.nvim_set_hl(0, "TelescopePreviewLine", { bg = "#3B3B3B" })

		vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "#2B2B2B" })
		vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#3B3B3B", bg = "#2B2B2B" })
		vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#3B3B3B", bg = "#2B2B2B" })

		vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "#2B2B2B" })

		vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = "#2B2B2B", bold = true, bg = "#97BDDE" })
		vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = "#2B2B2B", bold = true, bg = "#97BDDE" })
		vim.api.nvim_set_hl(0, "TelescopeTitle", { fg = "#2B2B2B", bold = true, bg = "#97BDDE" })
	end
end

return {
	{
		"mcchrish/zenbones.nvim",
		priority = 1000,
		dependencies = { "rktjmp/lush.nvim" },
	},
}
