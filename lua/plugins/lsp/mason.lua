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
	"gopls",
	-- "golangci_lint_ls",
	"ols",
	"sqls",
	"volar",
	-- "harper_ls",
	"html",
	"jsonls",
	"lua_ls",
	"marksman",
	-- "omnisharp_mono",
	"omnisharp",
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

	lspconfig[server].setup(opts)
end

vim.api.nvim_create_autocmd("User", {
	pattern = "SqlsConnectionChoice",
	callback = function(event)
		vim.notify(event.data.choice)
	end,
})

-- vim.lsp.util.stylize_markdown = function(bufnr, contents, opt)
-- 	contents = vim.lsp.util._normalize_markdown(contents, {
-- 		width = vim.lsp.util._make_floating_popup_size(contents, opt),
-- 	})
--
-- 	vim.bo[bufnr].filetype = "markdown"
-- 	vim.treesitter.start(bufnr)
-- 	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)
--
-- 	return contents
-- end
