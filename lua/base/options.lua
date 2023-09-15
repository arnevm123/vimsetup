vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.guicursor = ""
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/databases/undodir"

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.cursorline = true
vim.opt.termguicolors = true

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = false
vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.updatetime = 50
vim.opt.scrolloff = 8
vim.opt.pumheight = 10
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80,120"
vim.opt.spelllang = "en_gb"

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

if vim.fn.executable('rg') == 1 then
    vim.opt.grepprg = 'rg --vimgrep --hidden --glob !.git'
end

-- list
-- vim.opt.listchars:remove({ 'trail' })
-- vim.opt.listchars:append({ lead = '·' })
-- vim.opt.listchars:append({ tab = '   ' })
-- vim.opt.listchars:append({ eol = '↵' })

-- vim.opt.list = true
