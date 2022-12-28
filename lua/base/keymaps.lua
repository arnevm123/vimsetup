local opts = { noremap = true, silent = true }


local silent = { silent = true }


-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Move text up and down
keymap("v", "<C-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<C-k>", ":m '<-2<CR>gv=gv", opts)

-- Clear highlights with esc
keymap("n", "<esc>", ":noh<CR><esc>", opts)

keymap('n', ']g', '<cmd>lua require "gitsigns".next_hunk()<cr>', opts)
keymap('n', '[g', '<cmd>lua require "gitsigns".prev_hunk()<cr>', opts)

keymap('n', 'yoq', '<cmd>lua cToggle()<cr>', opts)

keymap("n", "<Leader>xn", ":let @+=@%<cr>", { noremap = true, silent = true, desc = "Copy Buffer name and path" })
keymap("n", "<Leader>xc", ":g/console.lo/d<cr>", { noremap = true, silent = true, desc = "Remove console.log" })

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", silent)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", silent)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", silent)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", silent)

-- doesn't overwrite yank
keymap('v', 'c', '"_c', opts)
keymap('n', 'c', '"_c', opts)

-- next greatest remap ever : asbjornHaland
keymap("n", "<leader>y", "\"+y", opts)
keymap("v", "<leader>y", "\"+y", opts)
keymap("n", "<leader>Y", "\"+Y", silent)

keymap("n", "<leader>p", "\"+p", opts)
keymap("v", "<leader>p", "\"+p", opts)
keymap("n", "<leader>P", "\"+P", silent)
keymap("v", "<leader>P", "\"+P", silent)

keymap('n', 'n', 'nzz', opts)
keymap('n', 'N', 'Nzz', opts)

keymap('n', '<C-d>', '<C-d>zztv', opts)
keymap('n', '<C-u>', '<C-u>zztv', opts)

keymap('n', 'Q', 'gqq', opts)
keymap('v', '<leader>re', '"hy:%s/<C-r>h//c<left><left><left>', opts)

keymap('n', '<leader>w', ':w!<CR>', opts)
keymap('n', '<leader>q', ':bp<CR> :bd! #<CR>', opts)

-- Telescope
keymap('n', '<C-p>', ':Telescope find_files<cr>', opts)
keymap('n', '<leader>fb', ':Telescope buffers<cr>', opts)
keymap('n', '<leader>fc', ':lua Telescope_diff_master()<CR>', opts)
keymap('n', '<leader>fr', ':Telescope oldfiles<cr>', opts)
keymap('n', '<leader>ff', ':Telescope live_grep<cr>', opts)
keymap('n', '<leader>fq', ':Telescope quickfix<cr>', opts)
keymap('n', '<leader>fs', ':Telescope<CR>', opts)
keymap('n', '<leader>ft', ':Telescope file_browser<cr>', opts)
keymap('n', '<leader>fp', ':Telescope file_browser path=%:p:h<cr>', opts)
keymap('n', '<leader>f/', ':Telescope current_buffer_fuzzy_find<CR>', opts)
keymap('n', '<leader>f"', ':Telescope registers<cr>', opts)
keymap('n', '<leader>fg', ':Telescope git_branches<cr>', opts)
keymap('n', '<leader>f;', ':Telescope neoclip<cr>', opts)
keymap('n', '<leader>fa', ':lua require("telescope.builtin").live_grep({grep_open_files=true})<CR>', opts)
keymap("n", "<leader>fw", ':lua Delta_git_commits()<CR>', opts)
keymap('n', '<leader>fdf', ':Telescope dap frames<CR>', opts)
keymap('n', '<leader>fdc', ':Telescope dap commands<CR>', opts)
keymap('n', '<leader>fdb', ':Telescope dap list_breakpoints<CR>', opts)
keymap('n', '<leader>fdv', ':Telescope dap variables<CR>', opts)

