local servers = {
	"angularls",
	"ansiblels",
	"bashls",
	"cssls",
	"eslint",
	"gopls",
	"html",
	"jsonls",
	"lua_ls",
	"marksman",
	-- "omnisharp_mono",
	"csharp_ls",
	"pyright",
	"rust_analyzer",
	"tsserver",
}

local linters_and_formatters = {
	"ansible-lint",
	"delve",
	"flake8",
	"goimports-reviser",
	"golangci-lint",
	"prettier",
	"prettierd",
	"selene",
	"shellcheck",
	"shfmt",
	"stylua",
}

require("mason-tool-installer").setup({
	ensure_installed = linters_and_formatters,
})

local settings = {
	ui = { border = "rounded" },
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

require("lspconfig.ui.windows").default_options.border = "rounded"

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("plugins.lsp.handlers").on_attach,
		capabilities = require("plugins.lsp.handlers").capabilities,
	}

	-- if server == "csharp_ls" then
	-- 	opts.root_dir = function(startpath)
	-- 		return lspconfig.util.root_pattern("*.sln")(startpath)
	-- 			or lspconfig.util.root_pattern("*.csproj")(startpath)
	-- 			or lspconfig.util.root_pattern("*.fsproj")(startpath)
	-- 			or lspconfig.util.root_pattern(".git")(startpath)
	-- 	end
	-- end

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "plugins.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end
