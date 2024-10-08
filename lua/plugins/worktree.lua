return {
	"theprimeagen/git-worktree.nvim",
	config = function()
		local Worktree = require("git-worktree")

		Worktree.setup({
			clearjumps_on_change = true,
		})

		-- check if tmux window exists
		local function tmuxWindowExists(window)
			local cmd = "tmux list-windows | grep '" .. window .. "' |awk -F': ' '{print $1}'"
			local handle = io.popen(cmd)
			if not handle then
				return false
			end
			local result = handle:read("*a")
			handle:close()
			if result == "" then
				return false
			end
			return result
		end

		local function branchname(inputstr)
			local t
			local name = {}
			print(inputstr)
			for str in string.gmatch(inputstr, "([^" .. "/" .. "]+)") do
				t = str
			end
			print(t)
			for value in t:gmatch("[^%-]+") do
				print(value)
				table.insert(name, value)
				if #name == 2 then
					break
				end
			end
			if #name == 0 then
				return t
			end
			return table.concat(name, "-")
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
				local base_path = string.match(path, "(.-)%.git") .. ".git"
				local worktree_path = base_path .. "/" .. metadata.path .. "/"
				local gitignored_path = base_path .. "/gitignored"
				local link_gitignored = "ln -s " .. gitignored_path .. "/{*,.*} " .. worktree_path
				if vim.fn.isdirectory(gitignored_path) == 1 then
					os.execute(link_gitignored)
				end
			end

			if op == Worktree.Operations.Switch then
				local folder = branchname(metadata.path)
				local prev_folder = branchname(metadata.prev_path)
				local index = tmuxWindowExists(folder)

				if index then
					if tmuxWindowExists("2:") then
						os.execute("tmux swap-window -s 2 -t " .. index)
					else
						os.execute("tmux movew -s " .. index .. " .. 2")
					end
					print("Switched from " .. prev_folder .. " to " .. folder .. " with existing windows")
				else
					if tmuxWindowExists("2:") then
						os.execute("tmux movew -d -s 2")
					end
					os.execute("tmux neww -dn " .. metadata.path .. " -n " .. folder .. " -t 2")
					print("Switched from " .. prev_folder .. " to " .. folder)
				end
				-- os.execute("tmux send-keys -t 1 C-z 'cd ../" .. folder .. " && fg' C-m")
			end
		end)

		require("telescope").load_extension("git_worktree")
	end,
	keys = {
		{
			"<leader>ww",
			"<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>",
			desc = "git worktrees",
		},
		{
			"<leader>wc",
			"<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>",
			desc = "git create worktree",
		},
		{
			"<leader>wd",
			"<cmd>lua require('git-worktree').switch_worktree('develop')<CR>",
			desc = "git switch to develop worktree",
		},
	},
}

-- for future reference if I need to execute something on every create
-- local tmux_mvn = "tmux neww -d -n mvn 'cd "
-- 	.. worktree_path
-- 	.. "/platform && mvn package && git add . && git reset --hard; exec zsh'"
-- os.execute(tmux_mvn)