keymap('n', '<leader>eu', ':UndotreeToggle<cr>', opts)
keymap('n', '<leader>ex', ':Sexplore!<cr>', opts)
keymap('n', 'yoe', ':Lexplore!<cr>', opts)
keymap('n', '<leader>ee', ':GoIfErr<cr>', opts)
keymap('n', '<leader>el', ':GoLint<cr>', opts)
keymap('n', '<leader>ef', ':GoFillStruct<cr>', opts)
keymap('n', '<leader>ei', ':GoImport<cr>', opts)
keymap('n', '<leader>eb', ':GoDebug -a<cr>', opts)
keymap('n', '<leader>et', ':lua require("dapui").toggle()<cr>', opts)
keymap('n', '<leader>ecd', ':cd platform/scripts/local-full<cr>', opts)
-- You can also use below = true here to to change the position ofhe printf
-- statement (or set two remaps for either one). This remap must be made in normal mode.
keymap("n", "<leader>ek", ":lua require('refactoring').debug.printf({below = true})<CR>", opts)
-- Remap in normal mode and passing { normal = true } will automatically find the variable under the cursor and print it
keymap("n", "<leader>ev", ":lua require('refactoring').debug.print_var({ normal = true })<CR>", opts)
-- Remap in visual mode will print whatever is in the visual selection
keymap("v", "<leader>ev", ":lua require('refactoring').debug.print_var({})<CR>", opts)
-- Cleanup function: this remap should be made in normal mode
keymap("n", "<leader>ec", ":lua require('refactoring').debug.cleanup({})<CR>", opts)

keymap('n', '<leader>j', '<cmd>TSJJoin<CR>', opts)
keymap('n', '<leader>k', '<cmd>TSJSplit<CR>', opts)

