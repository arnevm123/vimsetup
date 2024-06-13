local group = vim.api.nvim_create_augroup("StatusLine", { clear = true })

local icons = {
	diagnostics = {
		error = "E",
		warning = "W",
		hint = "h",
		info = "i",
	},
	buffers = {
		readonly = "R",
		modified = "●",
		unsaved_others = "○",
	},
}

local diagnostics_attrs = {
	{ "Error", icons.diagnostics.error },
	{ "Warn", icons.diagnostics.warning },
	{ "Hint", icons.diagnostics.hint },
	{ "Info", icons.diagnostics.info },
}

local diagnostics = ""
local function diagnostics_section()
	local res = ""
	local diag = vim.diagnostic.count(0)
	if not diag or #diag == 0 then
		return ""
	end
	for i, diagnostic in ipairs(diagnostics_attrs) do
		local count = diag[i]
		if count then
			res = res .. " | " .. count .. " " .. diagnostic[2]
		end
	end
	return res
end

vim.api.nvim_create_autocmd({ "DiagnosticChanged", "BufWinEnter" }, {
	group = group,
	callback = function()
		diagnostics = diagnostics_section()
	end,
})

local function unsaved_buffers()
	for _, buf in pairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_get_current_buf() ~= buf then
			if vim.api.nvim_buf_get_option(buf, "modified") then
				return string.format(" %s ", icons.buffers.unsaved_others)
			end
		end
	end

	return ""
end

local function remove_string_from_start(mainString, removeString)
	if mainString:sub(1, #removeString) == removeString then
		return mainString:sub(#removeString + 1)
	else
		return mainString
	end
end

local function file_section()
	local name = vim.fn.expand("%")
	local root = vim.fn.getcwd()
	name = remove_string_from_start(name, root)
	local attr, icon = "", ""

	if vim.bo.modified and vim.bo.readonly then
		attr = icons.buffers.modified .. " " .. icons.buffers.readonly
	elseif vim.bo.readonly then
		attr = icons.buffers.readonly
	elseif vim.bo.modified then
		attr = icons.buffers.modified
	end

	if attr ~= "" then
		attr = " " .. attr
	end

	if name == "" then
		name = "No Name"
	end

	return string.format("%s %s%s", icon, name, attr)
end

local branch_cache = {}
local remote_cache = {}

local get_git_remote_name = function(root)
	if root == nil then
		return
	end

	local remote = remote_cache[root]
	if remote ~= nil then
		return remote
	end

	-- see https://stackoverflow.com/a/42543006
	-- "basename" "-s" ".git" "`git config --get remote.origin.url`"
	local cmd = table.concat({ "git", "config", "--get remote.origin.url" }, " ")
	remote = vim.fn.system(cmd)

	if vim.v.shell_error ~= 0 then
		remote = "No remote"
	end

	remote = vim.fs.basename(remote)
	if remote == nil then
		remote = "No remote"
	else
		remote = vim.fn.fnamemodify(remote, ":r")
	end

	remote_cache[root] = remote

	return remote
end

local set_git_branch = function(root)
	local cmd = table.concat({ "git", "-C", root, "branch --show-current" }, " ")
	local branch = vim.fn.system(cmd)
	if branch == nil then
		return nil
	end

	branch = branch:gsub("\n", "")
	branch_cache[root] = branch

	return branch
end

local get_git_branch = function(root)
	if root == nil then
		return
	end

	local branch = branch_cache[root]
	if branch ~= nil then
		return branch
	end

	return set_git_branch(root)
end
--- Create a string containing info for the current git branch
-- @treturn string: branch info
local function get_git_info()
	local root = vim.fn.getcwd()
	local remote = get_git_remote_name(root)
	local branch = ""
	if remote ~= "No remote" then
		branch = get_git_branch(root)
	end

	if branch and #branch > 25 then
		branch = string.sub(branch, 1, 22) .. "..."
	end

	if remote and branch then
		return table.concat({ "[", remote, "] (", branch, ") " })
	end
	return ""
end

local function left_section()
	return file_section() .. unsaved_buffers() .. diagnostics
end

local function right_section()
	return get_git_info() .. "%l/%L"
end

_G.set_statusline = function()
	return " " .. left_section() .. "%=" .. right_section() .. " "
end

vim.o.statusline = "%!v:lua.set_statusline()"
-- vim.o.statusline = [[%<%f %h%m%r %y%=%{v:register} %-14.(%l,%c%V%) %P]]
