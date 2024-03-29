local servers = {
	"angularls",
	"ansiblels",
	"bashls",
	"csharp_ls",
	"cssls",
	"eslint",
	"gopls",
	"volar",
	"html",
	"jsonls",
	"lua_ls",
	"marksman",
	-- "omnisharp_mono",
	-- "omnisharp",
	"pyright",
	-- "rust_analyzer",
	"tsserver",
	"yamlls",
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
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = false,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

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
	if server == "csharp_ls" then
		opts.handlers = {
			["textDocument/definition"] = require("csharpls_extended").handler,
			["textDocument/typeDefinition"] = require("csharpls_extended").handler,
		}
	end

	lspconfig[server].setup(opts)
end
