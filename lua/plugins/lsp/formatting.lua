return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters = {
				sqlffluf = {
					command = "sqlfluff",
					args = { "fix", "--dialect=mysql", "-" },
					stdin = true,
				},
				goimports_reviser = {
					command = "goimports-reviser",
					args = { "-rm-unused", "-project-name", "unmatched.eu", "$FILENAME" },
					stdin = false,
				},
				gofumpt = { prepend_args = { "-extra" } },
			},
			formatters_by_ft = {
				go = { "gofumpt", "goimports", "goimports_reviser" },
				javascript = { "eslint_d", "prettierd", "prettier", stop_after_first = true },
				lua = { "stylua" },
				markdown = { "mdslw" },
				sh = { "shfmt" },
				typescript = { { "eslint_d", "prettierd", "prettier" } },
				-- yaml = { "yamlfmt" },
				mysql = { "sqlffluf" },
				python = { "isort", "black" },
			},
		},
	},
}
