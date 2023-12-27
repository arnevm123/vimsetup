local M = {}

function M:git_cwd()
	local cwd =  vim.loop.cwd()
	if vim.fn.filereadable(cwd .. "/.venv") == 1 then
		return cwd
	end
	local root = vim.fn.system("git rev-parse --show-toplevel")
	if vim.v.shell_error == 0 and root ~= nil then
		return string.gsub(root, "\n", "")
	end
	return cwd
end

function M:Go_to_url(cmd)
	local sysname = vim.loop.os_uname().sysname
	local url = vim.fn.expand("<cfile>", nil, nil)
	if not url:match("http") then
		if url:match("github.com") or url:match("gopkg.in") or url:match("golang.org") then
			url = "https://" .. url
		else
			url = "https://github.com/" .. url
		end
	end

	vim.notify("Going to " .. url, "info", { title = "Opening browser..." })
	if sysname == "Darwin" then
		vim.fn.jobstart({ cmd or "open", url }, { on_exit = function() end })
	else
		vim.fn.jobstart({ cmd or "xdg-open", url }, { on_exit = function() end })
	end
end

-- make dd not remove last yank if empty
function M:Smart_dd()
	if vim.api.nvim_get_current_line():match("^%s*$") then
		return '"_dd'
	else
		return "dd"
	end
end

function M:CToggle()
	local qf_exists = false
	for _, win in pairs(vim.fn.getwininfo()) do
		if win["quickfix"] == 1 then
			qf_exists = true
		end
	end
	if qf_exists == true then
		vim.cmd("cclose")
		return
	end
	if not vim.tbl_isempty(vim.fn.getqflist()) then
		vim.cmd("copen")
	end
end

return M
