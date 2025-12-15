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
			notification = { window = { winblend = 100 } },
		},
	},
	{
		"chrisgrieser/nvim-rulebook",
		event = "VeryLazy",
		config = function()
			local golangci = {
				comment = function(diag)
					local code = diag.message:match("^(%w+):")
					local cmt = string.format("// nolint:%s", diag.source)
					if code then
						return string.format("%s // %s", cmt, code)
					end
					return cmt
				end,
				location = "sameLine",
				doesNotUseCodes = true,
			}
			require("rulebook").setup({ ---@diagnostic disable-line: missing-fields
				forwSearchLines = 10,
				ignoreComments = {
					shellcheck = { ---@diagnostic disable-line: missing-fields
						comment = "# shellcheck disable=%s",
						location = "prevLine",
						multiRuleIgnore = true,
						multiRuleSeparator = ",",
					},
					revive = golangci,
					gosec = golangci,
					mnd = golangci,
					gocritic = golangci,
					forbidigo = golangci,
					unusedfunc = golangci,
				},
				ruleDocs = {
					fallback = function(diag)
						local line = vim.api.nvim_buf_get_lines(diag.bufnr, diag.lnum, diag.lnum + 1, false)[1]
						return "https://chatgpt.com/?q=Explain%20the%20following%20diagnostic%20error%3A%20"
							.. diag.message
							.. "%0AOffending line%3A%0A"
							.. line
							.. "%0A"
					end,
				},
			})
		end,
		keys = {
			{ "<Leader>le", "<cmd>lua require('rulebook').ignoreRule()<CR>", mode = "n", desc = "Diagnostic: ignore" },
			{
				"<Leader>ll",
				"<cmd>lua require('rulebook').lookupRule()<CR>",
				mode = "n",
				desc = "Diagnostic: lookup rule",
			},
			{
				"<Leader>ly",
				"<cmd>lua require('rulebook').lookupRule()<CR>",
				mode = "n",
				desc = "Diagnostic: lookup rule",
			},
			{
				"<Leader>lo",
				"<cmd>lua require('rulebook').suppressFormatter()<CR>",
				mode = { "n", "x" },
				desc = "Diagnostic: lookup rule",
			},
		},
	},
	{
		"seblyng/roslyn.nvim",
		ft = "cs",
	},
}
