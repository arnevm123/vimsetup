local servers = require("plugins.lsp.servers")
return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			require("plugins.lsp.completion"),
			require("plugins.lsp.formatting"),
			require("plugins.lsp.installation"),
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
		},
		config = function()
			for _, server in pairs(servers.manually_install) do
				vim.lsp.enable(server)
			end

			local signs = {
				{ name = "DiagnosticSignError", text = "E" },
				{ name = "DiagnosticSignWarn", text = "W" },
				{ name = "DiagnosticSignHint", text = "h" },
				{ name = "DiagnosticSignInfo", text = "i" },
			}

			local diag_config = {
				virtual_text = { source = true },
				signs = { active = signs },
				update_in_insert = false,
				underline = true,
				severity_sort = true,
				float = { focusable = true, style = "minimal", source = "always" },
			}

			vim.diagnostic.config(diag_config)

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

			local on_attach = function(client, _)
				client.server_capabilities.semanticTokensProvider = nil
			end

			vim.lsp.config("*", { on_attach = on_attach, capabilities = capabilities })
		end,
	},
}
