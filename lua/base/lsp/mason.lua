local servers = {
	"angularls",
	"ansiblels",
	"bashls",
	"cssls",
	"eslint",
	"golangci_lint_ls",
	"gopls",
	"html",
	"jsonls",
	"lua_ls",
	"pyright",
	"rust_analyzer",
	"sqlls",
	"tsserver",
}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("base.lsp.handlers").on_attach,
		capabilities = require("base.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "base.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end

local lspconfigs = require("lspconfig/configs")

lspconfigs.golangcilsp = {
	default_config = {
		cmd = { "golangci-lint-langserver" },
		root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
		init_options = {
			command = {
				"golangci-lint",
				"run",
				"--config=~/.golangci.yaml",
				"--fast",
				"--out-format",
				"json",
				"--issues-exit-code=1",
			},
		},
	},
}
