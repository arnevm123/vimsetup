local servers = require("plugins.lsp.servers")
return {
	{
		"williamboman/mason.nvim",
		opts = {
			ui = { border = require("base.utils").borders() },
			log_level = vim.log.levels.INFO,
			max_concurrent_installers = 4,
			registries = {
				"github:mason-org/mason-registry",
				"github:Crashdummyy/mason-registry",
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = { ensure_installed = servers.lsp, automatic_installation = true },
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = { ensure_installed = servers.linters_and_formatters },
	},
}
