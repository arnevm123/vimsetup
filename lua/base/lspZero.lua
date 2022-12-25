local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    "angularls",
    "cssls",
    "eslint",
    "gopls",
    "html",
    "jsonls",
    "sumneko_lua",
    "tsserver",
})

lsp.configure('sumneko_lua', { settings = { Lua = { diagnostics = { globals = { 'vim' } } } } })

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

-- disable completion with tab
-- this helps with copilot setup
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = true,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "gD", "<cmd>Telescope lsp_type_definitions<CR>", opts)
    vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
    vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
    vim.keymap.set("n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts)
    vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>cI", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>h", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev({ border = "rounded" }) end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next({ border = "rounded" }) end, opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
    float = true,
})

local present, null_ls = pcall(require, "null-ls")
if not present then
    return
end

local null_opts = lsp.build_options('null-ls', {
    on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
            vim.api.nvim_create_autocmd("BufWritePre", {
                desc = "Auto format before save",
                pattern = "<buffer>",
                callback = vim.lsp.buf.formatting_sync,
            })
        end
    end
})

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local code_actions = null_ls.builtins.code_actions
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
-- local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    formatting.prettierd,
    debug = true,
    sources = {
        formatting.prettierd,
        formatting.goimports,
        code_actions.eslint_d,
    },
})

local default_node_modules = vim.fn.getcwd() .. "/node_modules"

