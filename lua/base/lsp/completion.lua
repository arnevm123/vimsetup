local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

require("luasnip/loaders/from_vscode").lazy_load()

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},

	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.abort(),
		["<C-j>"] = cmp.mapping.close(),
		["<c-y>"] = cmp.mapping(
			cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
			{ "i", "c" }
		),
		-- ["<M-y>"] = cmp.mapping(
		--   cmp.mapping.confirm {
		--     behavior = cmp.ConfirmBehavior.Replace,
		--     select = false,
		--   },
		--   { "i", "c" }
		-- ),
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

		-- ["<tab>"] = false,
		["<tab>"] = cmp.config.disable,
		-- ["<tab>"] = cmp.mapping {
		--   i = cmp.config.disable,
		--   c = function(fallback)
		--     fallback()
		--   end,
		-- },

		-- Testing
		["<c-q>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),
	}),
	formatting = {
		fields = { "abbr", "menu", "kind" },
		format = function(entry, vim_item)
			vim_item.menu = ({
				nvim_lsp = "LSP",
				codeium = "AI",
				nvim_lua = "Nvim",
				luasnip = "Snip",
				buffer = "Buf",
				path = "Path",
			})[entry.source.name]
			return vim_item
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "codeium" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	entries = { name = "custom", selection_order = "near_cursor" },
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
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
