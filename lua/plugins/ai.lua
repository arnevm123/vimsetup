return {
	{
		"zbirenbaum/copilot.lua",
		event = "VeryLazy",
		opts = {
			panel = {
				enabled = true,
				auto_refresh = false,
				keymap = {
					jump_prev = "[[",
					jump_next = "]]",
					accept = "<CR>",
					refresh = "gr",
					open = "<C-CR>",
				},
				layout = {
					position = "top", -- | top | left | right
					ratio = 0.3,
				},
			},
			suggestion = {
				enabled = true,
				auto_trigger = true,
				hide_during_completion = true,
				debounce = 75,
				keymap = {
					accept = "<C-;>",
					accept_word = false,
					accept_line = false,
					next = false,
					prev = false,
					dismiss = "<C-/>",
				},
			},
		},
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false, -- set this if you want to always pull the latest change
		opts = {
			provider = "copilot",
			hints = { enabled = false },
			windows = {
				position = "bottom",
				width = 70,
				sidebar_header = { enabled = false },
				edit = { border = "single" },
				ask = { border = "single" },
			},
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"zbirenbaum/copilot.lua",
			"nvim-treesitter/nvim-treesitter",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			{
				"stevearc/dressing.nvim",
				opts = { enabled = false, input = { enabled = false }, select = { enabled = false } },
			},
			{
				"MeanderingProgrammer/render-markdown.nvim",
				opts = { file_types = { "Avante" } },
				ft = { "Avante" },
			},
		},
	},
}
