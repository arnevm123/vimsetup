local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Tests
keymap("n", "<leader>ot", "<cmd>:lua require('nvim-quick-switcher').find('.+test|.+spec', { regex = true, prefix='full' })<CR>", opts)

-- -- Redux-like
-- -- Using find over switch to search with depth incase outside a redux-like folder "/state"
-- keymap("n", "<leader>oe", "<cmd>:lua require('nvim-quick-switcher').find('*effects*')<CR>", opts)
-- keymap("n", "<leader>oa", "<cmd>:lua require('nvim-quick-switcher').find('*actions*')<CR>", opts)
-- keymap("n", "<leader>oq", "<cmd>:lua require('nvim-quick-switcher').find('*query*')<CR>", opts)
-- keymap("n", "<leader>ow", "<cmd>:lua require('nvim-quick-switcher').find('*store*')<CR>", opts)

-- Stylesheets
keymap("n", "<leader>oi", "<cmd>:lua require('nvim-quick-switcher').find('.+css|.+scss|.+sass', { regex = true, prefix='full' })<CR>", opts)

-- Angular
-- Using find over switch to look backwards incase in a redux-like folder "/state"
keymap("n", "<leader>os", "<cmd>:lua require('nvim-quick-switcher').find('.service.ts')<CR>", opts)
keymap("n", "<leader>ou", "<cmd>:lua require('nvim-quick-switcher').find('.component.ts')<CR>", opts)
keymap("n", "<leader>oo", "<cmd>:lua require('nvim-quick-switcher').find('.component.html')<CR>", opts)
keymap("n", "<leader>op", "<cmd>:lua require('nvim-quick-switcher').find('.module.ts')<CR>", opts)

-- Switches for - or _ e.g. controller-util.lua
keymap("n", "<leader>ol", "<cmd>:lua require('nvim-quick-switcher').find('*util.*', { prefix='short' })<CR>", opts)

-- Legacy
-- keymap("n", "<leader>ou", "<cmd>:lua require('nvim-quick-switcher').switch('component.ts')<CR>", opts)
-- keymap("n", "<leader>oo", "<cmd>:lua require('nvim-quick-switcher').switch('component.html')<CR>", opts)
-- keymap("n", "<leader>oi", "<cmd>:lua require('nvim-quick-switcher').switch('component.scss')<CR>", opts)
-- keymap("n", "<leader>op", "<cmd>:lua require('nvim-quick-switcher').switch('module.ts')<CR>", opts)
-- keymap("n", "<leader>ot", "<cmd>:lua require('nvim-quick-switcher').switch('component.spec.ts')<CR>", opts)
-- keymap("n", "<leader>ovu", "<cmd>:lua require('nvim-quick-switcher').switch('component.ts', { split = 'vertical' })<CR>", opts)
-- keymap("n", "<leader>ovi", "<cmd>:lua require('nvim-quick-switcher').switch('component.scss', { split = 'vertical' })<CR>", opts)
-- keymap("n", "<leader>ovo", "<cmd>:lua require('nvim-quick-switcher').switch('component.html', { split = 'vertical' })<CR>", opts)
-- keymap("n", "<leader>oc", "<cmd>:lua require('nvim-quick-switcher').toggle('cpp', 'h')<CR>", opts)
