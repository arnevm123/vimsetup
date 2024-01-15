return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	event = "VeryLazy",
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup({
			settings = {
				key = function()
					local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD")
					if vim.v.shell_error == 0 and branch then
						return string.gsub(branch, "\n", "") .. "-" .. vim.loop.cwd()
					end
					return vim.loop.cwd()
				end,
			},
			default = {
				get_root_dir = require("base.utils").git_cwd,
				create_list_item = function(config, short_path)
					local root = config.get_root_dir()
					local buf_path = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
					if buf_path == "" then
						buf_path = root
					end
					if short_path then
						buf_path = "."
						if vim.fn.filereadable(root .. "/" .. short_path) == 1 then
							buf_path = root .. "/" .. short_path
						else
							local prefix = "..."
							local isShortened = string.sub(short_path, 1, #prefix) == prefix
							if isShortened then
								short_path = string.sub(short_path, #prefix + 1)
							end
							local search_path = string.gsub(short_path, "^%.{3}", ""):gsub("/", ".*"):gsub(" ", ".*")
							local command = "fd -p " .. search_path .. " " .. root
							local handle = io.popen(command)
							if handle ~= nil then
								local result = handle:read("*l")
								handle:close()
								if result then
									buf_path = result
								end
							end
						end
					end
					short_path = require("plenary.path"):new(buf_path):normalize(root)
					local bufnr = vim.fn.bufnr(short_path, false)
					local pos = { 1, 0 }
					if bufnr ~= -1 then
						pos = vim.api.nvim_win_get_cursor(0)
					end
					return {
						value = buf_path,
						context = { row = pos[1], col = pos[2], name = short_path },
					}
				end,
				BufLeave = function(arg, list)
					local bufnr = arg.buf
					local bufname = vim.api.nvim_buf_get_name(bufnr)
					local item = nil
					for _, it in ipairs(list.items) do
						local value = it.value
						if value == bufname then
							item = it
							break
						end
					end
					if item then
						local pos = vim.api.nvim_win_get_cursor(0)
						item.context.row = pos[1]
						item.context.col = pos[2]
					end
				end,
				VimLeavePre = function(_, list)
					for bufnr = 1, vim.fn.bufnr("$") do
						if vim.fn.buflisted(bufnr) == 1 then
							local bufname = vim.api.nvim_buf_get_name(bufnr)
							local item = nil
							for _, it in ipairs(list.items) do
								local value = it.value
								if value == bufname then
									item = it
									break
								end
							end
							if item then
								vim.api.nvim_set_current_buf(bufnr)
								local pos = vim.api.nvim_win_get_cursor(0)
								item.context.row = pos[1]
								item.context.col = pos[2]
							end
						end
					end
				end,
				display = function(item)
					local t = {}
					local str = item.context.name
					for s in string.gmatch(str, "([^" .. "/" .. "]+)") do
						table.insert(t, s)
					end
					if #t <= 5 then
						return str
					end
					return ".../" .. t[#t - 3] .. "/" .. t[#t - 2] .. "/" .. t[#t - 1] .. "/" .. t[#t]
				end,
			},
		})
		harpoon:extend({
			UI_CREATE = function(cx)
				vim.keymap.set("n", "<esc>", "", { buffer = cx.bufnr })

				vim.keymap.set("n", "<C-v>", function()
					harpoon.ui:select_menu_item({ vsplit = true })
				end, { buffer = cx.bufnr })

				vim.keymap.set("n", "<C-x>", function()
					harpoon.ui:select_menu_item({ split = true })
				end, { buffer = cx.bufnr })

				vim.keymap.set("n", "<C-t>", function()
					harpoon.ui:select_menu_item({ tabedit = true })
				end, { buffer = cx.bufnr })
			end,
		})
	end,
	keys = {
		{
			"<leader>aa",
			function()
				require("harpoon"):list():append()
			end,
			desc = "harpoon add file",
		},
		{
			"<leader>as",
			function()
				require("harpoon").ui:toggle_quick_menu(
					require("harpoon"):list(),
					{ border = require("base.utils").borders(), title_pos = "center" }
				)
			end,
			desc = "harpoon quick menu",
		},
		{
			"<F6>",
			function()
				require("harpoon"):list():select(1)
			end,
			desc = "harpoon file 1",
		},
		{
			"<F7>",
			function()
				require("harpoon"):list():select(2)
			end,
			desc = "harpoon file 2",
		},
		{
			"<F8>",
			function()
				require("harpoon"):list():select(3)
			end,
			desc = "harpoon file 3",
		},
		{
			"<F9>",
			function()
				require("harpoon"):list():select(4)
			end,
			desc = "harpoon file 4",
		},
		{
			"<F10>",
			function()
				require("harpoon"):list():select(5)
			end,
			desc = "harpoon file 5",
		},
	},
}
