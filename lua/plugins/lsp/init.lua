return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			require("plugins.lsp.completion"),
			require("plugins.lsp.formatting"),
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"pmizio/typescript-tools.nvim",
			{ "smjonas/inc-rename.nvim", config = true },
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
			local signs = {
				{ name = "DiagnosticSignError", text = "E" },
				{ name = "DiagnosticSignWarn", text = "W" },
				{ name = "DiagnosticSignHint", text = "h" },
				{ name = "DiagnosticSignInfo", text = "i" },
			}
			local config = {
				virtual_text = { source = true },
				signs = { active = signs },
				update_in_insert = false,
				underline = true,
				severity_sort = true,
				float = { focusable = true, style = "minimal", source = "always" },
			}

			vim.diagnostic.config(config)

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
			capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

			local on_attach = function(client, _)
				client.server_capabilities.semanticTokensProvider = nil
			end

			vim.lsp.config("*", {
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end,
		event = { "BufReadPre", "BufNewFile" },
	},
}
