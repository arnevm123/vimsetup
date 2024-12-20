return {
	"neovim/nvim-lspconfig",
	dependencies = {
		require("plugins.lsp.completion"),
		require("plugins.lsp.formatting"),
		{ "smjonas/inc-rename.nvim", config = true },
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"nanotee/sqls.nvim",
		-- Snippets
		"L3MON4D3/LuaSnip",
		"Decodetalkers/csharpls-extended-lsp.nvim",
		"pmizio/typescript-tools.nvim",
		{
			"folke/trouble.nvim",
			opts = {
				icons = { indent = { middle = " ", last = " ", top = " ", ws = "│  " } },
				modes = {
					diagnostics = { groups = { { "filename", format = "{file_icon} {basename:Title} {count}" } } },
				},
			},
			cmd = "Trouble",
			keys = {
				{ "<leader>tr", "<cmd>Trouble diagnostics toggle filter.severity=vim.diagnostic.severity.ERROR<cr>" },
				{ "<leader>ta", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			},
		},
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
}
