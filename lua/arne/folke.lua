return {
	{
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({
				window = {
					width = 160,
					options = {
						number = true,
						relativenumber = true,
					},
				},
			})
		end,
		-- stylua: ignore
		keys = {
            { "yoz", function() require("zen-mode").toggle() end, desc = "Toggle zen mode" },
		},
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help" } },
        -- stylua: ignore
        keys = {
            { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
            { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
            { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
        },
	},
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
		keys = {
			{ "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
		},
	},
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = "BufReadPre",
		opts = {
			keywords = {
				FIX = {
					icon = "? ", -- icon used for the sign, and in search results
					color = "error", -- can be a hex color, or a named color (see below)
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
					-- signs = false, -- configure signs for some keywords individually
				},
				TODO = { icon = "✓ ", color = "info" },
				NOTE = { icon = "󰲶 ", color = "hint", alt = { "INFO" } },
				HACK = { icon = " ", color = "error" },
				TEST = { icon = "󱈲 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
				PERF = { icon = "󰅒 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				AAA = { icon = " ", color = "test" },
				-- TODO: = { icon = "✓ ", color = "info" },
				-- NOTE: = { icon = "✏ ", color = "hint", alt = { "INFO" } },
				-- HACK: = { icon = "? ", color = "warning" },
				-- WARN: = { icon = "! ", color = "warning", alt = { "WARNING", "XXX" } },
				-- PERF: = { icon = "> ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				-- TEST: = { icon = "T ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
				-- AAA: = { icon = "A ", color = "warning" },
			},
			highlight = {
				before = "fg", -- "fg" or "bg" or empty
				keyword = "bg", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
			},
		},
		keys = {
			{ "]t", "<cmd> require('todo-comments').jump_next()<CR>", desc = "Next todo comment" },
			{ "[t", "<cmd> require('todo-comments').jump_prev()<CR>", desc = "Previous todo comment" },
			-- { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo Trouble" },
			{ "<leader>xa", "<cmd>TodoQuickFix keywords=AAA<cr>", desc = "Todo Trouble Arne" },
			{ "<leader>xA", "<cmd>TodoTelescope keywords=AAA<cr>", desc = "Todo Telescope Arne" },
			{ "<leader>xt", "<cmd>TodoQuickFix<cr>", desc = "Todo Trouble" },
			{ "<leader>xT", "<cmd>TodoTelescope<cr>", desc = "Todo Telescope" },
		},
	},
	{
		-- Show help for keycombos
		"folke/which-key.nvim",
		event = "BufReadPost",
		opts = {
			plugins = {
				marks = true, -- shows a list of your marks on ' and `
				registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
				spelling = {
					enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
					suggestions = 20, -- how many suggestions should be shown in the list?
				},
				-- the presets plugin, adds help for a bunch of default keybindings in Neovim
				-- No actual key bindings are created
				presets = {
					operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
					motions = false, -- adds help for motions
					text_objects = false, -- help for text objects triggered after entering an operator
					windows = true, -- default bindings on <c-w>
					nav = true, -- misc bindings to work with windows
					z = true, -- bindings for folds, spelling and others prefixed with z
					g = true, -- bindings for prefixed with g
				},
			},
			-- add operators that will trigger motion and text object completion
			-- to enable all native operators, set the preset / operators plugin above
			-- operators = { gc = "Comments" },
			key_labels = {
				-- override the label used to display some keys. It doesn't effect WK in any other way.
				-- For example:
				-- ["<space>"] = "SPC",
				-- ["<cr>"] = "RET",
				-- ["<tab>"] = "TAB",
			},
			icons = {
				breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
				separator = "➜", -- symbol used between a key and it's label
				group = "+", -- symbol prepended to a group
			},
			popup_mappings = {
				scroll_down = "<c-d>", -- binding to scroll down inside the popup
				scroll_up = "<c-u>", -- binding to scroll up inside the popup
			},
			window = {
				border = "none", -- none, single, double, shadow
				position = "bottom", -- bottom, top
				margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
				padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
				winblend = 0,
			},
			layout = {
				height = { min = 4, max = 25 }, -- min and max height of the columns
				width = { min = 20, max = 50 }, -- min and max width of the columns
				spacing = 3, -- spacing between columns
				align = "left", -- align columns left, center or right
			},
			ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
			hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
			show_help = true, -- show help message on the command line when the popup is visible
			triggers = "auto", -- automatically setup triggers
			-- triggers = {"<leader>"} -- or specify a list manually
			triggers_blacklist = {
				-- list of mode / prefixes that should never be hooked by WhichKey
				-- this is mostly relevant for key maps that start with a native binding
				-- most people should not need to change this
				i = { "j", "k" },
				v = { "j", "k" },
			},
		},
	},
}
