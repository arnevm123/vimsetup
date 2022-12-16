local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
    return
end

gitsigns.setup {
    signs = {
        add = { hl = "gitsignsadd", text = "│", numhl = "gitsignsaddnr" },
        change = { hl = "gitsignschange", text = "│", numhl = "gitsignschangenr" },
        delete = { hl = "gitsignsdelete", text = "_", numhl = "gitsignsdeletenr" },
        topdelete = { hl = "gitsignsdelete", text = "‾", numhl = "gitsignsdeletenr" },
        changedelete = { hl = "gitsignsdelete", text = "~", numhl = "gitsignschangenr" },
        untracked    = { hl = 'gitsignsadd'   , text = '║', numhl='gitsignsaddnr'},
    },
    signcolumn = true, -- toggle with `:gitsigns toggle_signs`
    numhl = false, -- toggle with `:gitsigns toggle_numhl`
    linehl = false, -- toggle with `:gitsigns toggle_linehl`
    word_diff = false, -- toggle with `:gitsigns toggle_word_diff`
    watch_gitdir = {
        interval = 1000,
        follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = false, -- toggle with `:gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 0,
        ignore_whitespace = true,
    },
    current_line_blame_formatter_opts = {
        relative_time = false,
    },
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- use default
    max_file_length = 40000,
    preview_config = {
        -- options passed to nvim_open_win
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
    },
    yadm = {
        enable = false,
    },
}
