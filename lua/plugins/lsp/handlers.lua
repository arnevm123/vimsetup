local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
M.capabilities = require("blink.cmp").get_lsp_capabilities(M.capabilities)

M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "E" },
		{ name = "DiagnosticSignWarn", text = "W" },
		{ name = "DiagnosticSignHint", text = "h" },
		{ name = "DiagnosticSignInfo", text = "i" },
	}
	local config = {
		-- virtual_lines = { current_line = true },
		virtual_text = { source = true },
		signs = { active = signs },
		update_in_insert = false,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			source = "always",
		},
	}

	vim.diagnostic.config(config)
end

-- -- stylua: ignore
-- local function lsp_keymaps(bufnr)
-- 	local opts = { noremap = true, silent = true }
-- 	local keymap = vim.api.nvim_buf_set_keymap
-- 	keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
-- 	keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
-- 	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
-- 	keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references({includeDeclaration = false})<CR>", { noremap = true, silent = true, nowait = true })
-- 	keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
-- 	keymap(bufnr, "n", "<leader>h", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
-- 	keymap(bufnr, "n", "[w", "<cmd>lua vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>", opts)
-- 	keymap(bufnr, "n", "]w", "<cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>", opts)
-- 	-- Not needed since nvim 0.11
-- 	-- keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
-- 	-- keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
-- 	-- keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
-- end

M.on_attach = function(client, _)
	client.server_capabilities.semanticTokensProvider = nil
	-- lsp_keymaps(bufnr)
end
return M
