return {
	{
		lazy = false,
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			{
				"igorlfs/nvim-dap-view",
				opts = function()
					local function hl(text, group)
						return require("dap-view.util.statusline").hl(text, group, true, false)
					end

					local function icon(name) return require("dap-view.setup").config.icons[name] end

					local function hint(key) return hl(" [" .. key .. "]", "ControlNC") end

					return {
						winbar = {
							sections = { "scopes", "watches", "exceptions", "breakpoints", "threads", "repl" },
							default_section = "scopes",
							controls = {
								enabled = true,
								custom_buttons = {
									play = {
										render = function(session)
											local pausable = session and not session.stopped_thread_id
											local i = hl(
												pausable and icon("pause") or icon("play"),
												pausable and "ControlPause" or "ControlPlay"
											)
											return i .. hint("F5")
										end,
										action = function()
											local dap = require("dap")
											local session = dap.session()
											local fn = session and not session.stopped_thread_id and dap.pause
												or dap.continue
											fn()
										end,
									},
									step_into = {
										render = function(session)
											local stopped = session and session.stopped_thread_id
											local i =
												hl(icon("step_into"), stopped and "ControlStepInto" or "ControlNC")
											return i .. hint("F4")
										end,
										action = function() require("dap").step_into() end,
									},
									step_over = {
										render = function(session)
											local stopped = session and session.stopped_thread_id
											local i =
												hl(icon("step_over"), stopped and "ControlStepOver" or "ControlNC")
											return i .. hint("F3")
										end,
										action = function() require("dap").step_over() end,
									},
									step_out = {
										render = function(session)
											local stopped = session and session.stopped_thread_id
											local i = hl(icon("step_out"), stopped and "ControlStepOut" or "ControlNC")
											return i .. hint("F2")
										end,
										action = function() require("dap").step_out() end,
									},
									step_back = {
										render = function(session)
											local stopped = session and session.stopped_thread_id
											local i =
												hl(icon("step_back"), stopped and "ControlStepBack" or "ControlNC")
											return i .. hint("F1")
										end,
										action = function() require("dap").step_back() end,
									},
									run_last = {
										render = function() return hl(icon("run_last"), "ControlRunLast") .. hint("F6") end,
										action = function() require("dap").run_last() end,
									},
									terminate = {
										render = function(session)
											local i =
												hl(icon("terminate"), session and "ControlTerminate" or "ControlNC")
											return i .. hint("F7")
										end,
										action = function() require("dap").terminate() end,
									},
									disconnect = {
										render = function(session)
											local i =
												hl(icon("disconnect"), session and "ControlDisconnect" or "ControlNC")
											return i .. hint("F8")
										end,
										action = function() require("dap").disconnect() end,
									},
								},
							},
						},
					}
				end,
			},
		},
		config = function() require("dap-go").setup({}) end,
		keys = {
			{ "<F5>", "<cmd>lua require('dap').continue()<CR>", desc = "Debug continue" },
			{ "<F4>", "<cmd>lua require('dap').step_into()<CR>", desc = "Debug step into" },
			{ "<F3>", "<cmd>lua require('dap').step_over()<CR>", desc = "Debug step ove" },
			{ "<F2>", "<cmd>lua require('dap').step_out()<CR>", desc = "Debug step out" },
			{ "<F1>", "<cmd>lua require('dap').step_back()<CR>", desc = "Debug step back" },
			{ "<F6>", "<cmd>lua require('dap').run_last()<CR>", desc = "Debug run last" },
			{ "<F7>", "<cmd>lua require('dap').terminate()<CR>", desc = "Debug terminate" },
			{ "<F8>", "<cmd>lua require('dap').disconnect()<CR>", desc = "Debug disconnect" },
			{ "<leader>dc", "<cmd>lua require('dap').run_to_cursor()<CR>", desc = "Debug run to cursor" },
			{ "<leader>du", "<cmd>lua require('dap').up()<CR>", desc = "Debug step up callstack" },
			{ "<leader>dd", "<cmd>lua require('dap').down()<CR>", desc = "Debug step down callstack" },
			{ "<leader>db", "<cmd>DapToggleBreakpoint<CR>", desc = "Debug toggle breakpoint" },
			{ "<leader>dv", "<cmd>DapViewToggle<CR>", desc = "Debug Show" },
			{ "<leader>dw", "<cmd>DapViewWatch<CR>", desc = "Debug preview" },
		},
	},
}
