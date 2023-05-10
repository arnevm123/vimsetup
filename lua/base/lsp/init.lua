return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		-- Snippets
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
		-- for formatters and linters
		"jose-elias-alvarez/null-ls.nvim",
		{
			"folke/neodev.nvim",
			config = true,
		},
		-- {
		-- 	"jcdickinson/codeium.nvim",
		-- 	dependencies = {
		-- 		"MunifTanjim/nui.nvim",
		-- 		-- { "jcdickinson/http.nvim", build = "cargo build --workspace --release" },
		-- 	},
		-- 	config = function()
		-- 		require("codeium").setup({})
		-- 	end,
		-- },
		{
			"j-hui/fidget.nvim",
			opts = { text = { spinner = "dots", done = "" }, window = { blend = 0 } },
		},
	},
	keys = {
		{ "<leader>la", vim.lsp.buf.code_action, desc = "lsp Code Action", mode = { "n", "v" } },
		{
			"<leader>lA",
			function()
				vim.lsp.buf.code_action({ context = { only = { "source" }, diagnostics = {} } })
			end,
			desc = "lsp Source Action",
		},
		{ "<leader>ld", ":Telescope diagnostics<CR>", desc = "lsp diagnostics" },
		{ "<leader>lw", ":Telescope lsp_workspace_diagnostics<cr>", desc = "lsp workspace diagnostics" },
		{ "<leader>lf", ":lua vim.lsp.buf.format()<cr>", desc = "lsp format buffer" },
		{ "<leader>ll", ":lua vim.lsp.codelens.run()<cr>", desc = "lsp codelens" },
		{ "<leader>lr", ":lua vim.lsp.buf.rename()<cr>", desc = "lsp rename variable" },
		{ "<leader>ls", ":Telescope lsp_document_symbols<cr>", desc = "lsp document symbols" },
		{ "<leader>lS", ":Telescope lsp_dynamic_workspace_symbols<cr>", desc = "lsp workspace symbols" },
		{ "<leader>li", ":LspInfo<cr>", desc = "lsp info" },
	},
	config = function()
		require("base.lsp.mason")
		require("base.lsp.handlers").setup()
		require("base.lsp.null-ls")
		require("base.lsp.completion")
	end,
	event = { "BufReadPre", "BufNewFile" },
}
