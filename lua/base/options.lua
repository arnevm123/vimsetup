local options = {
    backup = false,                          -- creates a backup file
    clipboard = "",                          -- allows neovim to access the system clipboard
    cmdheight = 2,                           -- more space in the neovim command line for displaying messages
    completeopt = { "menuone", "noselect" }, -- mostly just for cmp
    conceallevel = 0,                        -- so that `` is visible in markdown files
    fileencoding = "utf-8",                  -- the encoding written to a file
    hlsearch = true,                         -- highlight all matches on previous search pattern
    ignorecase = true,                       -- ignore case in search patterns
    mouse = "a",                             -- allow the mouse to be used in neovim
    pumheight = 10,                          -- pop up menu height
    showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
    smartcase = true,                        -- smart case
    smartindent = true,                      -- make indenting smarter againopt
    splitbelow = true,                       -- force all horizontal splits to go below current window
    splitright = true,                       -- force all vertical splits to go to the right of current window
    swapfile = false,                        -- creates a swapfile
    termguicolors = true,                    -- set term gui colors (most terminals support this)
    timeoutlen = 250,                        -- time to wait for a mapped sequence to complete (in milliseconds)
    undofile = true,                         -- enable persistent undo
    updatetime = 300,                        -- faster completion (4000ms default)
    writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    expandtab = true,                        -- convert tabs to spaces
    shiftwidth = 4,                          -- the number of spaces inserted for each indentation
    tabstop = 4,                             -- insert 2 spaces for a tab
    cursorline = true,                       -- highlight the current line
    number = true,                           -- set numbered lines
    relativenumber = true,                   -- set relative numbered lines
    numberwidth = 2,                         -- set number column width to 2 {default 4}
    signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
    wrap = false,                            -- display lines as one long line
    scrolloff = 8,                           -- is one of my fav
    sidescrolloff = 8,
    -- guifont = "monospace:h17",               -- the font used in graphical neovim applications
    colorcolumn = "80,120",
    foldlevel = 20,
    foldmethod = "expr",
    foldexpr = "nvim_treesitter#foldexpr()",
    listchars = 'tab:→ ,leadmultispace:·',
    -- list = true,
    gdefault = true
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
    vim.opt[k] = v
end

alt_file = vim.fn.expand('%:r') .. "_test.go"

-- Don't auto commenting new lines
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '',
  command = 'set fo-=c fo-=r fo-=o'
})

-- vim.cmd [[
-- autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
-- ]]

vim.cmd "setlocal spell spelllang=en_gb"
vim.cmd "setlocal spell!"
vim.cmd "set whichwrap+=<,>,[,],h,l"

local augroup = vim.api.nvim_create_augroup
local yank_group = augroup('HighlightYank', {})
local autocmd = vim.api.nvim_create_autocmd
local fn = vim.fn

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 50,
        })
    end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*.go" },
    command = ":GoImport",
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*.go" },
    command = ":GoFmt",
})

vim.cmd [[
function FoldText()
let foldtextstart = repeat(' ', indent(nextnonblank(v:foldstart)))
let uglyLine = getline(v:foldstart)
let line = substitute(uglyLine, '^\s*\(.\{-}\)\s*$', '\1', '')
let uglyLineEnd = getline(v:foldend)
let lineEnd = substitute(uglyLineEnd, '^\s*\(.\{-}\)\s*$', '\1', '')
let foldDept = getline(v:foldlevel)
let numOfLines = v:foldend - v:foldstart
return foldtextstart . line . ' ... ' . lineEnd . ' ' . '(' . numOfLines . ' Lines)'
endfunction
set foldtext=FoldText()
set fillchars=fold:\  " removes trailing dots. Mind that there is a whitespace after the \!
]]

function go_to_url(cmd)
    local url = vim.fn.expand('<cfile>', nil, nil)
    if not url:match("http") then
        url = "https://github.com/"..url
    end

    vim.notify("Going to "..url, 'info', { title="Opening browser..." })
    vim.fn.jobstart({cmd or "open", url}, {on_exit=function() end})
end

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
