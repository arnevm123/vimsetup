local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
    return
end

require("base.lsp.mason")
require("base.lsp.handlers").setup()
require("base.lsp.null-ls")
require("base.lsp.completion")

local configs = require("lspconfig/configs")

if not configs.golangcilsp then
    configs.golangcilsp = {
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
end

lspconfig.golangci_lint_ls.setup({
    filetypes = { "go", "gomod" },
})
