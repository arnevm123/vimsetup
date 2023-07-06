local M = {}

function M.Setup(color)
	color = color or "seoulbones"
	vim.cmd.colorscheme(color)

	if color == "mellifluous" then
		vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#DDDDDD", bg = "NONE" })
		vim.cmd([[
		hi Visual guibg=#4D4D4D
		]])
	end

	if color == "seoulbones" then
		vim.cmd([[
		hi Normal guibg=NONE
		hi NormalFloat guibg=NONE
		hi FloatBorder guibg=NONE
		hi EndOfBuffer guibg=NONE
		hi cursorline guibg=NONE
		hi CursorLineNr guibg=NONE
		hi LineNr guibg=NONE
		hi DiagnosticVirtualTextError guibg=NONE
		hi DiagnosticVirtualTextHint guibg=NONE
		hi DiagnosticVirtualTextInfo guibg=NONE
		hi DiagnosticVirtualTextWarn guibg=NONE
		]])
		vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#4B4B4B" })
		-- better colorcolumn & cursorline matching
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#E388A3", italic = true, bg = "none" })
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#A5A6C5", italic = true, bg = "none" })
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#97BDDE", italic = true, bg = "none" })
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#FFDF9B", italic = true, bg = "none" })
		vim.cmd("highlight link netrwDir DiagnosticVirtualTextInfo")
		vim.api.nvim_set_hl(0, "comment", { fg = "#8B8B8B", italic = true })
		vim.api.nvim_set_hl(0, "IncSearch", { bg = "#6B6B6B" })
		vim.api.nvim_set_hl(0, "Search", { bg = "#4B4B4B" })
		vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#4B4B4B" })
	end
end
return M
