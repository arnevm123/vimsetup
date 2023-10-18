return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	config = function()
		local status_ok, lualine = pcall(require, "lualine")
		if not status_ok then
			return
		end

		local diff = {
			"diff",
			colored = false,
			-- cond = hide_in_width,
		}

		local endOfFileName = {
			"filename",
			fmt = function()
				local t = {}
				local str = vim.fn.expand("%")
				for s in string.gmatch(str, "([^" .. "/" .. "]+)") do
					table.insert(t, s)
				end
				if #t <= 4 then
					return " " .. str
				end
				return " .../" .. t[#t - 3] .. "/" .. t[#t - 2] .. "/" .. t[#t - 1] .. "/" .. t[#t]
			end,
		}
		local rootFile = {
			"rootFile",
			fmt = function()
				local c = {}
				local cwd = ""
				local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
				if vim.v.shell_error == 0 then
					cwd = root
				else
					cwd = vim.loop.cwd()
				end
				for s in string.gmatch(cwd, "([^" .. "/" .. "]+)") do
					table.insert(c, s)
				end
				return " " .. c[#c]
			end,
		}

		local lint_progress = function()
			local procs = require("lint").get_running_procs()
			if #procs == 0 then
				return "󰦕"
			end
			local string = ""
			for _, proc in ipairs(procs) do
				string = string .. proc .. " ,"
			end
			return "󱉶 " .. string.sub(string, 1, -2)
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
				lualine_b = { rootFile },
				lualine_c = { endOfFileName },
				-- lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_x = { lint_progress },
				lualine_y = { branch, diff },
				lualine_z = { },
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
