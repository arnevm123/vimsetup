-- vim.cmd [[
-- Optionally install Lush. Allows for more configuration or extending the colorscheme
-- If you don't want to install lush, make sure to set g:zenbones_compat = 1
-- In Vim, compat mode is turned on as Lush only works in Neovim.
--     set background=dark
--     colorscheme intellij
-- vim.cmd [[
-- ]]
-- try
--   colorscheme gruvbox-material
-- catch /^Vim\%((\a\+)\)\=:E185/
--   colorscheme default
--   set background=dark
-- endtry
-- ]]
-- set background=dark
--  highlight ColorColumn ctermbg=0 guibg =#555555
--  highlight LineNr guifg=#5eacd3
--
--
--

-- require("github-theme").setup({
--   theme_style = "dimmed",
--   comment_style = "italic",
--   keyword_style = "italic",
--   variable_style = "italic",
--   function_style = "italic",
--   sidebars = {"qf", "vista_kind", "terminal", "packer"},
--   -- Change the "hint" color to the "orange" color, and make the "error" color bright red
--   colors = {hint = "orange", error = "#ff0000"},
--   -- Overwrite the highlight groups
--   overrides = function(c)
--     return {
--       htmlTag = {fg = c.red, bg = "#282c34", sp = c.hint, style = "underline"},
--       DiagnosticHint = {link = "LspDiagnosticsDefaultHint"},
--       -- this will remove the highlight groups
--       TSField = {},
--       NvimTreeNormal = {bg = "#303030" },
--     }
--   end
-- })

vim.cmd [[ colorscheme seoulbones ]]


vim.cmd [[ hi TreesitterContext guibg=#4B4B4B  ]]
vim.cmd [[ hi IlluminatedWordText gui=NONE guibg=#4B4B4B ]]
vim.cmd [[ hi IlluminatedWordRead gui=NONE guibg=#4B4B4B ]]
vim.cmd [[ hi IlluminatedWordWrite gui=NONE guibg=#4B4B4B ]]
vim.cmd [[ hi ColorColumn guibg=#4B4B4B ]]

require("transparent").setup({
    enable = true, -- boolean: enable transparent
    extra_groups = { -- table/string: additional groups that should be cleared
        -- In particular, when you set it to 'all', that means all available groups
        -- example of akinsho/nvim-bufferline.lua
        "NvimTreeNormal",
        "NormalFloat",
        "FloatBorder",
    },
    exclude = {}, -- table: groups you don't want to clear
})

