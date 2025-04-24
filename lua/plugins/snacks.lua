return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			zen = { enabled = false },
			words = { enabled = false },
			scroll = { enabled = false },
			indent = { enabled = false },
			animate = { enabled = false },
			notifier = { enabled = false },
			statuscolumn = { enabled = false },
			-- picker = {
			-- 	layout = { preset = "custom" },
			-- 	layouts = {
			-- 		["custom"] = {
			-- 			layout = {
			-- 				box = "vertical",
			-- 				border = "none",
			-- 				{ win = "preview", height = 0.75, border = "none" },
			-- 				{ win = "input", height = 1, border = "top" },
			-- 				{ win = "list", border = "top" },
			-- 			},
			-- 		},
			-- 	},
			-- 	icons = { files = { enabled = false } },
			-- },

			bigfile = { enabled = true },
			quickfile = { enabled = true },
		},
		keys = {
			{ "<leader>gb", "<cmd>lua Snacks.git.blame_line() <CR>", desc = "Git Blame Line" },
			{ "<leader>gB", "<cmd>lua Snacks.gitbrowse()<CR>", desc = "Git Browse" },
			{ "]r", "<cmd>lua Snacks.words.jump(vim.v.count1)<CR>", desc = "Next Reference" },
			{ "[r", "<cmd>lua Snacks.words.jump(-vim.v.count1)<CR>", desc = "Prev Reference" },
			{
				"yor",
				function()
					local s = require("snacks")
					if s.words.is_enabled() then
						s.words.disable()
					else
						s.words.enable()
						vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(":<Esc>", true, false, true), "n", false)
					end
				end,
				desc = "toggle lsp words",
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					require("snacks").toggle.diagnostics():map("yoe")
				end,
			})
		end,
	},
}
