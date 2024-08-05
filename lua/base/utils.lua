local M = {}
function M.remove_bg()
	local highlights = {
		"Normal",
		"DiagnosticVirtualTextError",
		"DiagnosticVirtualTextHint",
		"DiagnosticVirtualTextInfo",
		"DiagnosticVirtualTextWarn",
		"CursorLineNr",
		"LineNr",
		"Folded",
		"NonText",
		"SpecialKey",
		"VertSplit",
		"SignColumn",
		"EndOfBuffer",
	}
	for _, highlight in pairs(highlights) do
		vim.cmd.highlight(highlight .. " guibg=none ctermbg=none")
	end

	local hl = {
		"Float",
		"NormalFloat",
		"FloatBorder",
		"Title",
		"TelescopeNormal",
		"TelescopeSelection",
		"TelescopeTitle",
		"TelescopeBorder",
	}
	for _, t in pairs(hl) do
		vim.cmd.highlight(t .. " guibg=#2B2B2B")
	end

	local groups = vim.fn.getcompletion("@lsp", "highlight")
	if groups then
		for _, group in ipairs(groups) do
			vim.api.nvim_set_hl(0, group, {})
		end
	end
end

function M.git_cwd()
	local cwd = vim.loop.cwd()
	-- if vim.fn.isdirectory(vim.fn.expand(cwd .. "/.venv")) == 1 then
	-- 	return cwd
	-- end
	local root = vim.fn.system("git rev-parse --show-toplevel")
	if vim.v.shell_error == 0 and root ~= nil then
		return string.gsub(root, "\n", "")
	end
	return cwd
end

function M.borders()
	local border = {
		{ "", "FloatBorder" },
		{ " ", "FloatBorder" },
		{ "", "FloatBorder" },
		{ "", "FloatBorder" },
		{ "", "FloatBorder" },
		{ "", "FloatBorder" },
		{ "", "FloatBorder" },
		{ "", "FloatBorder" },
	}
	return border
end

function M.git_main()
	local root = vim.fn.system("git branch | cut -c 3- | grep -E '^master$|^main$'")
	if vim.v.shell_error ~= 0 or root == nil then
		return false
	end
	return root:gsub("^\n*", ""):gsub("\n*$", "")
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

local virtual_text_enabled = true

function M:VirtualTextToggle()
	virtual_text_enabled = not virtual_text_enabled
	vim.diagnostic.config({ virtual_text = virtual_text_enabled })
end

local dbui_enabled = false
function M:DbuiToggle()
	if not dbui_enabled then
		vim.cmd("tabnew")
		vim.cmd("DBUI")
		dbui_enabled = true
		return
	end
	vim.cmd("tabnext")
end

function M:search_diagnostics()
	local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
	if #diagnostics == 0 then
		vim.notify("No diagnostics", vim.log.levels.WARN)
		return
	end
	local programming_language = vim.api.nvim_buf_get_option(0, "filetype")
	local severity = string.lower(vim.diagnostic.severity[diagnostics[1].severity])
	local clean_message = diagnostics[1].message:gsub("[A-Za-z0-9:/\\._%-]+[.][A-Za-z0-9]+", "")
	clean_message = clean_message:gsub("[A-Za-z0-9:/\\._%-]+[/\\][A-Za-z0-9:/\\._%-]+[.][A-Za-z0-9]+", "")
	local command = "xdg-open "
		.. '"https://duckduckgo.com/?q='
		.. "While developing "
		.. programming_language
		.. "I got this "
		.. severity
		.. ": "
		.. clean_message
		.. "?"
		.. '"'
	vim.fn.jobstart(command)
end

function M:search_diagnostics_cody()
	local start_line, end_line
	local mode = string.lower(vim.fn.mode())
	if mode == "v" then
		start_line = vim.fn.line("v")
		end_line = vim.fn.line(".")
		if start_line > end_line then
			start_line, end_line = end_line, start_line
		end
	else
		start_line = vim.fn.line(".")
		end_line = start_line
	end

	local bufnr = vim.api.nvim_get_current_buf()
	local all_diagnostics = vim.diagnostic.get(bufnr)
	local diagnostics = {}
	for _, diagnostic in ipairs(all_diagnostics) do
		if diagnostic.lnum + 1 >= start_line and diagnostic.lnum < end_line then
			table.insert(diagnostics, diagnostic)
		end
	end

	if #diagnostics == 0 then
		vim.notify("No diagnostics", vim.log.levels.WARN)
		return
	end

	local index = 1
	if #diagnostics > 1 then
		local inputList = { "Which diagnostic do you want explained?:" }
		for i, diagnostic in ipairs(diagnostics) do
			table.insert(inputList, string.format("%d. %s", i, diagnostic.message))
		end
		index = vim.fn.inputlist(inputList)
		if index <= 0 or index > #diagnostics then
			vim.notify("No diagnostic selected", vim.log.levels.INFO)
			return
		end
	end

	-- See if this is needed
	-- -- Remove patterns like "filename.extension"
	-- clean_message = clean_message:gsub("[A-Za-z0-9:/\\._%-]+[.][A-Za-z0-9]+", "")
	--
	-- -- Remove patterns like "path/filename.extension"
	-- clean_message = clean_message:gsub("[A-Za-z0-9:/\\._%-]+[/\\][A-Za-z0-9:/\\._%-]+[.][A-Za-z0-9]+", "")

	local msg = diagnostics[index].message .. " from " .. diagnostics[index].source
	require("sg.cody.commands").ask_range(bufnr, start_line - 1, end_line, msg)
