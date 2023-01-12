local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Don't auto commenting new lines
autocmd("BufEnter", {
	pattern = "",
	command = "set fo-=c fo-=r fo-=o",
})

autocmd("TextYankPost", {
	group = augroup("HighlightYank", {}),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 50,
		})
	end,
})

-- go to last loc when opening a buffer
autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- autocmd({ "BufWritePre" }, {
-- 	pattern = "*",
-- 	command = [[lua vim.lsp.buf.formatting_sync() ]],
-- })

-- -- remove eol spaces
-- autocmd({ "BufWritePre" }, {
-- 	pattern = { "*" },
-- 	command = [[%s/\s\+$//e]],
-- })

autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- autocmd({ "BufWinEnter" }, {
-- 	callback = function()
-- 		local line_count = vim.api.nvim_buf_line_count(0)
-- 		if line_count >= 5000 then
-- 			vim.cmd("IlluminatePauseBuf")
-- 		end
-- 	end,
-- })

-- Set indentation to 2 spaces for some file types
augroup("setIndent", { clear = true })
autocmd("Filetype", {
	group = "setIndent",
	pattern = { "xml", "html", "xhtml", "css", "scss", "javascript", "typescript", "yaml" },
	command = "setlocal shiftwidth=2 tabstop=2",
})

vim.api.nvim_create_user_command("PrettyJson", ":%!jq '.'", {})
vim.api.nvim_create_user_command(
	"CursorHighlightOn",
	":lua require('illuminate').configure { under_cursor = true }",
	{}
)
vim.api.nvim_create_user_command(
	"CursorHighlightOff",
	":lua require('illuminate').configure { under_cursor = false }",
	{}
)

vim.api.nvim_create_user_command("Chmod", ":!chmod +x %", {})
vim.api.nvim_create_user_command("Cdlf", ":cd platform/scripts/local-full", {})
vim.api.nvim_create_user_command("Cdtest", ":cd %:h", {})
vim.api.nvim_create_user_command("PeekOpen", ":lua require('peek').open()", {})
vim.api.nvim_create_user_command("PeekClose", ":lua require('peek').close()", {})

-- vim commands
vim.cmd([[
function FoldText()
let foldtextstart = repeat(' ', indent(nextnonblank(v:foldstart)))
let uglyLine = getline(v:foldstart)
let line = substitute(uglyLine, '^\s*\(.\{-}\)\s*$', '\1', '')
let uglyLineEnd = getline(v:foldend)
let lineEnd = substitute(uglyLineEnd, '^\s*\(.\{-}\)\s*$', '\1', '')
let foldDept = getline(v:foldlevel)
let numOfLines = v:foldend - v:foldstart
return foldtextstart . line . ' ... ' . lineEnd . ' ' . '(' . numOfLines . 'ℓ)'
endfunction
set foldtext=FoldText()
set fillchars=fold:\  " removes trailing dots. Mind that there is a whitespace after the \!
]])

vim.cmd([[
augroup AutoDeleteNetrwHiddenBuffers
au!
au FileType netrw setlocal bufhidden=wipe
augroup end
]])

vim.cmd("autocmd User TelescopePreviewerLoaded setlocal number")
