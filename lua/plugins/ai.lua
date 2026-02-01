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
				function() require("sidekick.cli").toggle({ name = "codex", focus = true }) end,
				mode = { "n", "x", "i", "t" },
				desc = "Sidekick Switch Focus",
			},
		},
	},
}
