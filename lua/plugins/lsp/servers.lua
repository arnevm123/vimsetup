local M = {}

M.lsp = {
	"angularls",
	"ansiblels",
	"docker_compose_language_service",
	"docker_language_server",
	"biome",
	"bashls",
	"copilot",
	"clangd",
	"csharp_ls",
	"cssls",
	"eslint",
	"gitlab_ci_ls",
	"ols",
	"sqls",
	"html",
	"jsonls",
	"lua_ls",
	"marksman",
	"pyright",
	"ts_ls",
	"yamlls",
	"zls",
}

M.manually_install = {
	"gopls",
}

M.linters_and_formatters = {
	"ansible-lint",
	"delve",
	"flake8",
	"goimports-reviser",
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
