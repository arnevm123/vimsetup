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
				"<c-;>",
				function()
					require("sidekick").nes_jump_or_apply()
				end,
				expr = true,
				desc = "Goto/Apply Next Edit Suggestion",
			},
			{
				"<c-.>",
				function()
					require("sidekick.cli").toggle({ name = "copilot", focus = true })
				end,
				mode = { "n", "x", "i", "t" },
				desc = "Sidekick Switch Focus",
			},
		},
	},
}
