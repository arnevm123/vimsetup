function ColorMyPencils(color, fix_search, fix_diagnostics)
	color = color or "seoulbones"
	fix_search = fix_search or true
	fix_diagnostics = fix_diagnostics or true

	vim.cmd.colorscheme(color)

	-- Remove background and add better colorcolumn & cursorline matching
	vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#353535" })
	vim.api.nvim_set_hl(0, "CursorLine", { bg = "#353535" })
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
	vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

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
	end
end

return {
	{
		"mcchrish/zenbones.nvim",
		priority = 1000,
		dependencies = { "rktjmp/lush.nvim" },
	},
}
