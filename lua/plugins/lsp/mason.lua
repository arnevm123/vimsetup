local servers = {
	"angularls",
	"ansiblels",
	"biome",
	"bashls",
	"clangd",
	-- "csharp_ls",
	"cssls",
	"eslint",
	"gitlab_ci_ls",
	-- "gopls",
	-- "golangci_lint_ls",
	"ols",
	"sqls",
	"html",
	"jsonls",
	"lua_ls",
	"marksman",
	-- "omnisharp_mono",
	-- "omnisharp",
	-- "roslyn",
	"pyright",
	-- "rust_analyzer",
	-- "tsserver",
	"ts_ls",
	"yamlls",
	"zls",
}

local linters_and_formatters = {
	"ansible-lint",
	"delve",
	"flake8",
	"goimports-reviser",
	-- "golangci-lint",
	"prettier",
	"prettierd",
	"selene",
	"shellcheck",
	"shfmt",
	"stylua",
	"yamlfmt",
	"yamllint",
}

require("mason-tool-installer").setup({ ensure_installed = linters_and_formatters })

local settings = {
	ui = { border = require("base.utils").borders() },
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
	registries = {
		"github:mason-org/mason-registry",
		"github:Crashdummyy/mason-registry",
	},
}

require("mason").setup(settings)
require("mason-lspconfig").setup({ ensure_installed = servers, automatic_installation = false })
