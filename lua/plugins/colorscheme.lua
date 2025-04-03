local colorscheme
-- colorscheme = "vague"
-- colorscheme = "seoulbones"
-- colorscheme = "jo"
colorscheme = "mel"
-- colorscheme = "shadow"
-- colorscheme = "jb"
-- colorscheme = "makurai"
return {
	{
		"https://github.com/RRethy/base16-nvim",
		lazy = colorscheme ~= "jo",
		config = function()
			local bg = "None"
			local accent = "#333333"
			local accent2 = "#555555" -- highlight

			local text = "#abb2bf"
			local dark_text = "#3E4451" -- comments, line numbers

			local keyword = "#8F939A"
			local func = "#B6AB8B"
			local types = "#65838E"
			local constant = "#705040"

			local for_tesing = "#FF0000"

			-- local bg = "#0F1919"
			-- local accent = "#102121"
			-- local accent2 = "#0D2525" -- highlight
			--
			-- local text = "#abb2bf"
			-- local dark_text = "#3E4451" -- comments, line numbers
			--
			-- local keyword = "#8F939A"
			-- local func = "#B6AB8B"
			-- local types = "#65838E"
			-- local constant = "#A06057"
			--
			-- local for_tesing = "#FF0000"
			--
			require("base16-colorscheme").setup({
				base00 = bg,
				base01 = accent,
				base02 = accent2,
				base03 = dark_text,
				base04 = dark_text,
				base05 = text,
				base06 = for_tesing,
				base07 = for_tesing,
				base08 = text,
				base09 = constant,
				base0A = types,
				base0B = constant,
				base0C = text,
				base0D = func,
				base0E = keyword,
				base0F = text,
			})
			local visual_bg = vim.api.nvim_get_hl(0, { name = "Visual" }).bg
			vim.api.nvim_set_hl(0, "VisualNonText", { fg = "#5B5B5B", bg = visual_bg })
			-- vim.cmd("colorscheme base16")
		end,
	},
	{
		"vague2k/vague.nvim",
		lazy = colorscheme ~= "vague",
		priority = 1000,
		config = function()
			require("vague").setup({
				transparent = false, -- don't set background
			})
			vim.cmd.colorscheme("vague")
			vim.api.nvim_set_hl(0, "HarpoonWindow", { bg = "#333333" })
			vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#333333" })
			vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = "#555555" })
			local visual_bg = vim.api.nvim_get_hl(0, { name = "Visual" }).bg
			vim.api.nvim_set_hl(0, "VisualNonText", { fg = "#5B5B5B", bg = visual_bg })
		end,
	},
	{
		"mcchrish/zenbones.nvim",
		lazy = colorscheme ~= "seoulbones",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("seoulbones")
			require("base.utils").remove_bg()
			vim.api.nvim_set_hl(0, "@text.title.gitcommit", { link = "Constant" })
			vim.api.nvim_set_hl(0, "Visual", { bg = "#3B3B3B" })
			vim.api.nvim_set_hl(0, "VisualNonText", { fg = "#5B5B5B", bg = "#3B3B3B" })
			vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#4B4B4B" })
			vim.api.nvim_set_hl(0, "comment", { fg = "#8B8B8B", italic = true })
			vim.api.nvim_set_hl(0, "IncSearch", { bg = "#6B6B6B" })
			vim.api.nvim_set_hl(0, "Search", { bg = "#4B4B4B" })
			vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#4B4B4B" })
			vim.api.nvim_set_hl(0, "netrwDir", { link = "DiagnosticVirtualTextInfo" })
			vim.api.nvim_set_hl(0, "ModeMsg", { link = "DiagnosticVirtualTextHint" })
			-- vim.api.nvim_set_hl(0, "QuickFixLine", { link = "DiagnosticVirtualTextHint" })
			vim.api.nvim_set_hl(0, "@string", { link = "Constant" })
		end,
		dependencies = { "rktjmp/lush.nvim" },
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
			vim.api.nvim_set_hl(0, "@text.title.gitcommit", { link = "Constant" })
			vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#DDDDDD", bg = "NONE" })
			local visual_bg = vim.api.nvim_get_hl(0, { name = "Visual" }).bg
			vim.api.nvim_set_hl(0, "VisualNonText", { fg = "#5B5B5B", bg = visual_bg })
			vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#4B4B4B" })
			local float_bg = vim.api.nvim_get_hl(0, { name = "NormalFloat" }).bg
			vim.api.nvim_set_hl(0, "FloatBorder", { bg = float_bg })
		end,
	},
	{
		"rjshkhr/shadow.nvim",
		lazy = colorscheme ~= "shadow",
		priority = 1000,
		config = function()
			vim.opt.termguicolors = true
			vim.cmd.colorscheme("shadow")
			require("base.utils").remove_bg()
			vim.api.nvim_set_hl(0, "Visual", { bg = "#3B3B3B" })
			-- local visual_bg = vim.api.nvim_get_hl(0, { name = "Visual" }).bg
			vim.api.nvim_set_hl(0, "VisualNonText", { fg = "#5B5B5B", bg = "#3B3B3B" })
		end,
	},
	{
		"nickkadutskyi/jb.nvim",
		lazy = colorscheme ~= "jb",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("jb")
			vim.o.background = "light"
		end,
	},
	{
		"Skardyy/makurai-nvim",
		lazy = colorscheme ~= "makurai",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("makurai_less")
		end,
	},
}
