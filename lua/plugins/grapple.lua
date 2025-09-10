local function save_mark()
	local char = vim.fn.getcharstr()
	-- Handle ESC, Ctrl-C, etc.
	if char == "" or vim.startswith(char, "<") or vim.startswith(char, "") then
		return
	end
	local filepath = vim.api.nvim_buf_get_name(0)
	local filename = vim.fn.fnamemodify(filepath, ":t")
	local grapple = require("grapple")
	local entry = grapple.find({ name = char })
	if entry then
		if entry.path == filepath then
			vim.notify(filename .. " is already marked as " .. char)
			return
		end
		local choice = vim.fn.confirm("Tag " .. char .. " already exists. Delete it?", "&Yes\n&No", 2)
		if choice ~= 1 then
			return
		end
	end
	grapple.tag({ name = char })
	vim.defer_fn(function()
		vim.notify("Marked " .. filename .. " as " .. char)
	end, 10)
end

local function open_mark()
	local char = vim.fn.getcharstr()
	-- Handle ESC, Ctrl-C, etc.
	if char == "" or vim.startswith(char, "<") or vim.startswith(char, "") then
		return
	end
	local grapple = require("grapple")
	if char == "'" then
		grapple.toggle_tags()
		return
	end
	grapple.select({ name = char })
end

return {
	{
		lazy = false,
		"cbochs/grapple.nvim",
		opts = {
			name_pos = "start",
			icons = false,
			quick_select = "",
			command = function(path)
				local bufnr = vim.fn.bufnr(path)
				if bufnr == -1 then
					bufnr = vim.fn.bufadd(path)
				end
				if not vim.api.nvim_buf_is_loaded(bufnr) then
					vim.fn.bufload(bufnr)
					vim.api.nvim_set_option_value("buflisted", true, {
						buf = bufnr,
					})
				end
				vim.api.nvim_set_current_buf(bufnr)
			end,
			win_opts = {
				-- Can be fractional
				width = 90,
				height = 16,
				row = 0.5,
				col = 0.5,
				footer = "",
			},
		},
		keys = {
			{ "m", save_mark, noremap = true, silent = true },
			{ "'", open_mark, noremap = true, silent = true },
		},
	},
}
