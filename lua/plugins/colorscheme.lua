local colorscheme = "rose-pine"
-- local colorscheme = "seoulbones"
return {
	{
		"mcchrish/zenbones.nvim",
		lazy = colorscheme ~= "seoulbones",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("seoulbones")
			require("base.utils").remove_bg()

			vim.api.nvim_set_hl(0, "@text.title.gitcommit", { link = "Constant" })
			vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#4B4B4B" })
			vim.api.nvim_set_hl(0, "comment", { fg = "#8B8B8B", italic = true })
			vim.api.nvim_set_hl(0, "IncSearch", { bg = "#6B6B6B" })
			vim.api.nvim_set_hl(0, "Search", { bg = "#4B4B4B" })
			vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#4B4B4B" })
			vim.api.nvim_set_hl(0, "netrwDir", { link = "DiagnosticVirtualTextInfo" })
			vim.api.nvim_set_hl(0, "ModeMsg", { link = "DiagnosticVirtualTextHint" })
			vim.api.nvim_set_hl(0, "QuickFixLine", { link = "DiagnosticVirtualTextHint" })
		end,
		dependencies = { "rktjmp/lush.nvim" },
	},
	{
		"asilvam133/rose-pine.nvim",
		priority = 1000,
		lazy = colorscheme ~= "rose-pine",
		config = function()
			require("rose-pine").setup({
				styles = {
					bold = true,
					italic = true,
					transparency = true,
				},
				highlight_groups = {
					TreesitterContext = { bg = "#2B2B2B" },
					DiagnosticVirtualTextError = { bg = "none" },
					DiagnosticVirtualTextHint = { bg = "none" },
					DiagnosticVirtualTextInfo = { bg = "none" },
					DiagnosticVirtualTextWarn = { bg = "none" },
					Float = { bg = "#333333" },
					NormalFloat = { bg = "#333333" },
					FloatBorder = { bg = "#333333" },
					Title = { bg = "#333333" },
					StatusLine = { bg = "#333333" },
					TelescopeNormal = { bg = "#333333" },
					TelescopeTitle = { bg = "#333333" },
					TelescopeBorder = { bg = "#333333" },
					TelescopeSelection = { bg = "#333333" },
					TelescopeSelectionCaret = { bg = "#333333" },
					TelescopePromptBorder = { bg = "#333333" },
					TelescopePromptNormal = { bg = "#333333" },
					TelescopePromptBackground = { bg = "#333333" },
					TelescopePromptTitle = { bg = "#333333" },
					TelescopePromptCounter = { bg = "#333333" },
					TelescopePromptPrefix = { bg = "#333333" },
					["@text.title.gitcommit"] = { link = "Constant" },
					QuickFixLine = { link = "@method" },
					ColorColumn = { bg = "#4B4B4B" },
				},
			})
			vim.cmd.colorscheme("rose-pine")
		end,
	},
	{
		"ramojus/mellifluous.nvim",
		lazy = colorscheme ~= "mel",
		priority = 1000,
		config = function()
			local opts = {
				color_set = "mellifluous",
				styles = {
					comments = { italic = true },
					conditionals = { italic = true },
					loops = { italic = true },
					functions = { italic = true },
					keywords = { italic = true },
					strings = { italic = true },
				},
				flat_background = {
					line_numbers = true,
					floating_windows = false,
					file_tree = false,
					cursor_line_number = true,
				},
				plugins = { gitsigns = true },
			}

			require("mellifluous").setup(opts)
			vim.cmd.colorscheme("mellifluous")
			-- {{{
			vim.api.nvim_set_hl(0, "@text.title.gitcommit", { link = "Constant" })
			vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#DDDDDD", bg = "NONE" })
			-- }}}
		end,
	},
}
