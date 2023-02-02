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
		"SmiteshP/nvim-navic",
		{
			"j-hui/fidget.nvim",
			opts = {
				text = {
					spinner = "dots",
				},
				window = {
					blend = 0,
				},
			},
		},
		{
			"jcdickinson/codeium.nvim",
			dependencies = {
				"MunifTanjim/nui.nvim",
			},
			config = function()
				require("codeium").setup({})
			end,
		},
	},
	keys = {
		{ "<leader>la", ":lua vim.lsp.buf.code_action()<CR>", desc = "lsp code action" },
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
		local status_ok, lspconfig = pcall(require, "lspconfig")
		if not status_ok then
			return
		end

		require("base.lsp.mason")
		require("base.lsp.handlers").setup()
		require("base.lsp.null-ls")
		require("base.lsp.completion")

		local lspconfigs = require("lspconfig/configs")

		lspconfigs.golangcilsp = {
			default_config = {
				cmd = { "golangci-lint-langserver" },
				root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
				init_options = {
					command = {
						"golangci-lint",
						"run",
						"--enable-all",
						"--disable",
						"lll",
						"--out-format",
						"json",
						"--issues-exit-code=1",
					},
				},
			},
		}

		lspconfig.golangci_lint_ls.setup({ filetypes = { "go", "gomod" } })
	end,
	event = "BufReadPre",
}
