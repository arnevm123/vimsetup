local M = {}

function M.Setup(color, remove_bg, fix_diagnostics)
	color = color or "seoulbones"
	remove_bg = remove_bg or true
	fix_diagnostics = fix_diagnostics or true

	vim.cmd.colorscheme(color)

	if remove_bg then
		-- Remove background
		vim.cmd([[
		hi Normal guibg=NONE
		hi NormalFloat guibg=NONE
		hi FloatBorder guibg=NONE
		hi EndOfBuffer guibg=NONE
		hi cursorline guibg=NONE
		hi DiffAdd guibg=NONE
		hi DiffChange guibg=NONE
		hi DiffDelete guibg=NONE
		hi ColorColumn guibg=NONE
		hi CursorLineNr guibg=NONE
		hi LineNr guibg=NONE
		hi DiagnosticVirtualTextError guibg=NONE
		hi DiagnosticVirtualTextHint guibg=NONE
		hi DiagnosticVirtualTextInfo guibg=NONE
		hi DiagnosticVirtualTextWarn guibg=NONE
		]])

		-- better colorcolumn & cursorline matching
	end

	if fix_diagnostics then
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#E388A3", italic = true, bg = "none" })
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#A5A6C5", italic = true, bg = "none" })
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#97BDDE", italic = true, bg = "none" })
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#FFDF9B", italic = true, bg = "none" })
		vim.api.nvim_set_hl(0, "DiffAdd", { fg = "#628562", bold = true })
		vim.api.nvim_set_hl(0, "DiffChange", { fg = "#FFDF9B", bold = true })
		vim.api.nvim_set_hl(0, "DiffDelete", { fg = "#E388A3", bold = true })
	end

	if color == "seoulbones" then
		vim.cmd("highlight link netrwDir DiagnosticVirtualTextInfo")
		vim.api.nvim_set_hl(0, "comment", { fg = "#7B7B7B", italic = true })
		vim.api.nvim_set_hl(0, "IncSearch", { bg = "#6B6B6B" })
		vim.api.nvim_set_hl(0, "Search", { bg = "#4B4B4B" })
		vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#4B4B4B" })
	end
end
return M
