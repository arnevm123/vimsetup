return {
	"Everduin94/nvim-quick-switcher",
	keys = {
		{
			"<leader>os",
			function()
				require("nvim-quick-switcher").find(".service.ts")
			end,
			desc = "Go to service",
		},
		{
			"<leader>ou",
			function()
				require("nvim-quick-switcher").find(".component.ts")
			end,
			desc = "Go to TS",
		},
		{
			"<leader>oo",
			function()
				require("nvim-quick-switcher").find(".component.html")
			end,
			desc = "Go to html",
		},
		{
			"<leader>op",
			function()
				require("nvim-quick-switcher").find(".module.ts")
			end,
			desc = "Go to module",
		},
		{
			"<leader>ol",
			function()
				require("nvim-quick-switcher").find("*util.*")
			end,
			desc = "Go to util",
		},
		{
			"<leader>ow",
			function()
				local toggle_os = function(p)
					local extension = p.file_type
					local path = p.path .. "/"
					local file_name = p.full_prefix
					if string.find(file_name, "linux") ~= nil then
						local pth = path .. string.gsub(file_name, "linux", "windows") .. "." .. extension
						if not io.open(pth, "r") then
							vim.cmd(":e " .. pth)
						end
						return pth
					end
					if string.find(file_name, "windows") ~= nil then
						local pth = path .. string.gsub(file_name, "windows", "linux") .. "." .. extension
						if not io.open(pth, "r") then
							vim.cmd(":e " .. pth)
						end
						return pth
					end
					return path .. file_name
				end
				require("nvim-quick-switcher").find_by_fn(toggle_os)
			end,
			desc = "Go to windows or linux",
		},
		{
			"<leader>ot",
			function()
				local toggle_test = function(p)
					local extension = p.file_type
					local path = p.path .. "/"
					local file_name = p.full_prefix
					if extension == "py" then
						if string.find(file_name, "test") ~= nil then
							return string.gsub(path, "tests/", "")
								.. string.gsub(file_name, "test_", "")
								.. "."
								.. extension
						end
						local test_path = string.gsub(path, "src/", "src/tests/")
							.. "test_"
							.. file_name
							.. "."
							.. extension
						if not io.open(test_path, "r") then
							vim.cmd(":e " .. test_path)
						end
						return test_path
					end
					if extension == "go" then
						-- name contains test -> remove it
						if string.find(file_name, "test") ~= nil then
							return path .. string.gsub(file_name, "_test", "") .. "." .. extension
						end

						-- name does not contain test -> add it
						local test_path = path .. file_name .. "_test." .. extension
						if not io.open(test_path, "r") then
							vim.cmd(":e " .. test_path)
						end
						return test_path
					end
					return path .. file_name
				end
				require("nvim-quick-switcher").find_by_fn(toggle_test)
			end,
			desc = "Go to test",
		},
		{
			"<leader>oi",
			function()
				require("nvim-quick-switcher").find(".+css|.+scss|.+sass", { regex = true, prefix = "full" })
			end,
			desc = "Go to stylesheet",
		},
	},
}
