return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
		},
		keys = {
			{ "yod", "<cmd>lua  require('dapui').toggle()<CR>", { noremap = true, silent = true } },
			{ "<leader>dc", "<cmd>lua require('dap').continue()<CR>", desc = "Debug continue" },
			{ "<leader>dl", "<cmd>lua require('dap').run_to_cursor()<CR>", desc = "Debug run to cursor" },
			{ "<leader>do", "<cmd>lua require('dap').step_over()<CR>", desc = "Debug step ove" },
			{ "<leader>di", "<cmd>lua require('dap').step_into()<CR>", desc = "Debug step into" },
			{ "<leader>du", "<cmd>lua require('dap').up()<CR>", desc = "Debug step up callstack" },
			{ "<leader>dd", "<cmd>lua require('dap').down()<CR>", desc = "Debug step down callstack" },
			{ "<leader>DO", "<cmd>lua require('dap').step_out()<CR>", desc = "Debug  step out" },
			{ "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>", desc = "Debug toggle breakpoint" },
			{ "<leader>DB", "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>" },
			{ "<leader>dr", "<cmd>lua require('dap-go').debug_last_test()<CR>", desc = "Debug latest test" },
			{ "<leader>de", "lua :require('dapui').eval(nil, { enter = true })<CR>" },
		},
		config = function()
			local dap = require("dap")

			require("dapui").setup(
				-- 	{
				-- 	icons = { expanded = "v", collapsed = ">" },
				-- 	mappings = {
				-- 		-- Use a table to apply multiple mappings
				-- 		expand = { "<tab>", "<CR>", "<2-LeftMouse>" },
				-- 		open = "o",
				-- 		remove = "d",
				-- 		edit = "e",
				-- 		repl = "r",
				-- 		toggle = "t",
				-- 	},
				-- 	expand_lines = vim.fn.has("nvim-0.7") == 1,
				-- 	controls = {
				-- 		-- Requires Neovim nightly (or 0.8 when released)
				-- 		enabled = true,
				-- 		-- Display controls in this element
				-- 		element = "repl",
				-- 	},
				-- 	floating = {
				-- 		max_height = nil,
				-- 		max_width = nil,
				-- 		border = "single",
				-- 		mappings = {
				-- 			close = { "q", "<Esc>" },
				-- 		},
				-- 	},
				-- 	windows = { indent = 1 },
				-- 	render = {
				-- 		max_type_length = nil, -- Can be integer or nil.
				-- 		max_value_lines = 100, -- Can be integer or nil.
				-- 	},
				-- }
			)

			-- require('dap-go').setup()

			local dapui = require("dapui")
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			local types_enabled = true
			Toggle_types = function()
				types_enabled = not types_enabled
				dapui.update_render({ max_type_length = types_enabled and -1 or 0 })
			end

			vim.keymap.set("n", "yot", Toggle_types, {})
			-- vim.keymap.set("n", "yot", "<cmd>lua Toggle_types()<CR>", {})
			dap.configurations = {
				go = {
					-- {
					-- 	type = "go",
					-- 	name = "Debug",
					-- 	request = "launch",
					-- 	program = "${file}",
					-- },
					-- {
					-- 	type = "go",
					-- 	name = "Debug test (go.mod)",
					-- 	request = "launch",
					-- 	mode = "test",
					-- 	program = "./${relativeFileDirname}",
					-- },
					-- {
					-- 	type = "go",
					-- 	name = "Attach (Pick Process)",
					-- 	mode = "local",
					-- 	request = "attach",
					-- 	processId = require("dap.utils").pick_process,
					-- },
					-- {
					-- 	type = "go",
					-- 	name = "Attach (127.0.0.1:9080)",
					-- 	mode = "remote",
					-- 	request = "attach",
					-- 	port = "9080",
					-- },
				},
			}
			-- dap.adapters.go = {
			-- 	type = "server",
			-- 	port = "${port}",
			-- 	executable = {
			-- 		command = vim.fn.stdpath("data") .. "/mason/bin/dlv",
			-- 		args = { "dap", "-l", "127.0.0.1:${port}" },
			-- 	},
			-- }
			require("dap-go").setup({
				-- Additional dap configurations can be added.
				-- dap_configurations accepts a list of tables where each entry
				-- represents a dap configuration. For more details do:
				-- :help dap-configuration
				dap_configurations = {
					{
						type = "go",
						name = "lynxcontroller",
						program = "main.go",
						args = { "--log_level", "debug", "--log_directory", "", "--config_file", "config.yaml" },
						request = "launch",
					},
					{
						type = "go",
						name = "LEMS",
						program = "main.go",
						args = { "--config_file=config.yaml" },
						request = "launch",
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
