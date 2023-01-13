local telescope_pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local previewers = require("telescope.previewers")
local putils = require("telescope.previewers.utils")
local from_entry = require("telescope.from_entry")
local conf = require("telescope.config").values

local branch_diff = function(opts)
	return previewers.new_buffer_previewer({
		title = "Git Branch Diff Preview",
		get_buffer_by_name = function(_, entry)
			return entry.value
		end,

		define_preview = function(self, entry, _)
			local file_name = entry.value
			local get_git_status_command = "git status -s -- " .. file_name
			local git_status = io.popen(get_git_status_command):read("*a")
			local git_status_short = string.sub(git_status, 1, 1)
			if git_status_short ~= "" then
				local p = from_entry.path(entry, true)
				if p == nil or p == "" then
					return
				end
				conf.buffer_previewer_maker(p, self.state.bufnr, {
					bufname = self.state.bufname,
					winid = self.state.winid,
				})
			else
				putils.job_maker(
					{ "git", "--no-pager", "diff", opts.base_branch .. "..HEAD", "--", file_name },
					self.state.bufnr,
					{
						value = file_name,
						bufname = self.state.bufname,
					}
				)
				putils.regex_highlighter(self.state.bufnr, "diff")
			end
		end,
	})
end

vim.api.nvim_create_user_command("TelescopeDiffMaster", function()
	local command = "git diff --name-only --relative $(git merge-base master HEAD)"

	local previewer = branch_diff({ base_branch = "master" })
	local entry_maker = function(entry)
		return {
			value = entry,
			display = entry,
			ordinal = entry,
		}
	end

	local handle = io.popen(command)

	if handle == nil then
		print("could not run specified command:" .. command)
		return
	end

	local result = handle:read("*a")

	handle:close()

	local files = {}

	for token in string.gmatch(result, "[^%c]+") do
		table.insert(files, token)
	end
	local opts = {
		prompt_title = "changes from master_files",
		finder = finders.new_table({
			results = files,
			entry_maker = entry_maker,
		}),
		previewer = previewer,
	}

	telescope_pickers.new(opts):find()
end, {})
