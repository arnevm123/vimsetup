return {
	"nvim-lualine/lualine.nvim",
	event = "BufEnter",
	config = function()
		local status_ok, lualine = pcall(require, "lualine")
		if not status_ok then
			return
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
			-- cond = hide_in_width,
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

		local harpoon = function()
			if vim.fn.winwidth(0) < 160 then
				return ""
			end
			local marks = require("harpoon").get_mark_config().marks
			local keymaps = { " 𝗛 ", " 𝗝 ", " 𝗞 ", " 𝗟 " }
			local str = ""
			local filename = ""

			for idx = 1, #marks do
				local t = {}
				for s in string.gmatch(marks[idx].filename, "([^" .. "/" .. "]+)") do
					table.insert(t, s)
				end
				if #t < 2 then
					filename = marks[idx].filename
				else
					-- filename = t[#t - 2] .. "/" .. t[#t - 1] .. "/" .. t[#t]
					filename = t[#t - 1] .. "/" .. t[#t]
				end
				if idx > 4 then
					-- str = str .. " " .. filename
				else
					str = str .. " ".. keymaps[idx] .. filename
				end
			end

			return str
		end

		local progress = function()
			-- local current_line = tostring(vim.fn.line("."))
			-- current_line = (" "):rep(3 - #current_line) .. current_line
			local total_lines = tostring(vim.fn.line("$"))
			-- total_lines = total_lines .. (" "):rep(3 - #total_lines)
			-- return current_line .. " / " .. total_lines
			return total_lines .. " lines"
		end

		local branch = {
			"branch",
			icons_enabled = true,
			icon = "",
			fmt = function(str)
				if #str > 33 then
					str = string.sub(str, 1, 30) .. "..."
				end
				return str
			end,
		}

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
				lualine_c = { harpoon },
				-- lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_x = { diff, progress, diagnostics },
				lualine_y = { branch  },
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
