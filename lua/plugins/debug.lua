return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
			"nvim-telescope/telescope-dap.nvim",
			-- { "daic0r/dap-helper.nvim", config = true },
		},
	--stylua: ignore
	keys = {
		{ "yod", function() require("dapui").toggle() end, { noremap = true, silent = true, desc = "Toggle dapui" } },
		{ "<leader>dc", ":lua require('dap').continue()<CR>", desc = "Debug continue" },
		{ "<leader>dl", ":lua require('dap').run_to_cursor()<CR>", desc = "Debug run to cursor" },
		{ "<leader>do", ":lua require('dap').step_over()<CR>", desc = "Debug step ove" },
		{ "<leader>di", ":lua require('dap').step_into()<CR>", desc = "Debug step into" },
		{ "<leader>du", ":lua require('dap').up()<CR>", desc = "Debug step up callstack" },
		{ "<leader>dd", ":lua require('dap').down()<CR>", desc = "Debug step down callstack" },
		{ "<leader>DO", ":lua require('dap').step_out()<CR>", desc = "Debug  step out" },
		{ "<leader>db", ":lua require('dap').toggle_breakpoint()<CR>", desc = "Debug toggle breakpoint" },
		{ "<leader>DB", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", desc = "Debug toggle conditional breakpoint" },
		{ "<leader>dt", " :lua require('dap-go').debug_test()<CR>", desc = "Debug nearest test" },
		{ "<leader>dr", ":lua require('dap-go').debug_last_test()<CR>", desc = "Debug latest test" },
	},
		config = function()
			local ok, dap = pcall(require, "dap")
			if not ok then
				return
			end

			require("telescope").load_extension("dap")
			require("dapui").setup({
				icons = { expanded = "v", collapsed = ">" },
				mappings = {
					-- Use a table to apply multiple mappings
					expand = { "<tab>", "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
					toggle = "t",
				},
				-- Use this to override mappings for specific elements
				element_mappings = {
					-- Example:
					-- stacks = {
					--   open = "<CR>",
					--   expand = "o",
					-- }
				},
				-- Expand lines larger than the window
				-- Requires >= 0.7
				expand_lines = vim.fn.has("nvim-0.7") == 1,
				-- Layouts define sections of the screen to place windows.
				-- The position can be "left", "right", "top" or "bottom".
				-- The size specifies the height/width depending on position. It can be an Int
				-- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
				-- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
				-- Elements are the elements shown in the layout (in order).
				-- Layouts are opened in order so that earlier layouts take priority in window sizing.
				layouts = {
					{
						elements = { { id = "breakpoints", size = 0.2 }, "stacks", "repl", "watches" },
						size = 60, -- 40 columns
						position = "right",
					},
					{
						elements = { "scopes" },
						size = 0.25, -- 25% of total lines
						position = "bottom",
					},
				},
				controls = {
					-- Requires Neovim nightly (or 0.8 when released)
					enabled = true,
					-- Display controls in this element
					element = "repl",
				},
				floating = {
					max_height = nil,
					max_width = nil,
					border = "single",
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				windows = { indent = 1 },
				render = {
					max_type_length = nil, -- Can be integer or nil.
					max_value_lines = 100, -- Can be integer or nil.
				},
			})

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
			-- vim.keymap.set("n", "yot", ":lua Toggle_types()<CR>", {})
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
	{
		"nvim-neotest/neotest",
		dependencies = {
			-- "vim-test/vim-test",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-python",
			"nvim-neotest/neotest-plenary",
			"nvim-neotest/neotest-go",
			"rouge8/neotest-rust",
		},
		event = "VeryLazy",
		config = function()
			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						local message =
							diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
						return message
					end,
				},
			}, neotest_ns)
			require("neotest").setup({
				quickfix = { enabled = true, open = true },
				diagnostic = {
					enabled = true,
					severity = 4,
				},
				adapters = {
					require("neotest-go")({
						experimental = { test_table = true },
					}),
					require("neotest-plenary"),
					require("neotest-rust"),
				},
			})
		end,
	--stylua: ignore
	keys = {
		{ "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", desc = "test Run File" },
		{ "<leader>twf", "<cmd>lua require('neotest').watch.watch(vim.fn.expand('%'))<CR>", desc = "test Watch File" },
		{ "<leader>tdf", "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<CR>", desc = "test Debug File"},
		{ "<leader>tl", "<cmd>lua require('neotest').run.run_last()<CR>", desc = "test Run Last" },
		{ "<leader>twl", "<cmd>lua require('neotest').watch.watch_last()<CR>", desc = "test Watch Last" },
		{ "<leader>tdl", "<cmd>lua require('neotest').run.run_last({ strategy = 'dap' })<CR>", desc = "test Debug Last" },
		{ "<leader>tn", "<cmd>lua require('neotest').run.run()<CR>", desc = "test Run Nearest" },
		{ "<leader>twn", "<cmd>lua require('neotest').watch.watch()<CR>", desc = "test Watch Nearest" },
		{ "<leader>tdn", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>", desc = "test Debug Nearest" },
		{ "<leader>to", "<cmd>lua require('neotest').output.open({ enter = true })<CR>", desc = "test Output" },
		{ "<leader>ts", "<cmd>lua require('neotest').run.stop()<CR>", desc = "test Stop" },
		{ "<leader>twq", "<cmd>lua require('neotest').watch.stop()<CR>", desc = "test Stop" },
		{ "<leader>tt", "<cmd>lua require('neotest').summary.toggle()<CR>", desc = "test Summary" },
	},
	},
}
