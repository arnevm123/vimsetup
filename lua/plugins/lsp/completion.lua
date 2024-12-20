return {
	"saghen/blink.cmp",
	lazy = false, -- lazy loading handled internally
	version = "v0.*",
	dependencies = "rafamadriz/friendly-snippets",
	opts = {
		-- "default" keymap
		--   ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
		--   ['<C-e>'] = { 'hide' },
		--   ['<C-y>'] = { 'select_and_accept' },
		--
		--   ['<C-p>'] = { 'select_prev', 'fallback' },
		--   ['<C-n>'] = { 'select_next', 'fallback' },
		--
		--   ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
		--   ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
		--
		--   ['<Tab>'] = { 'snippet_forward', 'fallback' },
		--   ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
		keymap = { preset = "default" },
		completion = {
			keyword = { range = "full" },
			accept = { auto_brackets = { enabled = false } },
			menu = {
				scrollbar = false,
				draw = {
					columns = { { "label", "label_description", gap = 1 }, { "kind_icon" }, { "source_name" } },
				},
			},
			documentation = { auto_show = true, auto_show_delay_ms = 100 },
		},
		signature = { enabled = true },
		sources = {
			-- Static list of providers to enable, or a function to dynamically enable/disable providers based on the context
			default = { "lsp", "path", "snippets", "buffer", "lazydev" },

			-- By default, we choose providers for the cmdline based on the current cmdtype
			-- You may disable cmdline completions by replacing this with an empty table
			cmdline = function()
				local type = vim.fn.getcmdtype()
				-- Search forward and backward
				if type == "/" or type == "?" then
					return { "buffer" }
				end
				-- Commands
				if type == ":" then
					return { "cmdline" }
				end
				return {}
			end,

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
				lazydev = {
					name = "[LZD]",
					module = "lazydev.integrations.blink",
					score_offset = 100, -- show at a higher priority than lsp
				},
				lsp = {
					name = "[LSP]",
					module = "blink.cmp.sources.lsp",
					fallbacks = { "buffer" },
					score_offset = 0, -- Boost/penalize the score of the items
					override = nil, -- Override the source's functions
				},
				path = {
					name = "[PTH]",
					module = "blink.cmp.sources.path",
					score_offset = 3,
					fallbacks = { "buffer" },
					opts = {
						trailing_slash = false,
						label_trailing_slash = true,
						get_cwd = function(context)
							return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
						end,
						show_hidden_files_by_default = false,
					},
				},
				snippets = {
					name = "[SNP]",
					module = "blink.cmp.sources.snippets",
					opts = {
						friendly_snippets = true,
						search_paths = { vim.fn.stdpath("config") .. "/snippets" },
						global_snippets = { "all" },
						extended_filetypes = {},
						ignored_filetypes = {},
						get_filetype = function(_)
							return vim.bo.filetype
						end,
					},
				},
				luasnip = {
					name = "[SNP]",
					test = "blink.cmp.sources.luasnip",
					opts = { use_show_condition = true, show_autosnippets = true },
				},
				buffer = {
					name = "[BFR]",
					module = "blink.cmp.sources.buffer",
					opts = {
						-- default to all visible buffers
						get_bufnrs = function()
							return vim.iter(vim.api.nvim_list_wins())
								:map(function(win)
									return vim.api.nvim_win_get_buf(win)
								end)
								:filter(function(buf)
									return vim.bo[buf].buftype ~= "nofile"
								end)
								:totable()
						end,
					},
				},
			},
		},
	},
	-- allows extending the providers array elsewhere in your config
	-- without having to redefine it
	opts_extend = { "sources.default" },
}
