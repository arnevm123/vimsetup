return {
	"nvim-lualine/lualine.nvim",
	event = "BufReadPost",
	config = function()
		local status_ok, lualine = pcall(require, "lualine")
		if not status_ok then
			return
		end

		local hide_in_width = function()
			return vim.fn.winwidth(0) > 80
		end

		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn" },
			symbols = { error = "E ", warn = "W " },
			colored = false,
			update_in_insert = false,
			always_visible = true,
		}

		local diff = {
			"diff",
			colored = false,
			cond = hide_in_width,
		}

		local filetype = {
			"filetype",
			icons_enabled = false,
			icon = nil,
		}

		local endOfFileName = {
			"filename",
			path = 3,
			fmt = function(str)
				local t = {}
				for s in string.gmatch(str, "([^" .. "/" .. "]+)") do
					table.insert(t, s)
				end
				if #t < 3 then
					return str
				end
				return t[#t - 2] .. "/" .. t[#t - 1] .. "/" .. t[#t]
			end,
		}

		local branch = {
			"branch",
			icons_enabled = true,
			-- icon = "",
			fmt = function(str)
				if #str > 33 then
					str = string.sub(str, 1, 30) .. "..."
				end
				return str
			end,
		}

		local navic = require("nvim-navic")

		lualine.setup({
			options = {
				icons_enabled = false,
				theme = "auto",
				globalstatus = true,
				ignore_focus = {
					"dirbuf",
					"netrw",
					"dapui_scopes",
					"dapui_breakpoints",
					"dap-repl",
					"dapui_watches",
					"dapui_console",
				},
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
				always_divide_middle = false,
			},
			sections = {
				lualine_a = {},
				lualine_b = { endOfFileName },
				lualine_c = { { navic.get_location, cond = navic.is_available } },
				-- lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_x = { diff, branch, diagnostics },
				lualine_y = {},
				lualine_z = {},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = {},
		})
	end,
}
