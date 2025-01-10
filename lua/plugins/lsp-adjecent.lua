return {
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.code_actions.gomodifytags,
					null_ls.builtins.code_actions.impl,
					null_ls.builtins.code_actions.refactoring,
				},
			})
		end,
	},
	{
		"j-hui/fidget.nvim",
		opts = {
			progress = {
				suppress_on_insert = true,
				ignore_done_already = true,
				display = {
					done_ttl = 1,
					done_icon = "",
					done_style = "Comment",
					progress_style = "Comment",
					progress_ttl = 30,
					group_style = "@method",
					icon_style = "@method",
					format_message = function(msg)
						local message = msg.message
						if not message then
							message = msg.done and "✔" or "..."
						end
						if msg.percentage ~= nil then
							message = string.format("%.0f%%", msg.percentage)
						end
						return message
					end,
				},
				ignore = {},
			},
			notification = { window = { winblend = 0 } },
		},
	},
	{
		"amadanmath/diag_ignore.nvim",
		keys = {
			{ "<Leader>le", "<Plug>(diag_ignore)", mode = "n", desc = "Diagnostic: ignore" },
		},
		opts = {
			ignores = {
				python = { "endline", " # pyright: ignore[", "]" },
				lua = { "prevline", "---@diagnostic disable-next-line: " },
				go = { "endline", " // nolint: ", code = "source" },
			},
		},
	},
}