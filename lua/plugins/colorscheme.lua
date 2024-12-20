local colorscheme = "vague"
-- colorscheme = "no-clown-fiesta"
-- colorscheme = "gruber-darker"
-- colorscheme = "seoulbones"
-- colorscheme = "mel"
-- colorscheme = "rose-pine"
if colorscheme == "vague" then
	return {
		"vague2k/vague.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("vague").setup({
				transparent = true, -- don't set background
			})
			vim.cmd.colorscheme("vague")
			vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#333333" })
			vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = "#555555" })
		end,
	}
elseif colorscheme == "no-clown-fiesta" then
	return {
		"aktersnurra/no-clown-fiesta.nvim",
		lazy = false,
		config = function()
			require("no-clown-fiesta").setup({
				transparent = true, -- removes the background
			})
			vim.cmd.colorscheme("no-clown-fiesta")
		end,
	}
elseif colorscheme == "gruber-darker" then
	return {
		-- "blazkowolf/gruber-darker.nvim",
		"thimc/gruber-darker.nvim",
		lazy = false,
		config = function()
			require("gruber-darker").setup({
				-- transparent = true, -- removes the background
			})
			vim.cmd.colorscheme("gruber-darker")
		end,
	}
elseif colorscheme == "seoulbones" then
	return {
		"mcchrish/zenbones.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("seoulbones")
			require("base.utils").remove_bg()

			vim.api.nvim_set_hl(0, "@text.title.gitcommit", { link = "Constant" })
			vim.api.nvim_set_hl(0, "Visual", { bg = "#3B3B3B" })
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
	}
elseif colorscheme == "mel" then
	return {
		"ramojus/mellifluous.nvim",
		lazy = false,
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
				plugins = {
					gitsigns = true,
					telescope = { enabled = false },
				},
			}

			require("mellifluous").setup(opts)
			vim.cmd.colorscheme("mellifluous")
			vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#4B4B4B" })
			vim.api.nvim_set_hl(0, "@text.title.gitcommit", { link = "Constant" })
			vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#DDDDDD", bg = "NONE" })
			vim.api.nvim_set_hl(0, "Visual", { bg = "#3B3B3B" })
		end,
	}
elseif colorscheme == "rose-pine" then
	return {
		"asilvam133/rose-pine.nvim",
		priority = 1000,
		lazy = false,
		config = function()
			require("rose-pine").setup({
				styles = {
					bold = true,
					italic = true,
					-- transparency = true,
				},
				highlight_groups = {
					-- TreesitterContext = { bg = "#2B2B2B" },
					DiagnosticVirtualTextError = { bg = "none" },
					DiagnosticVirtualTextHint = { bg = "none" },
					DiagnosticVirtualTextInfo = { bg = "none" },
					DiagnosticVirtualTextWarn = { bg = "none" },
					-- Float = { bg = "#333333" },
					-- NormalFloat = { bg = "#333333" },
					-- FloatBorder = { bg = "#333333" },
					-- Title = { bg = "#333333" },
					-- StatusLine = { bg = "#333333" },
					-- ["@text.title.gitcommit"] = { link = "Constant" },
					-- QuickFixLine = { link = "@method" },
					-- ColorColumn = { bg = "#4B4B4B" },
				},
			})
			vim.cmd.colorscheme("rose-pine")
		end,
	}
end
