return {
	{
		"folke/sidekick.nvim",
		opts = {
			nes = { enabled = true },
			cli = { mux = { backend = "tmux", enabled = true } },
		},
		event = "VeryLazy",
		keys = {
			{
				"<leader>su",
				function() require("sidekick.nes").update() end,
				desc = "Update Next Edit Suggestion",
			},
			{
				"<leader>st",
				function()
					local enabled = require("sidekick.nes").enabled
					require("sidekick.nes").enable(not enabled)
					local state = not enabled and "enabled" or "disabled"
					vim.notify("Next Edit Suggestion " .. state, vim.log.levels.INFO, { title = "Sidekick" })
				end,
				desc = "Toggle Next Edit Suggestion",
			},
			{
				"yoa",
				function()
					local sidekick_enabled = require("sidekick.nes").enabled
					local copilot_enabled = vim.lsp.inline_completion.is_enabled()
					local enabled = sidekick_enabled or copilot_enabled
					require("sidekick.nes").enable(not enabled)
					vim.lsp.inline_completion.enable(not enabled)
					local state = not enabled and "enabled" or "disabled"
					vim.notify("Ai is now " .. state, vim.log.levels.INFO, { title = "Ai" })
				end,
				desc = "Toggle Next Edit Suggestion",
			},
			{
				"<c-;>",
				function() require("sidekick").nes_jump_or_apply() end,
				desc = "Goto/Apply Next Edit Suggestion",
			},
			{
				"<c-.>",
				function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
				mode = { "n", "x", "i", "t" },
				desc = "Sidekick Switch Focus",
			},
		},
	},
	{
		"ThePrimeagen/99",
		event = "VeryLazy",
		config = function()
			local _99 = require("99")
			local cwd = vim.uv.cwd()
			local basename = vim.fs.basename(cwd)
			_99.setup({
				provider = _99.Providers.ClaudeCodeProvider,  -- default: OpenCodeProvider
				logger = {
					level = _99.DEBUG,
					path = "/tmp/" .. basename .. ".99.debug",
					print_on_error = true,
				},
				tmp_dir = "./tmp",

				completion = {
					custom_rules = {
						"scratch/custom_rules/",
					},

					files = { },
					source = "blink", -- "native" (default), "cmp", or "blink"
				},
				md_files = {
					"AGENT.md",
				},
			})
			vim.keymap.set("v", "<leader>av", function() _99.visual() end)
			vim.keymap.set("n", "<leader>ax", function() _99.stop_all_requests() end)
			vim.keymap.set("n", "<leader>as", function() _99.search() end)
			vim.keymap.set("n", "<leader>ao", function() _99.open() end)
			vim.keymap.set("n", "<leader>ai", function() _99.open() end)
		end,
	},
}
