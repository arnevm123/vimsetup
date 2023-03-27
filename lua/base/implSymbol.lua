local utils = require("utils")
local lsp = vim.lsp

-- enum
local SymbolKind = {
	Class = 5,
	Methods = 6,
	Interface = 11,
	Function = 12,
	Struct = 23,
}

local methods = {
	"textDocument/implementation",
	"textDocument/definition",
	"textDocument/references",
}

local function get_functions(result)
	local ret = {}
	for _, v in pairs(result or {}) do
		if v.kind == SymbolKind.Function or v.kind == SymbolKind.Methods or v.kind == SymbolKind.Interface then
			table.insert(ret, {
				name = v.name,
				rangeStart = v.range.start,
				selectionRangeStart = v.selectionRange.start,
				selectionRangeEnd = v.selectionRange["end"],
			})
		elseif v.kind == SymbolKind.Class or v.kind == SymbolKind.Struct then
			ret = utils:merge_table(ret, get_functions(v.children)) -- Recursively find methods
		end
	end
	return ret
end

local function get_cur_document_functions(results)
	local ret = {}
	for _, res in pairs(results or {}) do
		ret = utils:merge_table(ret, get_functions(res.result))
	end
	return ret
end

local function make_params(results)
	for _, query in pairs(results or {}) do
		local params = {
			position = {
				character = query.selectionRangeEnd.character,
				line = query.selectionRangeEnd.line,
			},
			textDocument = lsp.util.make_text_document_params(),
		}
		query.query_params = params
	end
	return results
end

local function lsp_support_method(buf, method)
	for _, client in pairs(lsp.get_active_clients({ bufnr = buf })) do
		if client.supports_method(method) then
			return true
		end
	end
	return false
end

local function result_count(results)
	local ret = 0
	for _, res in pairs(results or {}) do
		for _, _ in pairs(res.result or {}) do
			ret = ret + 1
		end
	end
	return ret
end

local function requests_done(finished)
	for _, p in pairs(finished) do
		if not (p[1] == true and p[2] == true and p[3] == true) then
			return false
		end
	end
	return true
end

local function delete_existing_lines(bufnr, ns_id)
	local existing_marks = vim.api.nvim_buf_get_extmarks(bufnr, ns_id, 0, -1, {})
	for _, v in pairs(existing_marks) do
		vim.api.nvim_buf_del_extmark(bufnr, ns_id, v[1])
	end
end

local function create_string(counting)
	return "Implements:" .. counting.implementation .. " | "
end

local function display_lines(bufnr, query_results)
	local ns_id = vim.api.nvim_create_namespace("lsp-lens")
	delete_existing_lines(bufnr, ns_id)
	for _, query in pairs(query_results or {}) do
		local virt_lines = {}
		local display_str = create_string(query.counting)
		if not (display_str == "") then
			local vline = { { string.rep(" ", query.rangeStart.character) .. display_str, "LspLens" } }
			table.insert(virt_lines, vline)
			vim.api.nvim_buf_set_extmark(bufnr, ns_id, query.rangeStart.line, 0, {
				virt_lines = virt_lines,
				virt_lines_above = true,
			})
		end
	end
end

function GetImpl()
	local bufnr = vim.api.nvim_get_current_buf()
	-- Ignored Filetype
	-- if utils:table_find(config.config.ignore_filetype, vim.api.nvim_buf_get_option(bufnr, "filetype")) then
	-- 	return
	-- end

	local method = "textDocument/documentSymbol"
	-- if lsp_support_method(bufnr, method) then
	local params = { textDocument = lsp.util.make_text_document_params() }
	lsp.buf_request_all(bufnr, method, params, function(document_symbols)
		-- vim.pretty_print(lsp.buf_request_sync(0, "textDocument/codeLens", document_symbols, 1000))
		local symbols = {}
		symbols["bufnr"] = bufnr
		symbols["document_symbols"] = document_symbols
		symbols["document_functions"] = get_cur_document_functions(symbols.document_symbols)
		symbols["document_functions_with_params"] = make_params(symbols.document_functions)
		if not (utils:is_buf_requesting(symbols.bufnr) == -1) then
			return
		else
			utils:set_buf_requesting(symbols.bufnr, 0)
		end

		local functions = symbols.document_functions_with_params
		local finished = {}

		for idx, function_info in pairs(functions or {}) do
			table.insert(finished, { false })

			local parameters = function_info.query_params
			local counting = {}

			if lsp_support_method(vim.api.nvim_get_current_buf(), methods[1]) then
				lsp.buf_request_all(symbols.bufnr, methods[1], parameters, function(implements)
					counting["implementation"] = result_count(implements)
				end)
				finished[idx][1] = true
			end
			function_info["counting"] = counting
		end
		local timer = vim.loop.new_timer()
		timer:start(
			0,
			500,
			vim.schedule_wrap(function()
				if requests_done(finished) then
					timer:close()
					display_lines(symbols.bufnr, functions)
					utils:set_buf_requesting(symbols.bufnr, 1)
				end
			end)
		)
	end)
end

vim.api.nvim_create_user_command("Impl", function()
	GetImpl()
end, {})
