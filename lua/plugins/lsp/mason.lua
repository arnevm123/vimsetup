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

require("mason-tool-installer").setup({
	ensure_installed = linters_and_formatters,
})

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
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = false,
})

require("lspconfig.ui.windows").default_options.border = require("base.utils").borders()

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("plugins.lsp.handlers").on_attach,
		capabilities = require("plugins.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "plugins.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	vim.lsp.config(server, opts)
end

vim.api.nvim_create_autocmd("User", {
	pattern = "SqlsConnectionChoice",
	callback = function(event)
		vim.notify(event.data.choice)
	end,
})
