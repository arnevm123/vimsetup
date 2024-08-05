vim.opt_local.expandtab = false
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4

vim.api.nvim_command("compiler go")
vim.api.nvim_command("let b:dispatch = 'go test ./... -coverprofile=.coverage.out'")