end

function M:isInTable(str, tbl)
	for _, value in ipairs(tbl) do
		if value == str then
			return true
		end
	end
	return false
end

function M:cspell_add()
	local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
	if #diagnostics == 0 then
		vim.notify("No diagnostics", vim.log.levels.WARN)
		return
	end
	local words = {}

	for _, diagnostic in ipairs(diagnostics) do
		if diagnostic.source == "cspell" then
			local word = string.lower(diagnostic.message:match("%((.-)%)"))
			if not M:isInTable(word, words) then
				table.insert(words, word)
			end
		end
	end
	if #words == 0 then
		vim.notify("No error from cspell found", vim.log.levels.WARN)
	end
	local index = 1
	if #words > 1 then
		local inputList = { "Select word to add:" }
		for i, word in ipairs(words) do
			table.insert(inputList, string.format("%d. %s", i, word))
		end

		index = vim.fn.inputlist(inputList)

		if index <= 0 then
			vim.notify("No word selected", vim.log.levels.INFO)
			return
		end
	end

	local opts = {
		on_exit = function()
			vim.fn.jobstart("sort -u -o ~/.config/linters/allowed-words ~/.config/linters/allowed-words")
			vim.notify("Added " .. words[index] .. " to the allowed words", vim.log.levels.INFO)
		end,
	}
	local command = "echo " .. words[index] .. " >> ~/.config/linters/allowed-words"
	vim.fn.jobstart(command, opts)
end

function M.test()
	local ts_utils = require("nvim-treesitter.ts_utils")
	local current_node = ts_utils.get_node_at_cursor()
	if not current_node then
		return ""
	end
	print(vim.inspect(current_node))
end

function M:open_last_file()
	local files = vim.v.oldfiles
	for _, file in ipairs(files) do
		local file_stat = vim.loop.fs_stat(file)
		local cwd = vim.loop.cwd() .. require("plenary.path").path.sep
		if
			file_stat
			and file_stat.type == "file"
			and file ~= vim.fn.expand("%:p")
			and not string.find(file, ".git/COMMIT_EDITMSG")
			and vim.fn.matchstrpos(file, cwd)[2] ~= -1
		then
			vim.cmd("e " .. file)
			return
		end
	end
end

---@param search_string string | string[]
---@param search_folders? string | string[]
---@param case_insensitive? boolean
function M:grep_string(search_string, search_folders, case_insensitive)
	if search_string == nil or search_string == "" then
		return
	end
	vim.fn.setqflist({}, "r")
	local folders = search_folders or vim.fn.getcwd()
	local cmd
	if case_insensitive then
		cmd = 'rg -u --vimgrep "' .. search_string .. '" ' .. folders
	else
		cmd = 'rg -S -u --vimgrep "' .. search_string .. '" ' .. folders
	end
	local function stdout_to_qf(_, data, _)
		for _, val in ipairs(data) do
			local split_line = vim.split(val, ":")
			local filename = split_line[1]
			local lnum = split_line[2]
			local col = split_line[3]
			local text = table.concat(vim.list_slice(split_line, 4), ":")
			if filename and lnum and col and text then
				vim.fn.setqflist({
					{
						filename = filename,
						lnum = lnum,
						col = col,
						text = text,
					},
				}, "a")
			end
		end
	end
	local opts = {
		on_stdout = stdout_to_qf,
		on_exit = function()
			vim.cmd("copen")
		end,
	}
	vim.fn.jobstart(cmd, opts)
end

---@class rg_opts
---@field search_string? string | string[]
---@field search_folder? string | string[]
---@field case_insensitive? boolean
---@field ask_folder? boolean
local rg_opts = {}

rg_opts.__index = rg_opts

