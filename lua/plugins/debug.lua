return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
		},
		config = function()
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
		keys = {
			{ "<F5>", "<cmd>lua require('dap').continue()<CR>", desc = "Debug continue" },
			{ "<F4>", "<cmd>lua require('dap').step_into()<CR>", desc = "Debug step into" },
			{ "<F3>", "<cmd>lua require('dap').step_over()<CR>", desc = "Debug step ove" },
			{ "<F2>", "<cmd>lua require('dap').step_out()<CR>", desc = "Debug  step out" },
			{ "<leader>dc", "<cmd>lua require('dap').run_to_cursor()<CR>", desc = "Debug run to cursor" },
			{ "<leader>du", "<cmd>lua require('dap').up()<CR>", desc = "Debug step up callstack" },
			{ "<leader>dd", "<cmd>lua require('dap').down()<CR>", desc = "Debug step down callstack" },
			{ "<leader>db", "<cmd>DapToggleBreakpoint<CR>", desc = "Debug toggle breakpoint" },
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
	},
}