-- HARPOON
keymap("n", "<leader>a", '<cmd>lua require("harpoon.mark").add_file()<CR>', opts)
keymap("n", "<leader>-", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', opts)

keymap("n", "<C-h>", '<cmd>lua require("harpoon.ui").nav_file(1)<CR>', opts)
keymap("n", "<C-j>", '<cmd>lua require("harpoon.ui").nav_file(2)<CR>', opts)
keymap("n", "<C-k>", '<cmd>lua require("harpoon.ui").nav_file(3)<CR>', opts)
keymap("n", "<C-l>", '<cmd>lua require("harpoon.ui").nav_file(4)<CR>', opts)
keymap("n", "<C-;>", '<cmd>lua require("harpoon.ui").nav_file(5)<CR>', opts)

--LSP
keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
keymap("n", "<leader>lg", "<cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", opts)
keymap("n", "<leader>ld", "<cmd>Telescope diagnostics<CR>", opts)
keymap("n", "<leader>lw", "<cmd>Telescope lsp_workspace_diagnostics<cr>", opts)
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<cr>", opts)
keymap("n", "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", opts)
keymap("n", "<leader>lq", "<cmd>Telescope quickfix<cr>", opts)
keymap("n", "<leader>lr", "<<cmd>lua vim.lsp.buf.rename()<cr>", opts)
keymap("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", opts)
keymap("n", "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", opts)
-- Database
keymap("n", "<leader>Du", "<Cmd>DBUIToggle<Cr>", opts)
keymap("n", "<leader>Df", "<Cmd>DBUIFindBuffer<Cr>", opts)
keymap("n", "<leader>Dr", "<Cmd>DBUIRenameBuffer<Cr>", opts)
keymap("n", "<leader>Dq", "<Cmd>DBUILastQueryInfo<Cr>", opts)
-- GIT
keymap("n", "<leader>gg", "<cmd>Neogit<CR>", opts)
keymap("n", "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", opts)
keymap("n", "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", opts)
keymap("n", "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", opts)
keymap("n", "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", opts)
keymap("n", "<leader>gS", "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", opts)
keymap("n", "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", opts)
keymap("n", "<leader>gU", "<cmd>lua require 'gitsigns'.undo_stage_buffer()<cr>", opts)
keymap("n", "<leader>go", "<cmd>Telescope git_status<cr>", opts)
keymap("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", opts)
keymap("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", opts)
keymap("n", "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", opts)
keymap("n", "<leader>gD", "<cmd>Gitsigns diffthis master<cr>", opts)
-- keymap("n", "<leader>gw", ":lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", opts)
-- keymap("n", "<leader>gz", ":lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>", opts)
keymap("n", "<leader>ge", "<cmd>Gitsigns toggle_current_line_blame<CR>", opts)
-- Stylesheets
keymap("n", "<leader>oi", "<cmd>:lua require('nvim-quick-switcher').find('.+css|.+scss|.+sass', { regex = true, prefix='full' })<CR>", { noremap = true, silent = true, desc = "Go to stylesheet" })

-- Angular
-- Using find over switch to look backwards incase in a redux-like folder "/state"
keymap("n", "<leader>os", "<cmd>:lua require('nvim-quick-switcher').find('.service.ts')<CR>", { noremap = true, silent = true, desc = "Go to service" })
keymap("n", "<leader>ou", "<cmd>:lua require('nvim-quick-switcher').find('.component.ts')<CR>", { noremap = true, silent = true, desc = "Go to TS" })
keymap("n", "<leader>oo", "<cmd>:lua require('nvim-quick-switcher').find('.component.html')<CR>", { noremap = true, silent = true, desc = "Go to html" })
keymap("n", "<leader>op", "<cmd>:lua require('nvim-quick-switcher').find('.module.ts')<CR>", { noremap = true, silent = true, desc = "Go to module" })

-- Golang Test switcher
-- keymap("n", "<leader>ot", "<cmd>:lua require('nvim-quick-switcher').find('.+test|.+spec', { regex = true, prefix='full' })<CR>", opts)
keymap('n', '<leader>ot', ':GoAlt!<cr>', opts)

-- Switches for - or _ e.g. controller-util.lua
keymap("n", "<leader>ol", "<cmd>:lua require('nvim-quick-switcher').find('*util.*', { prefix='short' })<CR>", { noremap = true, silent = true, desc = "Go to util" })


keymap("n", "<Leader>ng", ":lua require('neogen').generate()<CR>", opts)
keymap("n", "<Leader>nc", ":lua require('neogen').generate({ type = 'class' })<CR>", opts)
keymap("n", "<Leader>nf", ":lua require('neogen').generate({ type = 'func' })<CR>", opts)
keymap("n", "<Leader>nt", ":lua require('neogen').generate({ type = 'type' })<CR>", opts)

-- debug
keymap("n", "<F5>", ":lua require'dap'.continue()<CR>", opts)
keymap("n", "<F9>", ":lua require'dap'.run_to_cursor()<CR>", opts)
keymap("n", "<F10>", ":lua require'dap'.step_over()<CR>", opts)
keymap("n", "<F11>", ":lua require'dap'.step_into()<CR>", opts)
keymap("n", "<F12>", ":lua require'dap'.step_out()<CR>", opts)
keymap("n", "<F7>", ":lua require'go.dap'.run()<CR>", opts)
keymap("n", "<F6>", ":lua require'go.dap'.stop()<CR>", opts)
keymap("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>", opts)
keymap("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
keymap("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>", opts)
keymap("n", "<leader>df", ":lua require('dapui').float_element('breakpoints')<CR>", opts)

local previewers = require("telescope.previewers")
local builtin = require("telescope.builtin")

local delta = previewers.new_termopen_previewer({
    get_command = function(entry)
        return { "git", "-c", "core.pager=delta", "-c", "delta.side-by-side=false", "diff", entry.value .. "^!" }
    end,
})

Delta_git_commits = function(options)
    options = options or {}
    options.previewer = {
        delta,
        previewers.git_commit_message.new(options),
        previewers.git_commit_diff_as_was.new(options),
    }
    builtin.git_commits(options)
end

function Go_to_url(cmd)
    local url = vim.fn.expand('<cfile>', nil, nil)
    if not url:match("http") then
        url = "https://github.com/" .. url
    end

    vim.notify("Going to " .. url, 'info', { title = "Opening browser..." })
    vim.fn.jobstart({ cmd or "open", url }, { on_exit = function() end })
end

-- make dd not remove last yank if empty
local function smart_dd()
    if vim.api.nvim_get_current_line():match('^%s*$') then
        return '\"_dd'
    else
        return 'dd'
    end
end

keymap('n', 'dd', smart_dd, { noremap = true, expr = true })
keymap("n", "gx", ":lua Go_to_url()<CR>", opts)

cToggle = function()
    local qf_exists = false
    for _, win in pairs(vim.fn.getwininfo()) do
        if win["quickfix"] == 1 then
            qf_exists = true
        end
    end
    if qf_exists == true then
        vim.cmd "cclose"
        return
    end
    if not vim.tbl_isempty(vim.fn.getqflist()) then
        vim.cmd "copen"
    end
end
