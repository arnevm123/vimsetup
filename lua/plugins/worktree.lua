return {
	"ThePrimeagen/git-worktree.nvim",
	config = function()
		local Worktree = require("git-worktree")

		-- Function to check if a tmux window with index 2 exists
		local function tmuxWindowExists()
			local cmd = "tmux list-windows | grep '2:'"
			local handle = io.popen(cmd)
			local result = handle:read("*a")
			handle:close()
			return result ~= ""
		end

		local function branchname(inputstr)
			local t
			for str in string.gmatch(inputstr, "([^" .. "/" .. "]+)") do
				t = str
			end
			return t
		end

		Worktree.on_tree_change(function(op, metadata)
			local Path = require("plenary.path")
			if op == Worktree.Operations.Create then
				-- If we're dealing with create, the path is relative to the worktree and not absolute
				-- so we need to convert it to an absolute path.
				local path = metadata.path
				if not Path:new(path):is_absolute() then
					path = Path:new():absolute()
					if path:sub(-#"/") == "/" then
						path = string.sub(path, 1, string.len(path) - 1)
					end
				end
				-- local branch = branchname(metadata.path)
				local worktree_path = path .. "/" .. metadata.path .. "/"
				local gitignored_path = path .. "/gitignored"
				local link_gitignored = "ln -s " .. gitignored_path .. "/* " .. worktree_path
				os.execute(link_gitignored)
                -- for future reference if I need to execute something on every create
				-- local tmux_mvn = "tmux neww -d -n mvn 'cd "
				-- 	.. worktree_path
				-- 	.. "/platform && mvn package && git add . && git reset --hard; exec zsh'"
				-- os.execute(tmux_mvn)
			end

			if op == Worktree.Operations.Switch then
				local folder = branchname(metadata.path)
				local tmux_new = "tmux neww -dn " .. metadata.path .. " -n " .. folder .. " -t 2"
				if tmuxWindowExists() then
					os.execute("tmux movew -d -s 2")
				end
				os.execute(tmux_new)
				print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
			end
		end)

		require("telescope").load_extension("git_worktree")
	end,
	keys = {
		{
			"<leader>gw",
			":lua require('telescope').extensions.git_worktree.git_worktrees()<CR>",
			desc = "git worktrees",
		},
		{
			"<leader>gz",
			":lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>",
			desc = "git create worktree",
		},
	},
}
