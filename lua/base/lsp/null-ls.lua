local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
	debug = true,
	sources = {
		formatting.prettier.with({
			extra_args = {
				"--single-quote",
				"--jsx-single-quote",
				"--print-width 120",
				"--tabWidth 2",
			},
		formatting.gofmt,
		-- formatting.gofumpt,
		diagnostics.golangci_lint,
		formatting.goimports,
		code_actions.eslint_d,
		code_actions.refactoring,
		diagnostics.flake8,
		-- diagnostics.gofumpt
		formatting.stylua,
		}),
	},
})