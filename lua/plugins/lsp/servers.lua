local M = {}

M.lsp = {
	"angularls",
	"ansiblels",
	"bashls",
	"biome",
	"clangd",
	"copilot",
	"cssls",
	"docker_compose_language_service",
	"docker_language_server",
	"eslint",
	"gitlab_ci_ls",
	"html",
	"jsonls",
	"lua_ls",
	"marksman",
	"ols",
	"pyright",
	"sqls",
	"ts_ls",
	"yamlls",
	"zls",
}

M.manually_install = {
	"gopls",
	"rust_analyzer",
}

M.linters_and_formatters = {
	"ansible-lint",
	"delve",
	"flake8",
	"fourmolu",
	"goimports-reviser",
	"hlint",
	"prettier",
	"prettierd",
	"selene",
	"shellcheck",
	"shfmt",
	"stylua",
	"yamlfmt",
	"yamllint",
}
return M