---@param opts rg_opts
function M:rg(opts)
	opts = opts or {}
	local search_string = opts.search_string
	local cwd = vim.fn.getcwd()
	local search_folder = opts.search_folder or cwd
	if vim.fn.mode() == "v" then
		vim.cmd([[noautocmd sil norm "hy]])
		search_string = vim.fn.getreg("h")
	end

	if not search_string then
		search_string = vim.fn.input("Grep For > ")
	end
	if opts.ask_folder then
		search_folder = M:check_folder(vim.fn.input("Search in folder > "), cwd)
	end

	M:grep_string(search_string, search_folder, opts.case_insensitive)
end

---@param folder string
---@return string | string[]
function M:check_folder(folder, cwd)
	local sep = require("plenary.path").path.sep
	if vim.fn.isdirectory(folder) == 1 then
		return folder
	end
	if vim.fn.isdirectory(cwd .. sep .. folder) == 1 then
		return cwd .. sep .. folder
	end
	local search_folder = M:search_folder(folder, cwd)
	if search_folder then
		return search_folder
	end
	return M:check_folder(vim.fn.input("Folder not found: try again > "))
end

---@param folder string
---@param root string
---@return string | nil
function M:search_folder(folder, root)
	local search = string.sub(folder, 1, 1) == "?"
	if not search then
		return nil
	end
	local search_path = folder:gsub("%?", ""):gsub("^%s+", ""):gsub("/", ".*"):gsub(" ", ".*")
	local command = "fd -p -t d " .. search_path .. " " .. root
	local handle = io.popen(command)
	if handle == nil then
		return nil
	end
	local folders = ""
	for line in handle:lines() do
		folders = folders .. " " .. line
	end
	handle:close()
	return folders
end

function M.fzf_fd()
	local command =
		"fd -t f | fzf-tmux -w100% -h100% --border=none --preview-window=down:50%,border-top --preview 'bat -n --color=always {}'"

	local handle = io.popen(command)
	if handle == nil then
		return
	end
	for line in handle:lines() do
		if line and line ~= "" then
			vim.cmd("e " .. line)
			vim.cmd("mod")
			return
		end
	end
end

function M.goimpl_magic()
	local diagnostics = vim.diagnostic.get(0)
	if #diagnostics == 0 then
		vim.notify("No diagnostics found", vim.log.levels.WARN)
		return
	end
	local diagnostic_message
	for _, diagnostic in ipairs(diagnostics) do
		if diagnostic.code == "InvalidIfaceAssign" then
			diagnostic_message = diagnostic.message
			break
		end
	end
	if not diagnostic_message then
		vim.notify("No invalid interface found", vim.log.levels.WARN)
		return
	end
	local _, _, interface = string.find(diagnostic_message, "does not implement%s*(%a+)")
	-- __AUTO_GENERATED_PRINT_VAR_START__
	print([==[M.goimpl_magic interface:]==], vim.inspect(interface)) -- __AUTO_GENERATED_PRINT_VAR_END__
	local _, _, implementation = diagnostic_message:find("(%a+){}")
	-- __AUTO_GENERATED_PRINT_VAR_START__
	print([==[M.goimpl_magic implementation:]==], vim.inspect(implementation)) -- __AUTO_GENERATED_PRINT_VAR_END__
	vim.api.nvim_command("GoImpl " .. implementation .. " " .. interface .. " " .. interface)
end

function M.upload_go_playground()
	local url = "https://go.dev/_/share"

	local start_line = 0
	local end_line = -1
	local mode = string.lower(vim.fn.mode())
	if mode == "v" then
		start_line = vim.fn.line("v")
		end_line = vim.fn.line(".")
		if start_line > end_line then
			start_line, end_line = end_line, start_line
		end
		start_line = start_line - 1
	end

	-- Get the current buffer number
	local current_buffer = vim.api.nvim_get_current_buf()

	-- Get all lines of the current buffer
	local lines = vim.api.nvim_buf_get_lines(current_buffer, start_line, end_line, false)

	local id = M.id()
	-- Concatenate the lines to get the buffer contents
	local contents = table.concat(lines, "\r\n")
	contents = contents

	-- Define the file path where you want to store the contents
	local file_path = "/tmp/upload" .. id .. ".txt"

	-- Open the file in write mode and write the contents
	local file = io.open(file_path, "w")
	if file == nil then
		return
	end
	file:write(contents)
	file:close()

	-- Use the file path in your curl command
	local command = 'curl -s -X POST -H "Content-Type: multipart/form-data;'
		.. '" --data-binary @'
		.. file_path
		.. " "
		.. url

	-- Execute the curl command
	local handle = io.popen(command)
	if handle == nil then
		return
	end

	local result = handle:read("*a")
	handle:close()
	local playground_url = "https://go.dev/play/p/" .. result

	if vim.loop.os_uname().sysname == "Darwin" then
		vim.fn.jobstart({ "open", playground_url }, { on_exit = function() end })
	else
		vim.fn.jobstart({ "xdg-open", playground_url }, { on_exit = function() end })
	end

	vim.notify("Successfully uploaded a snipet to the go playground: " .. playground_url, vim.log.levels.INFO)
end

local random = math.random
function M.id()
	local template = "xxxxxxxx"
	return string.gsub(template, "[xy]", function(c)
		local v = (c == "x") and random(0, 0xf) or random(8, 0xb)
		return string.format("%x", v)
	end)
end

return M
