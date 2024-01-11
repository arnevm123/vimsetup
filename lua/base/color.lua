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
		vim.api.nvim_set_hl(0, "QuickFixLine", { link = "@method" })
		vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#4B4B4B" })
		vim.api.nvim_set_hl(0, "@parameter", { link = "@variable" })
		vim.api.nvim_set_hl(0, "String", { link = "@method" })
		vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#2B2B2B" })
		vim.api.nvim_set_hl(0, "netrwDir", { link = "DiagnosticVirtualTextInfo" })
		vim.api.nvim_set_hl(0, "MatchParen", { link = "Search" })
		vim.api.nvim_set_hl(0, "MatchParen", { bg = "#4B4B4B" })
		local tshl = {
			"Float",
			"NormalFloat",
			"FloatBorder",
			"Title",
			"StatusLine",
			"TelescopeNormal",
			"TelescopeTitle",
			"TelescopeBorder",
			"TelescopeBorder",
			"TelescopePromptBorder",
			"TelescopePromptNormal",
			"TelescopePromptBackground",
			"TelescopePromptTitle",
			"TelescopePromptCounter",
			"TelescopePromptPrefix",
		}
		for _, t in pairs(tshl) do
			vim.cmd.highlight(t .. " guibg=#333333")
		end
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
		vim.api.nvim_set_hl(0, "QuickFixLine", { link = "DiagnosticVirtualTextHint" })
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

	local hl = {
		"Float",
		"NormalFloat",
		"FloatBorder",
		"Title",
		"TelescopeNormal",
		"TelescopeTitle",
		"TelescopeBorder",
	}
	for _, t in pairs(hl) do
		vim.cmd.highlight(t .. " guibg=#2B2B2B")
	end
end
return M
