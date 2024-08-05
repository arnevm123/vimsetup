local Path = require("plenary.path")
local function buf_in_cwd(bufname, cwd)
	if cwd:sub(-1) ~= Path.path.sep then
		cwd = cwd .. Path.path.sep
	end
	local bufname_prefix = bufname:sub(1, #cwd)
	return bufname_prefix == cwd
end

local oldfiles = function(input)
	local results = {}
	local current_buffer = vim.api.nvim_get_current_buf()
	local current_file = vim.api.nvim_buf_get_name(current_buffer)
	local cwd = vim.loop.cwd() .. Path.path.sep
	for _, file in ipairs(vim.v.oldfiles) do
		local file_stat = vim.loop.fs_stat(file)
		if
			file_stat
			and file_stat.type == "file"
			and not vim.tbl_contains(results, file)
			and file ~= current_file
			and not string.find(file, ".git/COMMIT_EDITMSG")
			and buf_in_cwd(file, cwd)
		then
			local short_filename = string.sub(file, #cwd + 1, -1)
			table.insert(results, { content = short_filename })
		end
	end
	print(vim.inspect(results))
	return results
end

local ag = {
	name = "Recent files",
	command = "IvyRecentFiles",
	description = "Show the recent files in the directory",
	keymap = "<leader>fo",
	items = oldfiles,
	callback = function(result)
		vim.cmd("edit " .. result)
	end,
}

return ag
