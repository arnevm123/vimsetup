local previewers = require("telescope.previewers")
local builtin = require("telescope.builtin")

local delta = previewers.new_termopen_previewer({
    get_command = function(entry)
        return { "git", "-c", "core.pager=delta", "-c", "delta.side-by-side=false", "diff", entry.value .. "^!" }
    end,
})

function Delta_git_commits(options)
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
function Smart_dd()
    if vim.api.nvim_get_current_line():match('^%s*$') then
        return '\"_dd'
    else
        return 'dd'
    end
end

function CToggle()
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
