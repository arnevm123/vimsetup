
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

vim.cmd("autocmd User TelescopePreviewerLoaded setlocal number")

autocmd("BufEnter", {
	callback = function()
		vim.opt.formatoptions:remove({ "c", "o" })
	end,
	desc = "Disable New Line Comment",
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
autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- remove eol spaces
autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	command = [[%s/\s\+$//e]],
})

-- Set indentation to 2 spaces for some file types
augroup("setIndent", { clear = true })
autocmd("Filetype", {
	group = "setIndent",
	pattern = { "xml", "html", "xhtml", "css", "scss", "javascript", "typescript", "yaml", "proto" },
	command = "setlocal shiftwidth=2 tabstop=2 expandtab",
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "Easy quit help with 'q'",
	group = vim.api.nvim_create_augroup("Helpful", { clear = true }),
	pattern = { "help", "qf" },
	callback = function()
		vim.keymap.set("n", "q", "<cmd>q<cr>", { silent = true, buffer = true })
	end,
})

vim.api.nvim_create_user_command("PrettyJson", ":%!jq '.'", {})
vim.api.nvim_create_user_command("Day", ":pu=strftime('%d/%m/%Y %H:%M')", {})
vim.api.nvim_create_user_command("Chmod", ":!chmod +x %", {})
vim.api.nvim_create_user_command("Cdlf", ":cd ~/Documents/moaprplatform/platform/scripts/local-full", {})
vim.api.nvim_create_user_command("Cdbase", function()
	local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
	if vim.v.shell_error == 0 then
		vim.api.nvim_set_current_dir(root)
	end
end, {})

-- folding
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

