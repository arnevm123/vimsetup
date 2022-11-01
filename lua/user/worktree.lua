local Worktree = require("git-worktree")
local worktree = require("git-worktree")

Worktree.on_tree_change(function(op, metadata)
	if op == worktree.Operations.Create then
		local worktree_path = "/Users/arnevm/Documents/moaprWorktree/moaprplatform.git/" .. "/" .. metadata.path
		local gitignored_path = "~/Documents/gitignored"
		local copy_all_cmd = "ln -s " .. gitignored_path .. "/* " .. worktree_path
		-- local copy_hidden_cmd = "ln -s " .. gitignored_path .. "/.* " .. worktree_path
		os.execute(copy_all_cmd)
		-- os.execute(copy_hidden_cmd)
	end
end)

Worktree.on_tree_change(function(op, metadata)
  if op == Worktree.Operations.Switch then
    print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
  end
end)

local tele_status_ok, telescope = pcall(require, "telescope")
if not tele_status_ok then
	return
end
telescope.load_extension("git_worktree")
