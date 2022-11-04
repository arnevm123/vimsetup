local Worktree = require("git-worktree")

local function branchname(inputstr)
    local t
    for str in string.gmatch(inputstr, "([^".."/".."]+)") do
        t = str
    end
    return t
end

Worktree.on_tree_change(function(op, metadata)
    if op == Worktree.Operations.Create then
        local worktree_path = "/Users/arnevm/Documents/moaprWorktree/moaprplatform.git/" .. "/" .. metadata.path
        local gitignored_path = "~/Documents/gitignored"
        local copy_all_cmd = "ln -s " .. gitignored_path .. "/* " .. worktree_path
        os.execute(copy_all_cmd)
    end
end)

Worktree.on_tree_change(function(op, metadata)
    if op == Worktree.Operations.Switch then
        -- local worktree_path = "/Users/arnevm/Documents/moaprWorktree/moaprplatform.git/" .. "/" .. metadata.path
        local branch = branchname(metadata.path)
        local tmux_new = "tmux neww -dn ".. metadata.path .. " -n ".. branch .." -t 2"
        os.execute("tmux movew -d -s 2")
        os.execute(tmux_new)
        -- print(tmux_new)
        print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
    end
end)

local tele_status_ok, telescope = pcall(require, "telescope")
if not tele_status_ok then
    return
end
telescope.load_extension("git_worktree")
