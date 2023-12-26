return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-cmdline",
		-- Snippets
		"saadparwaiz1/cmp_luasnip",
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
		{
			"aznhe21/actions-preview.nvim",
			opts = { diff = { ctxlen = 5 }, backend = { "nui" } },
		},
		{
			"stevearc/conform.nvim",
			opts = {
				formatters = {
					goimports_reviser = {
						command = "goimports-reviser",
						args = { "-rm-unused", "-project-name", "unmatched.eu", "$FILENAME" },
						stdin = false,
					},
					gofumpt = { prepend_args = { "-extra" } },
				},
				formatters_by_ft = {
					lua = { "stylua" },
					-- python = { "isort", "black" },
					javascript = { { "prettierd", "prettier" } },
					typescript = { { "prettierd", "prettier" } },
					go = { "gofumpt", "goimports_reviser" },
					sh = { "shfmt" },
					["_"] = { "trim_whitespace" },
				},
			},
		},
		{ "folke/neodev.nvim", config = true },
		{
			"pmizio/typescript-tools.nvim",
			config = function()
				require("typescript-tools").setup({})
			end,
		},
		{
			"j-hui/fidget.nvim",
			opts = {
				progress = {
					suppress_on_insert = true,
					ignore_done_already = true,
					display = {
						done_icon = "",
						done_style = "Comment",
						progress_style = "Comment",
						format_message = function(msg)
							local message = msg.message
							if not message then
								message = msg.done and "✔" or "..."
							end
							if msg.percentage ~= nil then
								message = string.format("%.0f%%", msg.percentage)
							end
							return message
						end,
					},
					ignore = {},
				},
				notification = { window = { winblend = 0 } },
			},
		},
	},
	keys = {
		{
			"<leader>la",
			":lua require('actions-preview').code_actions()<CR>",
			desc = "lsp Code Action",
			mode = { "v", "n" },
		},
		-- { "<leader>la", vim.lsp.buf.code_action, desc = "lsp Code Action", mode = { "n", "v" } },
		{ "<leader>ld", ":Telescope diagnostics<CR>", desc = "lsp diagnostics" },
		{ "<leader>lw", ":Telescope lsp_workspace_diagnostics<cr>", desc = "lsp workspace diagnostics" },
		{
			"<leader>lf",
			":lua require('conform').format({ timeout_ms = 2000, lsp_fallback = true })<cr>",
			desc = "lsp format buffer",
		},
		{ "<leader>ll", ":lua vim.lsp.codelens.run()<cr>", desc = "lsp codelens" },
		{ "<leader>lr", ":lua vim.lsp.buf.rename()<cr>", desc = "lsp rename variable" },
		{ "<leader>le", ":LspRestart<cr>", desc = "Restart lsp" },
		{ "<leader>ls", ":Telescope lsp_document_symbols<cr>", desc = "lsp document symbols" },
		{ "<leader>lS", ":Telescope lsp_dynamic_workspace_symbols<cr>", desc = "lsp workspace symbols" },
		{ "<leader><leader>l", ":LspInfo<cr>", desc = "lsp info" },
	},
	config = function()
		require("plugins.lsp.mason")
		require("plugins.lsp.handlers").setup()
		-- require("plugins.lsp.null-ls")
		require("plugins.lsp.completion")
	end,
	event = { "BufReadPre", "BufNewFile" },
}
