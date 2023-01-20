function ColorMyPencils(color)
	color = color or "seoulbones"

	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#4B4B4B" })
	vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#4B4B4B" })
	vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#4B4B4B" })
	vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#4B4B4B" })
	vim.api.nvim_set_hl(0, "IncSearch", { bg = "#5B5B5B" })
	vim.api.nvim_set_hl(0, "Search", { bg = "#4B4B4B" })
	vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#353535" })
	vim.api.nvim_set_hl(0, "CursorLine", { bg = "#353535" })
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- remove background
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#e388a3", bg = "none" })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#a5a6c5", bg = "none" })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#97bdde", bg = "none" })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#ffdf9b", bg = "none" })
end

return {
	{
		"mcchrish/zenbones.nvim",
		priority = 1000,
		dependencies = { "rktjmp/lush.nvim" },
		config = function()
			ColorMyPencils()
		end,
		lazy = false,
	},
}
