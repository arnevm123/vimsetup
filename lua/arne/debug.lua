return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"mfussenegger/nvim-dap",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-telescope/telescope-dap.nvim",
	},
	cmd = { "GoDebug", "GoTest" },
	--stylua: ignore
	keys = {
		{ "yod", function() require("dapui").toggle() end, { noremap = true, silent = true, desc = "Toggle dapui" } },
		{ "<F5>", ":lua require'dap'.continue()<CR>", desc = "Debug continue" },
		{ "<F9>", ":lua require'dap'.run_to_cursor()<CR>", desc = "Debug run to cursor" },
		{ "<F10>", ":lua require'dap'.step_over()<CR>", desc = "Debug step ove" },
		{ "<F11>", ":lua require'dap'.step_into()<CR>", desc = "Debug step into" },
		{ "<F12>", ":lua require'dap'.step_out()<CR>", desc = "Debug  step out" },
		{ "<F7>", ":lua require'go.dap'.run()<CR>", desc = "Debug run" },
		{ "<F6>", ":lua require'go.dap'.stop()<CR>", desc = "Debug stop" },
		{ "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>", desc = "Debug toggle breakpoint" },
		{ "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", desc = "Debug toggle conditional breakpoint" },
		{ "<leader>dr", ":lua require'dap'.repl.open()<CR>", desc = "Debug open repl" },
		{ "<leader>df", ":lua require('dapui').float_element('breakpoints')<CR>", desc = "Debug float element" },
	},
	config = function()
		local ok, dap = pcall(require, "dap")
		if not ok then
			return
		end
		--
		require("dapui").setup({
			icons = { expanded = "v", collapsed = ">", current_frame = "-" },
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
					elements = { { id = "breakpoints", size = 0.2 }, "watches", "repl", "console" },
					size = 80, -- 80 columns
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
				icons = {
					pause = "⏸︎",
					play = "⏵︎",
					step_into = "⏩︎",
					step_over = "⏭︎ ",
					step_out = "⏬︎",
					step_back = " ⏪︎",
					run_last = " ⏱︎",
					terminate = "⏹︎",
				},
			},
			floating = {
				max_height = nil, -- These can be integers or a float between 0 and 1.
				max_width = nil, -- Floats will be treated as percentage of your screen.
				border = "single", -- Border style. Can be "single", "double" or "rounded"
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

		-- require("nvim-dap-virtual-text").setup()
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
		toggle_types = function()
			types_enabled = not types_enabled
			dapui.update_render({ max_type_length = types_enabled and -1 or 0 })
		end

		vim.keymap.set("n", "yot", ":lua toggle_types()<CR>", {})

		require("nvim-dap-virtual-text").setup({
			enabled = true, -- enable this plugin (the default)
			enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
			highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
			highlight_new_as_changed = true, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
			show_stop_reason = true, -- show stop reason when stopped for exceptions
			commented = true, -- prefix virtual text with comment string
			only_first_definition = false, -- only show virtual text at first definition (if there are multiple)
			all_references = true, -- show virtual text on all all references of the variable (not only definitions)
			filter_references_pattern = "<module", -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
			-- experimental features:
			virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
			all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
			virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
			virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
			-- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
		})
		-- dap.adapters.go = function(callback, config)
		--     local stdout = vim.loop.new_pipe(false)
		--     local handle
		--     local pid_or_err
		--     local port = 38697
		--     local opts = {
		--         stdio = { nil, stdout },
		--         args = { "dap", "-l", "127.0.0.1:" .. port },
		--         detached = true,
		--     }
		--     handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
		--         stdout:close()
		--         handle:close()
		--         if code ~= 0 then
		--             print("dlv exited with code", code)
		--         end
		--     end)
		--     assert(handle, "Error running dlv: " .. tostring(pid_or_err))
		--     stdout:read_start(function(err, chunk)
		--         assert(not err, err)
		--         if chunk then
		--             vim.schedule(function()
		--                 require("dap.repl").append(chunk)
		--             end)
		--         end
		--     end)
		--     vim.defer_fn(function()
		--         callback({ type = "server", host = "127.0.0.1", port = port })
		--         end, 100)
		-- end
	end,
}
