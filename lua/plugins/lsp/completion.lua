return {
	{
		"saghen/blink.cmp",
		lazy = false, -- lazy loading handled internally
		version = "v0.*",
		dependencies = "rafamadriz/friendly-snippets",
		opts = {
			snippets = { preset = "default" },
			keymap = {
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide" },
				["<C-y>"] = { "select_and_accept" },
				["<C-p>"] = { "show", "select_prev", "fallback" },
				["<C-n>"] = { "show", "select_next", "fallback" },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
				["<Tab>"] = { "snippet_forward", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "fallback" },
			},
			completion = {
				keyword = { range = "prefix" },
				accept = { auto_brackets = { enabled = false } },
				menu = {
					scrollbar = false,
					draw = {
						columns = { { "label", "label_description", gap = 1 }, { "kind_icon" }, { "source_name" } },
					},
					auto_show = function(ctx)
						return ctx.mode ~= "cmdline"
					end,
				},
				documentation = { auto_show = false },
			},
			signature = { enabled = true },
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "lazydev" },

				-- Function to use when transforming the items before they're returned for all providers
				-- The default will lower the score for snippets to sort them lower in the list
				transform_items = function(_, items)
					for _, item in ipairs(items) do
						if item.kind == require("blink.cmp.types").CompletionItemKind.Snippet then
							item.score_offset = item.score_offset - 3
						end
					end
					return items
				end,
				min_keyword_length = 0,
				providers = {
					lsp = { name = "[LSP]" },
					path = { name = "[PTH]" },
					buffer = { name = "[BFR]" },
					snippets = { name = "[SNP]", opts = { search_paths = { "~/.config/nvim/snippets" } } },
					lazydev = { name = "[LZD]", module = "lazydev.integrations.blink", score_offset = 100 },
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}
