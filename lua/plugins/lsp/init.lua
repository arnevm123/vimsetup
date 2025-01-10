return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			require("plugins.lsp.completion"),
			require("plugins.lsp.formatting"),

			"nanotee/sqls.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			-- language support
			{ "smjonas/inc-rename.nvim", config = true },
			"pmizio/typescript-tools.nvim",
		},
		keys = {
			{ "<leader>la", vim.lsp.buf.code_action, desc = "lsp Code Action", mode = { "n", "v" } },
			{ "<leader>lf", "<cmd>lua require('conform').format({ async = true, lsp_fallback = true })<CR>" },
			{ "<leader>lr", '"hyiw:IncRename <C-r>h', desc = "lsp rename variable" },
			-- { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "lsp rename variable" },
		},
		config = function()
			require("plugins.lsp.mason")
			require("plugins.lsp.handlers").setup()
		end,
		event = { "BufReadPre", "BufNewFile" },
	},
}
