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
		"folke/neodev.nvim",

		{
			"chrisgrieser/nvim-scissors",
			dependencies = "nvim-telescope/telescope.nvim", -- optional
			opts = {
				snippetDir = "~/.config/nvim/snippets",
			},
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets" } })
				vim.keymap.set("n", "<leader>se", function()
					require("scissors").editSnippet()
				end)
				vim.keymap.set({ "n", "x" }, "<leader>sa", function()
					require("scissors").addNewSnippet()
				end)
			end,
		},
		"pmizio/typescript-tools.nvim",
		{
			"folke/trouble.nvim",
			opts = {
				icons = false,
				fold_open = "v",
				fold_closed = ">",
				indent_lines = false,
				use_diagnostic_signs = true,
				vim.keymap.set("n", "<leader>tt", function()
					require("trouble").toggle("document_diagnostics")
				end),
				vim.keymap.set("n", "<leader>tq", function()
					vim.diagnostic.setqflist()
				end),
				vim.keymap.set("n", "<leader>tw", function()
					require("trouble").toggle("workspace_diagnostics")
				end),
			},
		},
		{
			"stevearc/conform.nvim",
			opts = {
				formatters = {
					goimports_reviser = {
						command = "goimports-reviser",
						args = { "-set-alias", "-rm-unused", "-project-name", "unmatched.eu", "$FILENAME" },
						stdin = false,
					},
					gofumpt = { prepend_args = { "-extra" } },
				},
				formatters_by_ft = {
					go = { "gofumpt", "goimports", "goimports_reviser" },
					javascript = { { "prettierd", "prettier" } },
					lua = { "stylua" },
					markdown = { "mdslw" },
					sh = { "shfmt" },
					typescript = { { "prettierd", "prettier" } },
					yaml = { "yamlfmt" },
					-- python = { "isort", "black" },
				},
			},
		},
		{
			"j-hui/fidget.nvim",
			opts = {
				progress = {
					suppress_on_insert = true,
					ignore_done_already = true,
					display = {
						done_ttl = 1,
						done_icon = "",
						done_style = "Comment",
						progress_style = "Comment",
						group_style = "@method",
						icon_style = "@method",
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
		{ "<leader>la", vim.lsp.buf.code_action, desc = "lsp Code Action", mode = { "n", "v" } },
		{ "<leader>ld", ":Telescope diagnostics<CR>", desc = "lsp diagnostics" },
		{ "<leader>lw", ":Telescope lsp_workspace_diagnostics<CR>", desc = "lsp workspace diagnostics" },
		{
			"<leader>lf",
			":lua require('conform').format({ timeout_ms = 2000, lsp_fallback = true })<CR>",
			desc = "lsp format buffer",
		},
		{ "<leader>ll", ":lua vim.lsp.codelens.run()<CR>", desc = "lsp codelens" },
		{ "<leader>lr", ":lua vim.lsp.buf.rename()<CR>", desc = "lsp rename variable" },
		{ "<leader>le", ":LspRestart<CR>", desc = "Restart lsp" },
	},
	config = function()
		require("plugins.lsp.mason")
		require("plugins.lsp.handlers").setup()
		require("plugins.lsp.completion")
	end,
	event = { "VeryLazy" },
}
