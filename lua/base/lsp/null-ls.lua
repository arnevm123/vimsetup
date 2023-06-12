local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local code_actions = null_ls.builtins.code_actions
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

-- https://github.com/prettier-solidity/prettier-plugin-solidity
null_ls.setup({
	debug = false,
	sources = {
		diagnostics.golangci_lint.with({
			extra_args = { "--config=~/.golangci.yaml" },
		}),
		formatting.stylua,
		diagnostics.selene,
		diagnostics.flake8,
		diagnostics.eslint_d,
		code_actions.eslint_d,
		formatting.gofumpt,
		-- formatting.goimports.with({ extra_args = { "-local", "go.nexuzhealth.com" } }),
		formatting.goimports_reviser.with({ extra_args = { "-project-name", "go.nexuzhealth.com" } }),
		formatting.prettierd,
	},
})
