local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		local excluded_filetypes = { "netrw", "help", "qf" }
		local excluded_buftypes = { "prompt", "nofile" }
		local current_filetype = vim.bo.filetype
		local current_buftype = vim.bo.buftype
		if vim.tbl_contains(excluded_filetypes, current_filetype) then
			return
		end
		if vim.tbl_contains(excluded_buftypes, current_buftype) then
			return
		end
		vim.opt.formatoptions:remove({ "o" })
		vim.opt.number = true
		vim.opt.relativenumber = true
		vim.opt.scrolloff = 8
		vim.opt.pumheight = 10
	end,
	desc = "Stubborn vim options...",
})

autocmd("TextYankPost", {
	group = augroup("HighlightYank", {}),
	pattern = "*",
	callback = function()
		vim.hl.on_yank({
			higroup = "IncSearch",
			timeout = 75,
		})
	end,
})

local ignore_buftype = { "quickfix", "nofile", "help" }
local ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" }

vim.api.nvim_create_autocmd({ "BufWinEnter", "FileType" }, {
	group = vim.api.nvim_create_augroup("reset_cursor", {}),
	callback = function()
		if vim.fn.line(".") > 1 then
			return
		end
		if vim.tbl_contains(ignore_buftype, vim.bo.buftype) then
			return
		end
		if vim.tbl_contains(ignore_filetype, vim.bo.filetype) then
			return
		end
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local buff_last_line = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= buff_last_line then
			vim.api.nvim_win_set_cursor(0, mark)
		end
	end,
})

-- remove eol spaces
autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	callback = function()
		local cursor = vim.api.nvim_win_get_cursor(0)
		vim.cmd([[keepjumps keeppatterns %s/\s\+$//e]])
		vim.api.nvim_win_set_cursor(0, cursor)
	end,
})

vim.cmd([[
autocmd BufWritePre /\v^[:;]12.{,3}$/ try | echoerr 'Forbidden file name: ' .. expand('<afile>') | endtry
]])

local statusline_bg = 0

autocmd("RecordingEnter", {
	callback = function()
		local StatusLine_hl = vim.api.nvim_get_hl(0, { name = "StatusLine" })
		statusline_bg = StatusLine_hl.bg
		vim.api.nvim_set_hl(0, "StatusLine", { bg = "#6327A6" })
	end,
})

autocmd("RecordingLeave", {
	callback = function()
		vim.api.nvim_set_hl(0, "StatusLine", { bg = statusline_bg })
	end,
})

autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.gitlab-ci*.{yml,yaml}",
	callback = function()
		vim.bo.filetype = "yaml.gitlab"
	end,
})
