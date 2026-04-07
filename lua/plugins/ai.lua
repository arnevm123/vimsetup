return {
	-- {
	-- 	"folke/sidekick.nvim",
	-- 	opts = {
	-- 		nes = { enabled = true },
	-- 		cli = { mux = { backend = "tmux", enabled = true } },
	-- 	},
	-- 	event = "VeryLazy",
	-- 	keys = {
	-- 		{
	-- 			"<leader>su",
	-- 			function() require("sidekick.nes").update() end,
	-- 			desc = "Update Next Edit Suggestion",
	-- 		},
	-- 		{
	-- 			"<leader>st",
	-- 			function()
	-- 				local enabled = require("sidekick.nes").enabled
	-- 				require("sidekick.nes").enable(not enabled)
	-- 				local state = not enabled and "enabled" or "disabled"
	-- 				vim.notify("Next Edit Suggestion " .. state, vim.log.levels.INFO, { title = "Sidekick" })
	-- 			end,
	-- 			desc = "Toggle Next Edit Suggestion",
	-- 		},
	-- 		{
	-- 			"yoa",
	-- 			function()
	-- 				local sidekick_enabled = require("sidekick.nes").enabled
	-- 				local copilot_enabled = vim.lsp.inline_completion.is_enabled()
	-- 				local enabled = sidekick_enabled or copilot_enabled
	-- 				require("sidekick.nes").enable(not enabled)
	-- 				vim.lsp.inline_completion.enable(not enabled)
	-- 				local state = not enabled and "enabled" or "disabled"
	-- 				vim.notify("Ai is now " .. state, vim.log.levels.INFO, { title = "Ai" })
	-- 			end,
	-- 			desc = "Toggle Next Edit Suggestion",
	-- 		},
	-- 		{
	-- 			"<c-;>",
	-- 			function() require("sidekick").nes_jump_or_apply() end,
	-- 			desc = "Goto/Apply Next Edit Suggestion",
	-- 		},
	-- 		{
	-- 			"<c-.>",
	-- 			function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
	-- 			mode = { "n", "x", "i", "t" },
	-- 			desc = "Sidekick Switch Focus",
	-- 		},
	-- 		{
	-- 			"<leader>AV",
	-- 			function() require("sidekick.cli").send({ msg = "{selection}" }) end,
	-- 			mode = { "x" },
	-- 			desc = "Send Visual Selection",
	-- 		},
	-- 	},
	-- },
	{
		"nickjvandyke/opencode.nvim",
		version = "*", -- Latest stable release
		event = "VeryLazy",
		dependencies = {
			{
				-- `snacks.nvim` integration is recommended, but optional
				---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
				"folke/snacks.nvim",
				optional = true,
				opts = {
					picker = { -- Enhances `select()`
						actions = {
							opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
						},
						win = {
							input = {
								keys = {
									["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
								},
							},
						},
					},
				},
			},
		},
		config = function()
			---@type opencode.Opts
			vim.g.opencode_opts = {
				-- Your configuration, if any; goto definition on the type or field for details
			}

			vim.o.autoread = true -- Required for `opts.events.reload`
			-- Recommended/example keymaps
			-- vim.keymap.set(
			-- 	{ "n", "x" },
			-- 	"<C-x>",
			-- 	function() require("opencode").select() end,
			-- 	{ desc = "Execute opencode action…" }
			-- )
			vim.keymap.set(
				{ "n", "t" },
				"<C-.>",
				function() require("opencode").toggle() end,
				{ desc = "Toggle opencode" }
			)

			vim.keymap.set(
				{ "n", "x" },
				"go",
				function() return require("opencode").operator("@this ") end,
				{ desc = "Add range to opencode", expr = true }
			)
			vim.keymap.set(
				"n",
				"goo",
				function() return require("opencode").operator("@this ") .. "_" end,
				{ desc = "Add line to opencode", expr = true }
			)
		end,
	},
	{
		"ThePrimeagen/99",
		event = "VeryLazy",
		config = function()
			local _99 = require("99")
			local cwd = vim.uv.cwd()
			local basename = vim.fs.basename(cwd)
			_99.setup({
				provider = _99.Providers.OpenCodeProvider, -- default: OpenCodeProvider
				model = "opencode/big-pickle",
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

					files = {},
					source = "blink", -- "native" (default), "cmp", or "blink"
				},
				md_files = {
					"AGENT.md",
				},
			})
		end,
		keys = {
			{ "<leader>av", function() require("99").visual() end, mode = "v" },
			{ "<leader>ax", function() require("99").stop_all_requests() end },
			{ "<leader>as", function() require("99").search() end },
			{ "<leader>ao", function() require("99").open() end },
			{ "<leader>ai", function() require("99").open() end },
			{
				"<leader>af",
				function() require("base.utils"):ai_fix_lint() end,
				mode = { "n", "v" },
				desc = "AI fix lint error",
			},
		},
	},
}
