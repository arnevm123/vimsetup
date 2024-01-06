local M = {}

function M.Setup(color)
	color = color or "seoulbones"
	if color == "mel" then
		color = "mellifluous"
	end
	vim.cmd.colorscheme(color)

	-- vim.api.nvim_set_hl(0, "@Keyword.sql", {})
	-- vim.api.nvim_set_hl(0, "@Operator.sql", {})
	-- vim.api.nvim_set_hl(0, "@Comment.sql", {})

	if color == "mellifluous" then
		vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#DDDDDD", bg = "NONE" })
		-- vim.cmd([[
		-- hi Visual guibg=#4D4D4D
		-- ]])
	end

	if color == "rose-pine" then
		vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#4B4B4B" })
		vim.api.nvim_set_hl(0, "@parameter", { link = "@variable" })
		vim.api.nvim_set_hl(0, "String", { link = "@method" })
		-- vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#4B4B4B" })
	end

	if color == "seoulbones" then
		vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#4B4B4B" })
		-- vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#E388A3", italic = true, bg = "none" })
		-- vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#A5A6C5", italic = true, bg = "none" })
		-- vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#97BDDE", italic = true, bg = "none" })
		-- vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#FFDF9B", italic = true, bg = "none" })
		vim.api.nvim_set_hl(0, "comment", { fg = "#8B8B8B", italic = true })
		vim.api.nvim_set_hl(0, "IncSearch", { bg = "#6B6B6B" })
		vim.api.nvim_set_hl(0, "Search", { bg = "#4B4B4B" })
		vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#4B4B4B" })
		vim.api.nvim_set_hl(0, "netrwDir", { link = "DiagnosticVirtualTextInfo" })
		vim.api.nvim_set_hl(0, "ModeMsg", { link = "DiagnosticVirtualTextHint" })
	end

	if color == "rosebones" then
		vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#4B4B4B" })
		-- vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#E388A3", italic = true, bg = "none" })
		-- vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#A5A6C5", italic = true, bg = "none" })
		-- vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#97BDDE", italic = true, bg = "none" })
		-- vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#FFDF9B", italic = true, bg = "none" })
		vim.api.nvim_set_hl(0, "IncSearch", { bg = "#6B6B6B" })
		vim.api.nvim_set_hl(0, "Search", { bg = "#4B4B4B" })
		vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#4B4B4B" })
		vim.api.nvim_set_hl(0, "netrwDir", { link = "DiagnosticVirtualTextInfo" })
	end

	vim.api.nvim_set_hl(0, "@text.title.gitcommit", { link = "Constant" })
	vim.api.nvim_set_hl(0, "QuickFixLine", { link = "DiagnosticVirtualTextHint" })
end

function M.Transparent(color)
	if color then
		M.Setup(color)
	end
	local highlights = {
		"Normal",
		"DiagnosticVirtualTextError",
		"DiagnosticVirtualTextHint",
		"DiagnosticVirtualTextInfo",
		"DiagnosticVirtualTextWarn",
		"CursorLineNr",
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

	local telescope = {
		"Float",
		"NormalFloat",
		"FloatBorder",
		"Title",
	}
	for _, float in pairs(telescope) do
		vim.cmd.highlight(float .. " guibg=#4B4B4B")
	end

	local tshl = {
		"TelescopeNormal",
		"TelescopeTitle",
		"TelescopeBorder",
	}
	for _, t in pairs(tshl) do
		vim.cmd.highlight(t .. " guibg=#2B2B2B")
	end
end
return M
