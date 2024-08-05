return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"rachartier/tiny-code-action.nvim",
			config = true,
		},
		"aznhe21/actions-preview.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		-- "nanotee/sqls.nvim",
		-- {
		-- 	"MattiasMTS/cmp-dbee",
		-- 	dependencies = {
		-- 		{ "kndndrj/nvim-dbee" },
		-- 	},
		-- 	ft = "sql", -- optional but good to have
		-- 	opts = {}, -- needed
		-- },
		-- Snippets
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					"lazy.nvim",
					"luvit-meta/library",
				},
			},
			dependencies = {
				{ "Bilal2453/luvit-meta" },
			},
		},
		"Decodetalkers/csharpls-extended-lsp.nvim",
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
				icons = {
					indent = {
						middle = " ",
						last = " ",
						top = " ",
						ws = "│  ",
					},
				},
				modes = {
					diagnostics = {
						groups = {
							{ "filename", format = "{file_icon} {basename:Title} {count}" },
						},
					},
				},
			},
			cmd = "Trouble",
			keys = {
				{
					"<leader>tr",
					"<cmd>Trouble diagnostics toggle filter.severity=vim.diagnostic.severity.ERROR<cr>",
					desc = "iagnostics: Error (Trouble)",
				},
				{
					"<leader>ta",
					"<cmd>Trouble diagnostics toggle<cr>",
					desc = "Diagnostics (Trouble)",
				},
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
					javascript = { { "eslint_d", "prettierd", "prettier" } },
					lua = { "stylua" },
					markdown = { "mdslw" },
					sh = { "shfmt" },
					typescript = { { "eslint_d", "prettierd", "prettier" } },
					-- yaml = { "yamlfmt" },
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
						progress_ttl = 30,
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
		{ "<leader>la", ":lua require('actions-preview').code_actions()<CR>", desc = "lsp Code Action", mode = { "n", "v" } },
		{
			"<leader>la",
			":lua require('tiny-code-action').code_action()<CR>",
			desc = "lsp Code Action",
			mode = { "n", "v" },
		},
		{ "<leader>ld", ":Telescope diagnostics<CR>", desc = "lsp diagnostics" },
		{
			"<leader>lf",
			":lua require('conform').format({ async = true, lsp_fallback = true })<CR>",
			desc = "lsp format buffer",
		},
		{ "<leader>ll", ":lua vim.lsp.codelens.run()<CR>", desc = "lsp codelens" },
		{ "<leader>lr", ":lua vim.lsp.buf.rename()<CR>", desc = "lsp rename variable" },
		{ "<leader>li", ":LspInfo<CR>", desc = "lsp info" },
		{ "<leader>le", ":LspRestart<CR>", desc = "Restart lsp" },
	},
	config = function()
		require("plugins.lsp.mason")
		require("plugins.lsp.handlers").setup()
		require("plugins.lsp.completion")
	end,
	event = { "BufReadPre", "BufNewFile" },
}
