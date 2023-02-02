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

-- autocmd({ "BufWritePre" }, {
-- 	pattern = "*",
-- 	command = [[lua vim.lsp.buf.formatting_sync() ]],
-- })

-- remove eol spaces
autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	command = [[%s/\s\+$//e]],
})

autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Set indentation to 2 spaces for some file types
augroup("setIndent", { clear = true })
autocmd("Filetype", {
	group = "setIndent",
	pattern = { "xml", "html", "xhtml", "css", "scss", "javascript", "typescript", "yaml" },
	command = "setlocal shiftwidth=2 tabstop=2",
})

vim.api.nvim_create_user_command("PrettyJson", ":%!jq '.'", {})
vim.api.nvim_create_user_command("Chmod", ":!chmod +x %", {})
vim.api.nvim_create_user_command("Cdlf", ":cd ~/Documents/moaprplatform/platform/scripts/local-full", {})
vim.api.nvim_create_user_command("Cdbase", ":cd ~/Documents/moaprplatform/", {})
vim.api.nvim_create_user_command("Cdtest", ":cd %:h", {})
vim.api.nvim_create_user_command("IfErr", function()
  local byte_offset = vim.fn.wordcount().cursor_bytes

  local cmd = string.format('iferr -pos %d', byte_offset)

  local data = vim.fn.systemlist(cmd, vim.fn.bufnr('%'))

  if not data then
    return nil
  end
  -- Because the nvim.stdout's data will have an extra empty line at end on some OS (e.g. maxOS), we should remove it.
  for _ = 1, 3, 1 do
    if data[#data] == "" then
      table.remove(data, #data)
    end
  end
  if #data < 1 then
    return nil
  end
  local pos = vim.fn.getcurpos()[2]
  vim.fn.append(pos, data)

  vim.cmd('silent normal! j=2j')
  vim.fn.setpos('.', pos)
  vim.cmd('silent normal! 4j')
end	, {})

vim.api.nvim_create_user_command("GoAlt", function()
  local file = vim.fn.expand('%')
  local is_test  = string.find(file, "_test%.go$")
  local is_source = string.find(file, "%.go$")
  local alt_file = file
  if is_test then
    alt_file = string.gsub(file, "_test.go", ".go")
  elseif is_source then
    alt_file = vim.fn.expand('%:r') .. "_test.go"
  else
    vim.notify('not a go file', vim.lsp.log_levels.ERROR)
  end
  if not vim.fn.filereadable(alt_file) and not vim.fn.bufexists(alt_file) then
    vim.notify("couldn't find " .. alt_file, vim.lsp.log_levels.ERROR)
    return
  else
    local ocmd = "e " .. alt_file
    vim.cmd(ocmd)
  end
end, {})


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
