return {
	{
		"saghen/blink.cmp",
		lazy = false, -- lazy loading handled internally
		build = "cargo build --release",
		dependencies = {
			{ "rafamadriz/friendly-snippets" },
			{ "saghen/blink.compat" },
		},
		opts = {
			cmdline = {
				completion = { menu = { draw = { columns = { { "label" } } } } },
				keymap = {
					["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
					["<C-e>"] = { "hide" },
					["<C-y>"] = { "select_and_accept" },
					["<C-p>"] = { "show_and_insert", "select_prev", "fallback" },
					["<C-n>"] = { "show_and_insert", "select_next", "fallback" },
					["<Tab>"] = { "show_and_insert", "select_next", "fallback" },
					["<S-Tab>"] = { "show_and_insert", "select_prev", "fallback" },
				},
			},
			snippets = { preset = "default" },
			keymap = {
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide" },
				["<C-y>"] = { "select_and_accept" },
				["<C-p>"] = { "show_and_insert", "select_prev", "fallback" },
				["<C-n>"] = { "show_and_insert", "select_next", "fallback" },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
				["<Tab>"] = { "snippet_forward", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "fallback" },
			},
			completion = {
				keyword = { range = "prefix" },
				accept = { auto_brackets = { enabled = false } },
				menu = {
					border = "none",
					scrollbar = false,
					draw = {
						columns = { { "label", "label_description", gap = 1 }, { "kind_icon" }, { "source_name" } },
					},
				},
				documentation = { auto_show = false },
			},
			signature = { enabled = true },
			sources = {
				default = {
					"lsp",
					"path",
					"snippets",
					"buffer",
					"lazydev",
					"go_deep",
				},

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
					omni = { name = "[OMN]" },
					cmdline = { name = "[CMD]" },
					snippets = { name = "[SNP]", opts = { search_paths = { "~/.config/nvim/snippets" } } },
					lazydev = { name = "[LZD]", module = "lazydev.integrations.blink", score_offset = 100 },
					go_deep = { name = "[GOD]", module = "blink.compat.source", opts = { cmp_name = "go_deep" } },
				},
			},
			fuzzy = { implementation = "rust" },
		},
		opts_extend = { "sources.default" },
	},
}
