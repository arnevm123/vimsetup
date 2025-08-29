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
					args = function()
						local pkg_name = vim.fn.system("go list"):gsub("%s+", "")
						return { "-rm-unused", "-set-alias", "-project-name", pkg_name, "$FILENAME" }
					end,
					stdin = false,
				},
				gofumpt = { prepend_args = { "-extra" } },
			},
			formatters_by_ft = {
				go = { "golangci-lint", "gofumpt", "goimports", "goimports_reviser" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd", "prettier", stop_after_first = true },
				lua = { "stylua" },
				markdown = { "mdslw" },
				sh = { "shfmt" },
				-- yaml = { "yamlfmt" },
				mysql = { "sqlffluf" },
				sql = { "sqlffluf" },
				python = { "isort", "black" },
				-- ["*"] = { "injected" }, -- enables injected-lang formatting for all filetypes
			},
		},
	},
}
