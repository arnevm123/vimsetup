vim.cmd [[ colorscheme seoulbones ]]

vim.cmd [[ hi TreesitterContext guibg=#4B4B4B  ]]
vim.cmd [[ hi IlluminatedWordText gui=NONE guibg=#4B4B4B ]]
vim.cmd [[ hi IlluminatedWordRead gui=NONE guibg=#4B4B4B ]]
vim.cmd [[ hi IlluminatedWordWrite gui=NONE guibg=#4B4B4B ]]
vim.cmd [[ hi ColorColumn guibg=#353535 ]]
vim.cmd [[ hi CursorLine guibg=#353535 ]]

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

