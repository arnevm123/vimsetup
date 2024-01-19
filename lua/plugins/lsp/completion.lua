local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local snip_status_ok, ls = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

cmp.setup({
	snippet = {
		expand = function(args)
			ls.lsp_expand(args.body) -- For `luasnip` users.
		end,
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
		fields = { "abbr", "menu", "kind" },
		format = function(entry, vim_item)
			vim_item.menu = ({
				nvim_lsp = "LSP",
				cody = "AI",
				nvim_lua = "VIM",
				luasnip = "SNP",
				buffer = "BUF",
				path = "PTH",
			})[entry.source.name]
			return vim_item
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "cody" },
		{ name = "nvim_lua" },
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
			winhighlight = "Normal:Float,FloatBorder:Float,Search:Float",
		},
		documentation = {
			border = "single",
			winhighlight = "Normal:Float,FloatBorder:Float,Search:Float",
		},
	},
	experimental = {
		ghost_text = false,
	},
})

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = { { name = "buffer" } },
	view = { entries = { name = "wildmenu", separator = "|" } },
})

-- snippets:
ls.config.set_config({
	-- This tells LuaSnip to remember to keep around the last snippet.
	-- You can jump back into it even if you move outside of the selection
	history = false,

	-- This one is cool cause if you have dynamic snippets, it updates as you type!
	updateevents = "TextChanged,TextChangedI",

	-- Autosnippets:
	enable_autosnippets = true,

	-- Crazy highlights!!
	-- #vid3
	-- ext_opts = nil,
})

-- <c-k> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
vim.keymap.set({ "i", "s" }, "<c-k>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	else
		vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-k>", true, true, true), "n")
	end
end, { silent = true })

-- <c-j> is my jump backwards key.
-- this always moves to the previous item within the snippet
vim.keymap.set({ "i", "s" }, "<c-j>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	else
		vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-j>", true, true, true), "n")
	end
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

vim.keymap.set("i", "<C-Return>", function()
	if ls.choice_active() then
		require("luasnip.extras.select_choice")
	end
end)

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/plugins/snip/ft/*.lua", true)) do
	loadfile(ft_path)()
end
