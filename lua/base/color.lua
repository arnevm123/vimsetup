local M = {}

function M.Setup(color)
	color = color or "seoulbones"
	vim.cmd.colorscheme(color)

	if color == "mellifluous" then
		vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#DDDDDD", bg = "NONE" })
		-- vim.cmd([[
		-- hi Visual guibg=#4D4D4D
		-- ]])
	end

	if color == "seoulbones" then
		vim.cmd([[
		]])
		vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#4B4B4B" })
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#E388A3", italic = true, bg = "none" })
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#A5A6C5", italic = true, bg = "none" })
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#97BDDE", italic = true, bg = "none" })
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#FFDF9B", italic = true, bg = "none" })
		vim.cmd("highlight link netrwDir DiagnosticVirtualTextInfo")
		vim.cmd("highlight link @Keyword.sql Constant")
		vim.cmd("highlight link @operator.sql Constant")
		vim.api.nvim_set_hl(0, "comment", { fg = "#8B8B8B", italic = true })
		vim.api.nvim_set_hl(0, "IncSearch", { bg = "#6B6B6B" })
		vim.api.nvim_set_hl(0, "Search", { bg = "#4B4B4B" })
		vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#4B4B4B" })
	end
end

function M.Transparent(color)
	if color then
		M.Setup(color)
	end
	local highlights = {
		"Normal",
		"NormalFloat",
		"FloatBorder",
		"EndOfBuffer",
		"DiagnosticVirtualTextError",
		"DiagnosticVirtualTextHint",
		"DiagnosticVirtualTextInfo",
		"DiagnosticVirtualTextWarn",
		"LineNr",
		"Folded",
		"NonText",
		"SpecialKey",
		"VertSplit",
		"SignColumn",
		"EndOfBuffer",
	}
	for _, highlight in pairs(highlights) do
		vim.cmd.highlight(highlight .. " guibg=none ctermbg=none")
	end
end
return M
