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
		local excluded_filetypes = { "netrw", "help" }
		local excluded_buftypes = { "prompt", "nofile" }
		local current_filetype = vim.bo.filetype
		local current_buftype = vim.bo.buftype
		if vim.tbl_contains(excluded_filetypes, current_filetype) then
			return
		end
		if vim.tbl_contains(excluded_buftypes, current_buftype) then
			return
		end
		-- vim.opt.formatoptions:remove({ "c", "o" })
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

-- -- Set indentation to 2 spaces for some file types
-- augroup("setIndent", { clear = true })
-- autocmd("Filetype", {
-- 	group = "setIndent",
-- 	pattern = { "xml", "html", "xhtml", "css", "scss", "javascript", "typescript", "yaml", "proto" },
-- 	command = "setlocal shiftwidth=2 tabstop=2 expandtab",
-- })

autocmd("FileType", {
	desc = "Easy quit help with 'q'",
	group = augroup("Helpful", { clear = true }),
	pattern = { "help" },
	callback = function()
		vim.keymap.set("n", "q", "<cmd>q<CR>", { silent = true, buffer = true })
		vim.keymap.set("n", "gd", "<C-]>", { silent = true, buffer = true })
	end,
})

-- -- folding
-- vim.cmd([[
-- function FoldText()
-- let foldtextstart = repeat(' ', indent(nextnonblank(v:foldstart)))
-- let uglyLine = getline(v:foldstart)
-- let line = substitute(uglyLine, '^\s*\(.\{-}\)\s*$', '\1', '')
-- let uglyLineEnd = getline(v:foldend)
-- let lineEnd = substitute(uglyLineEnd, '^\s*\(.\{-}\)\s*$', '\1', '')
-- let foldDept = getline(v:foldlevel)
-- let numOfLines = v:foldend - v:foldstart
-- return foldtextstart . line . ' ... ' . lineEnd . ' ' . '(' . numOfLines . 'ℓ)'
-- endfunction
-- set foldtext=FoldText()
-- set fillchars=fold:\  " removes trailing dots. Mind that there is a whitespace after the \!
-- ]])
