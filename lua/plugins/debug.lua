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
		{ "<leader>sc", ":lua require'dap'.continue()<CR>", desc = "Debug continue" },
		{ "<leader>sl", ":lua require'dap'.run_to_cursor()<CR>", desc = "Debug run to cursor" },
		{ "<leader>so", ":lua require'dap'.step_over()<CR>", desc = "Debug step ove" },
		{ "<leader>si", ":lua require'dap'.step_into()<CR>", desc = "Debug step into" },
		{ "<leader>su", ":lua require'dap'.up()<CR>", desc = "Debug step up callstack" },
		{ "<leader>sd", ":lua require'dap'.down()<CR>", desc = "Debug step down callstack" },
		{ "<leader>sO", ":lua require'dap'.step_out()<CR>", desc = "Debug  step out" },
		{ "<leader>bb", ":lua require'dap'.toggle_breakpoint()<CR>", desc = "Debug toggle breakpoint" },
		{ "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", desc = "Debug toggle conditional breakpoint" },
		{ "<leader>sR", ":lua require'dap'.repl.open()<CR>", desc = "Debug open repl" },
		{ "<leader>sf", ":lua require('dapui').float_element('breakpoints')<CR>", desc = "Debug float element" },
		{ "<leader>st", " :lua require('dap-go').debug_test()<CR>", desc = "Debug nearest test" },
		{ "<leader>sr", ":lua require('dap-go').debug_last_test()<CR>", desc = "Debug latest test" },
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

			function Toggle_type_info()
				local config = require("dapui.config")
				if config.render().max_type_length == nil then
					config.setup({ render = { max_type_length = 0 } })
				else
					config.setup({ render = { max_type_length = nil } })
				end
			end

			local types_enabled = true
			Toggle_types = function()
				types_enabled = not types_enabled
				dapui.update_render({ max_type_length = types_enabled and -1 or 0 })
			end

			vim.keymap.set("n", "yot", ":lua Toggle_types()<CR>", {})
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
					-- {
					-- 	-- Must be "go" or it will be ignored by the plugin
					-- 	type = "go",
					-- 	name = "Attach remote",
					-- 	mode = "remote",
					-- 	request = "attach",
					-- },
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
			"vim-test/vim-test",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-python",
			"nvim-neotest/neotest-plenary",
			"nvim-neotest/neotest-go",
			"rouge8/neotest-rust",
		},
		cmd = {
			"TestNearest",
			"TestFile",
			"TestSuite",
			"TestLast",
			"TestVisit",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-go"),
					require("neotest-plenary"),
					require("neotest-rust"),
				},
			})
		end,
	--stylua: ignore
	keys = {
		{ "<leader>ta", "<cmd>lua require('neotest').run.attach()<cr>", desc = "test Attach" },
		{ "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "test Run File" },
		{ "<leader>tF", "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", desc = "test Debug File"},
		{ "<leader>tl", "<cmd>lua require('neotest').run.run_last()<cr>", desc = "test Run Last" },
		{ "<leader>tL", "<cmd>lua require('neotest').run.run_last({ strategy = 'dap' })<cr>", desc = "test Debug Last" },
		{ "<leader>tn", "<cmd>lua require('neotest').run.run()<cr>", desc = "test Run Nearest" },
		{ "<leader>tN", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", desc = "test Debug Nearest" },
		{ "<leader>to", "<cmd>lua require('neotest').output.open({ enter = true })<cr>", desc = "test Output" },
		{ "<leader>tS", "<cmd>lua require('neotest').run.stop()<cr>", desc = "test Stop" },
		{ "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<cr>", desc = "test Summary" },
		{ "<leader>tp", "<Plug>PlenarytestFile", desc = "PlenarytestFile" },
		{ "<leader>tv", "<cmd>TestVisit<cr>", desc = "test Visit" },
		{ "<leader>tx", "<cmd>TestSuite<cr>", desc = "test Suite" },
	},
	},
}
