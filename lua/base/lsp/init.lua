local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "base.lsp.configs"
require("base.lsp.handlers").setup()
require "base.lsp.null-ls"
