local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local snip_status_ok, ls = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

cmp.setup({
	completion = {
		completeopt = "menu,menuone,noinsert,noselect", -- remove default noselect
	},
	snippet = {
		expand = function(args)
			ls.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	matching = {
		disallow_fuzzy_matching = false,
		disallow_fullfuzzy_matching = false,
		disallow_partial_fuzzy_matching = false,
		disallow_partial_matching = false,
		disallow_prefix_unmatching = false,
		disallow_symbol_nonprefix_matching = false,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-q>"] = cmp.mapping(
			cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			}),
			{ "i", "c" }
		),
		["<c-y>"] = cmp.mapping(
			cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
			{ "i", "c" }
		),
		["<c-space>"] = cmp.mapping({
			i = cmp.mapping.complete(),
			c = function(
				_ --[[fallback]]
			)
				if cmp.visible() then
					if not cmp.confirm({ select = true }) then
						return
					end
				else
					cmp.complete()
				end
			end,
		}),

		["<tab>"] = cmp.config.disable,
	}),
	formatting = {
		expandable_indicator = true,
		fields = { "abbr", "menu", "kind" },
		format = function(entry, vim_item)
			vim_item.menu = ({
				luasnip = "[SNP]",
				nvim_lsp = "[LSP]",
				lazydev = "[LZD]",
				nvim_lsp_signature_help = "[SIG]",
				buffer = "[BUF]",
				path = "[PTH]",
				-- supermaven = "[AI]",
				-- nvim_lua = "[VIM]",
			})[entry.source.name]
			return vim_item
		end,
	},
	sources = {
		{ name = "nvim_lsp_signature_help" },
		{ name = "nvim_lsp" },
		{ name = "lazydev" },
		-- { name = "supermaven" },
		-- { name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Insert,
		select = false,
	},
	entries = { name = "custom", selection_order = "near_cursor" },
	window = {
		completion = {
			scrolloff = 2,
			border = "none",
			winhighlight = "Normal:Float,FloatBorder:Float,Search:Float,CursorLine:Visual",
		},
		documentation = {
			border = "single",
			winhighlight = "Normal:Float,FloatBorder:Float,Search:Float,CursorLine:Visual",
		},
	},
	experimental = {
		ghost_text = false,
	},
})

-- Not needed with sqls
-- cmp.setup.filetype({ "sql", "mysql" }, {
-- 	formatting = {
-- 		fields = { "abbr", "menu", "kind" },
-- 		format = function(entry, vim_item)
-- 			vim_item.menu = ({
-- 				nvim_lsp = "[LSP]",
-- 				["vim-dadbod-completion"] = "[DB]",
-- 				luasnip = "[SNP]",
-- 				buffer = "[BUF]",
-- 			})[entry.source.name]
-- 			return vim_item
-- 		end,
-- 	},
-- 	sources = {
-- 		{ name = "nvim_lsp" },
-- 		{ name = "vim-dadbod-completion" },
-- 		{ name = "luasnip" },
-- 		{ name = "buffer" },
-- 	},
-- })

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = { { name = "buffer" } },
	view = { entries = { name = "wildmenu", separator = "|" } },
})

vim.snippet.expand = ls.lsp_expand

---@diagnostic disable-next-line: duplicate-set-field
vim.snippet.active = function(filter)
	filter = filter or {}
	filter.direction = filter.direction or 1

	if filter.direction == 1 then
		return ls.expand_or_jumpable()
	else
		return ls.jumpable(filter.direction)
	end
end

---@diagnostic disable-next-line: duplicate-set-field
vim.snippet.jump = function(direction)
	if direction == 1 then
		if ls.expandable() then
			return ls.expand_or_jump()
		else
			return ls.jumpable(1) and ls.jump(1)
		end
	else
		return ls.jumpable(-1) and ls.jump(-1)
	end
end

-- snippets:
ls.config.set_config({
	-- This tells LuaSnip to remember to keep around the last snippet.
	-- You can jump back into it even if you move outside of the selection
	history = false,

	-- This one is cool cause if you have dynamic snippets, it updates as you type!
	updateevents = "TextChanged,TextChangedI",

	-- Autosnippets:
	enable_autosnippets = true,

	override_builtin = true,
})

vim.snippet.stop = ls.unlink_current
-- <c-k> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
vim.keymap.set({ "i", "s" }, "<c-k>", function()
	return vim.snippet.active({ direction = 1 }) and vim.snippet.jump(1)
end, { silent = true })

-- <c-j> is my jump backwards key.
-- this always moves to the previous item within the snippet
vim.keymap.set({ "i", "s" }, "<c-j>", function()
	return vim.snippet.active({ direction = -1 }) and vim.snippet.jump(-1)
end, { silent = true, noremap = true })

-- <c-l> is selecting within a list of options.
-- This is useful for choice nodes (introduced in the forthcoming episode 2)
vim.keymap.set("i", "<c-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	else
		vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-l>", true, true, true), "n")
	end
end)

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/plugins/snip/ft/*.lua", true)) do
	loadfile(ft_path)()
end
