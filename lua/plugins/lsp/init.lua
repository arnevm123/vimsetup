return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp",
		-- Snippets
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
		-- for formatters and linters
		-- "jose-elias-alvarez/null-ls.nvim",
		-- { "folke/neodev.nvim", config = true },
		{
			"pmizio/typescript-tools.nvim",
			config = function()
				require("typescript-tools").setup({})
			end,
		},
		{
			"j-hui/fidget.nvim",
			tag = "legacy",
			opts = { text = { spinner = "dots", done = "" }, window = { blend = 0 } },
		},
	},
	keys = {
		{ "<leader>la", vim.lsp.buf.code_action, desc = "lsp Code Action", mode = { "n", "v" } },
		{ "<leader>ld", ":Telescope diagnostics<CR>", desc = "lsp diagnostics" },
		{ "<leader>lw", ":Telescope lsp_workspace_diagnostics<cr>", desc = "lsp workspace diagnostics" },
		{ "<leader>lf", ":lua vim.lsp.buf.format({ timeout_ms = 2000 })<cr>", desc = "lsp format buffer" },
		{ "<leader>ll", ":lua vim.lsp.codelens.run()<cr>", desc = "lsp codelens" },
		{ "<leader>lr", ":lua vim.lsp.buf.rename()<cr>", desc = "lsp rename variable" },
		{ "<leader>ls", ":Telescope lsp_document_symbols<cr>", desc = "lsp document symbols" },
		{ "<leader>lS", ":Telescope lsp_dynamic_workspace_symbols<cr>", desc = "lsp workspace symbols" },
		{ "<leader>lii", ":LspInfo<cr>", desc = "lsp info" },
	},
	config = function()
		require("plugins.lsp.mason")
		require("plugins.lsp.handlers").setup()
		-- require("plugins.lsp.null-ls")
		require("plugins.lsp.completion")
	end,
	event = { "BufReadPre", "BufNewFile" },
}
