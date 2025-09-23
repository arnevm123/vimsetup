return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
			--[[ 			{ "igorlfs/nvim-dap-view", opts = { windows = { terminal = { hide = { "go" } } } } }, ]]
			{
				"Weissle/persistent-breakpoints.nvim",
				opts = { load_breakpoints_event = { "BufReadPost" } },
				event = "VeryLazy",
			},
		},
		keys = {
			--[[ 			{ "yod", "<cmd>lua  require('dap-view').toggle()<CR>", { noremap = true, silent = true } }, ]]
			{ "<F5>", "<cmd>lua require('dap').continue()<CR>", desc = "Debug continue" },
			{ "<F4>", "<cmd>lua require('dap').step_into()<CR>", desc = "Debug step into" },
			{ "<F3>", "<cmd>lua require('dap').step_over()<CR>", desc = "Debug step ove" },
			{ "<F2>", "<cmd>lua require('dap').step_out()<CR>", desc = "Debug  step out" },
			{ "<leader>dc", "<cmd>lua require('dap').run_to_cursor()<CR>", desc = "Debug run to cursor" },
			{ "<leader>du", "<cmd>lua require('dap').up()<CR>", desc = "Debug step up callstack" },
			{ "<leader>dd", "<cmd>lua require('dap').down()<CR>", desc = "Debug step down callstack" },
			{ "<leader>db", "<cmd>PBToggleBreakpoint<CR>", desc = "Debug toggle breakpoint" },
			{ "<leader>DB", "<cmd>PBSetConditionalBreakpoint<CR>" },
			{ "<leader>DC", "<cmd>PBClearAllBreakpoints<CR>" },
			--[[ 			{ "<leader>dw", "<cmd>lua require('dap-view').add_expr()<CR>", desc = "Debug watch" }, ]]
			{
				"<leader>da",
				function()
					local widgets = require("dap.ui.widgets")
					-- Create a horizontal split at the top
					vim.cmd("topleft split")
					-- Create the sidebar in the new split
					local sidebar = widgets.sidebar(widgets.scopes)
					sidebar.open()
					vim.cmd("wincmd q")
				end,
				desc = "Debug latest test",
			},
			{
				"<leader>dh",
				function()
					require("dap.ui.widgets").hover(nil, { border = "single" })
				end,
				-- "<cmd>lua require('dap.ui.widgets').hover(nil, { border = 'rounded' })<CR>",
				desc = "Debug latest test",
			},
			{
				"<leader>dp",
				function()
					require("dap.ui.widgets").preview(nil)
				end,
				desc = "Debug latest test",
			},
			-- { "<leader>de", "lua :require('dapui').eval(nil, { enter = true })<CR>" },
		},
		config = function()
			local dap = require("dap")

			-- require("dapui").setup(
			-- 	-- 	{
			-- 	-- 	icons = { expanded = "v", collapsed = ">" },
			-- 	-- 	mappings = {
			-- 	-- 		-- Use a table to apply multiple mappings
			-- 	-- 		expand = { "<tab>", "<CR>", "<2-LeftMouse>" },
			-- 	-- 		open = "o",
			-- 	-- 		remove = "d",
			-- 	-- 		edit = "e",
			-- 	-- 		repl = "r",
			-- 	-- 		toggle = "t",
			-- 	-- 	},
			-- 	-- 	expand_lines = vim.fn.has("nvim-0.7") == 1,
			-- 	-- 	controls = {
			-- 	-- 		-- Requires Neovim nightly (or 0.8 when released)
			-- 	-- 		enabled = true,
			-- 	-- 		-- Display controls in this element
			-- 	-- 		element = "repl",
			-- 	-- 	},
			-- 	-- 	floating = {
			-- 	-- 		max_height = nil,
			-- 	-- 		max_width = nil,
			-- 	-- 		border = "single",
			-- 	-- 		mappings = {
			-- 	-- 			close = { "q", "<Esc>" },
			-- 	-- 		},
			-- 	-- 	},
			-- 	-- 	windows = { indent = 1 },
			-- 	-- 	render = {
			-- 	-- 		max_type_length = nil, -- Can be integer or nil.
			-- 	-- 		max_value_lines = 100, -- Can be integer or nil.
			-- 	-- 	},
			-- 	-- }
			-- )

			-- require('dap-go').setup()

			-- local dapui = require("dapui")
			-- dap.listeners.after.event_initialized["dapui_config"] = function()
			-- 	dapui.open()
			-- end
			-- dap.listeners.before.event_terminated["dapui_config"] = function()
			-- 	dapui.close()
			-- end
			-- dap.listeners.before.event_exited["dapui_config"] = function()
			-- 	dapui.close()
			-- end
			--
			-- local types_enabled = true
			-- Toggle_types = function()
			-- 	types_enabled = not types_enabled
			-- 	dapui.update_render({ max_type_length = types_enabled and -1 or 0 })
			-- end
			--
			-- vim.keymap.set("n", "yot", Toggle_types, {})
			-- vim.keymap.set("n", "yot", "<cmd>lua Toggle_types()<CR>", {})

			--[[ local dv = require("dap-view")
			dap.listeners.before.attach["dap-view-config"] = function()
				dv.open()
			end
			dap.listeners.before.launch["dap-view-config"] = function()
				dv.open()
			end
			dap.listeners.before.event_terminated["dap-view-config"] = function()
				dv.close()
			end
			dap.listeners.before.event_exited["dap-view-config"] = function()
				dv.close()
			end ]]

			-- dap.configurations = {
			-- 	go = {
			-- 		-- {
			-- 		-- 	type = "go",
			-- 		-- 	name = "Debug",
			-- 		-- 	request = "launch",
			-- 		-- 	program = "${file}",
			-- 		-- },
			-- 		-- {
			-- 		-- 	type = "go",
			-- 		-- 	name = "Debug test (go.mod)",
			-- 		-- 	request = "launch",
			-- 		-- 	mode = "test",
			-- 		-- 	program = "./${relativeFileDirname}",
			-- 		-- },
			-- 		-- {
			-- 		-- 	type = "go",
			-- 		-- 	name = "Attach (Pick Process)",
			-- 		-- 	mode = "local",
			-- 		-- 	request = "attach",
			-- 		-- 	processId = require("dap.utils").pick_process,
			-- 		-- },
			-- 		-- {
			-- 		-- 	type = "go",
			-- 		-- 	name = "Attach (127.0.0.1:9080)",
			-- 		-- 	mode = "remote",
			-- 		-- 	request = "attach",
			-- 		-- 	port = "9080",
			-- 		-- },
			-- 	},
			-- }
			-- dap.adapters.go = {
			-- 	type = "server",
			-- 	port = "${port}",
			-- 	executable = {
			-- 		command = vim.fn.stdpath("data") .. "/mason/bin/dlv",
			-- 		args = { "dap", "-l", "127.0.0.1:${port}" },
			-- 	},
			-- }

			local function get_arguments()
				return coroutine.create(function(dap_run_co)
					local args = {}
					vim.ui.input({ prompt = "Args: " }, function(input)
						args = vim.split(input or "", " ")
						coroutine.resume(dap_run_co, args)
					end)
				end)
			end
			vim.api.nvim_create_autocmd({ "FileType" }, {
				pattern = { "dap-float" },
				callback = function(evt)
					vim.keymap.set("n", "q", "<C-w>q", { silent = true, buffer = evt.buf })
					vim.keymap.set("n", "<leader>da", "<C-w>q", { silent = true, buffer = evt.buf })
					vim.keymap.set("n", "<leader>dh", "<C-w>q", { silent = true, buffer = evt.buf })
				end,
			})
			require("dap-go").setup({
				-- Additional dap configurations can be added.
				-- dap_configurations accepts a list of tables where each entry
				-- represents a dap configuration. For more details do:
				-- :help dap-configuration
				dap_configurations = {
					{
						type = "go",
						name = "Package (arguments)",
						program = "${workspaceFolder}",
						args = get_arguments(),
						request = "launch",
						output_mode = "remote",
					},
					{
						type = "go",
						name = "Package (config file)",
						program = "${workspaceFolder}",
						args = { "--config_file", "config.yaml" },
						request = "launch",
						output_mode = "remote",
					},
				},
				-- delve configurations
				delve = {
					-- time to wait for delve to initialize the debug session.
					-- default to 20 seconds
					initialize_timeout_sec = 20,
					-- a string that defines the port to start delve debugger.
					-- default to string "${port}" which instructs nvim-dap
					-- to start the process in a random available port
					port = "${port}",
				},
			})
		end,
	},
}
