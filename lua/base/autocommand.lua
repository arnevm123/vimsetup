local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

vim.api.nvim_create_autocmd("User", {
	pattern = "TelescopePreviewerLoaded",
	callback = function(args)
		if args.data.filetype ~= "help" then
			vim.wo.number = true
		end
	end,
})

autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		local excluded_filetypes = { "netrw", "help", "ivy" }
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
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 75,
		})
	end,
})

-- go to last loc when opening a buffer
-- autocmd("BufReadPost", {
-- 	callback = function()
-- 		local mark = vim.api.nvim_buf_get_mark(0, '"')
-- 		local lcount = vim.api.nvim_buf_line_count(0)
-- 		if mark[1] > 0 and mark[1] <= lcount then
-- 			pcall(vim.api.nvim_win_set_cursor, 0, mark)
-- 		end
-- 	end,
-- })

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
:autocmd BufWritePre [:;2]*
\   try | echoerr 'Forbidden file name: '..expand('<afile>') | endtry
]])

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "*.go" },
	callback = function()
		local lsputil = require("lspconfig.util")
		local cwd = lsputil.root_pattern("go.mod")(vim.fn.expand("%:p"))
		local config = lsputil.root_pattern(".golangci.yaml")(vim.fn.expand("%:p"))
		if config ~= nil then
			config = config .. "/.golangci.yaml"
		else
			config = "~/.config/linters/golangci.yaml"
		end
		local golangcilint = require("lint.linters.golangcilint")
		golangcilint.args = {
			"run",
			"--out-format",
			"json",
			"--timeout",
			"5m",
			"--config",
			config,
		}
		golangcilint.cwd = cwd
	end,
})
