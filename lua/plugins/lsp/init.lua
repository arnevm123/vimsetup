return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			require("plugins.lsp.completion"),
			require("plugins.lsp.formatting"),

			{
				"williamboman/mason.nvim",
			},
			{
				"williamboman/mason-lspconfig.nvim",
			},
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			-- language support
			{ "smjonas/inc-rename.nvim", config = true },
			"pmizio/typescript-tools.nvim",
		},
		keys = {
			{ "<leader>la", vim.lsp.buf.code_action, desc = "lsp Code Action", mode = { "n", "v" } },
			{ "<leader>lf", "<cmd>lua require('conform').format({ async = true, lsp_fallback = true })<CR>" },
			{ "<leader>lr", ":IncRename <C-r><C-w>", desc = "lsp rename variable" },
			{
				"<leader>ld",
				"<cmd>lua require('base.utils').toggle_case_rename()<CR>",
				desc = "lsp toggle case rename",
			},
			-- default keymap: grn
			-- { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "lsp rename variable" },
		},
		config = function()
			require("plugins.lsp.mason")
			require("plugins.lsp.handlers").setup()
		end,
		event = { "BufReadPre", "BufNewFile" },
	},
}
