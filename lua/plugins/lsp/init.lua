return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"rachartier/tiny-code-action.nvim",
			config = true,
		},
		{
			"smjonas/inc-rename.nvim",
			config = true,
		},
		"aznhe21/actions-preview.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		-- -- Autocompletion
		{
			"saghen/blink.cmp",
			lazy = false, -- lazy loading handled internally
			version = "v0.*",
			dependencies = "rafamadriz/friendly-snippets",
			---@module 'blink.cmp'
			---@type blink.cmp.Config
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
							-- Aligns the keyword you've typed to a component in the menu
							align_to_component = "none", -- or 'none' to disable
							columns = { { "label", "label_description", gap = 1 }, { "kind_icon"}, {"source_name" } },
							components = {
								kind_icon = { width = { fill = true } },
							},
						},
					},
					documentation = { auto_show = true, auto_show_delay_ms = 200 },
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

					-- Please see https://github.com/Saghen/blink.compat for using `nvim-cmp` sources
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
								get_filetype = function(context)
									return vim.bo.filetype
								end,
							},
						},
						luasnip = {
							name = "[SNP]",
							module = "blink.cmp.sources.luasnip",
							opts = {
								-- Whether to use show_condition for filtering snippets
								use_show_condition = true,
								-- Whether to show autosnippets in the completion list
								show_autosnippets = true,
							},
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

				appearance = {
					highlight_ns = vim.api.nvim_create_namespace("blink_cmp"),
					-- Sets the fallback highlight groups to nvim-cmp's highlight groups
					-- Useful for when your theme doesn't support blink.cmp
					-- Will be removed in a future release
					-- use_nvim_cmp_as_default = true,
					-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
					-- Adjusts spacing to ensure icons are aligned
					nerd_font_variant = "mono",
					kind_icons = {
						Text = "󰉿",
						Method = "󰊕",
						Function = "󰊕",
						Constructor = "󰒓",

						Field = "󰜢",
						Variable = "󰆦",
						Property = "󰖷",

						Class = "󱡠",
						Interface = "󱡠",
						Struct = "󱡠",
						Module = "󰅩",

						Unit = "󰪚",
						Value = "󰦨",
						Enum = "󰦨",
						EnumMember = "󰦨",

						Keyword = "󰻾",
						Constant = "󰏿",

						Snippet = "󱄽",
						Color = "󰏘",
						File = "󰈔",
						Reference = "󰬲",
						Folder = "󰉋",
						Event = "󱐋",
						Operator = "󰪚",
						TypeParameter = "󰬛",
					},
				},
			},
			-- allows extending the providers array elsewhere in your config
			-- without having to redefine it
			opts_extend = { "sources.default" },
		},
		-- "hrsh7th/nvim-cmp",
		-- "hrsh7th/cmp-buffer",
		-- "hrsh7th/cmp-path",
		-- "hrsh7th/cmp-nvim-lsp",
		-- "hrsh7th/cmp-cmdline",
		-- "hrsh7th/cmp-nvim-lsp-signature-help",
		"nanotee/sqls.nvim",
		-- {
		-- 	"MattiasMTS/cmp-dbee",
		-- 	dependencies = {
		-- 		{ "kndndrj/nvim-dbee" },
		-- 	},
		-- 	ft = "sql", -- optional but good to have
		-- 	opts = {}, -- needed
		-- },
		-- Snippets
		"L3MON4D3/LuaSnip",
		-- "saadparwaiz1/cmp_luasnip",
		-- "rafamadriz/friendly-snippets",
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					"lazy.nvim",
					"luvit-meta/library",
				},
			},
			dependencies = {
				{ "Bilal2453/luvit-meta" },
			},
		},
		"Decodetalkers/csharpls-extended-lsp.nvim",
		{
			"chrisgrieser/nvim-scissors",
			dependencies = "nvim-telescope/telescope.nvim", -- optional
			opts = {
				snippetDir = "~/.config/nvim/snippets",
			},
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets" } })
				vim.keymap.set("n", "<leader>se", function()
					require("scissors").editSnippet()
				end)
				vim.keymap.set({ "n", "x" }, "<leader>sa", function()
					require("scissors").addNewSnippet()
				end)
			end,
		},
		"pmizio/typescript-tools.nvim",
		{
			"folke/trouble.nvim",
			opts = {
				icons = {
					indent = {
						middle = " ",
						last = " ",
						top = " ",
						ws = "│  ",
					},
				},
				modes = {
					diagnostics = {
						groups = {
							{ "filename", format = "{file_icon} {basename:Title} {count}" },
						},
					},
				},
			},
			cmd = "Trouble",
			keys = {
				{
					"<leader>tr",
					"<cmd>Trouble diagnostics toggle filter.severity=vim.diagnostic.severity.ERROR<cr>",
					desc = "iagnostics: Error (Trouble)",
				},
				{
					"<leader>ta",
					"<cmd>Trouble diagnostics toggle<cr>",
					desc = "Diagnostics (Trouble)",
				},
			},
		},
		{
			"m00qek/baleia.nvim",
			version = "*",
			config = function()
				vim.g.baleia = require("baleia").setup({})
				-- Command to colorize the current buffer
				vim.api.nvim_create_user_command("BaleiaColorize", function()
					vim.g.baleia.once(vim.api.nvim_get_current_buf())
				end, { bang = true })
			end,
		},
		{
			"stevearc/conform.nvim",
			opts = {
				formatters = {
					sqlffluf = {
						command = "sqlfluff",
						args = { "fix", "--dialect=mysql", "-" },
						stdin = true,
					},
					goimports_reviser = {
						command = "goimports-reviser",
						args = { "-rm-unused", "-project-name", "unmatched.eu", "$FILENAME" },
						stdin = false,
					},
					gofumpt = { prepend_args = { "-extra" } },
				},
				formatters_by_ft = {
					go = { "gofumpt", "goimports", "goimports_reviser" },
					javascript = { "eslint_d", "prettierd", "prettier", stop_after_first = true },
					lua = { "stylua" },
					markdown = { "mdslw" },
					sh = { "shfmt" },
					typescript = { { "eslint_d", "prettierd", "prettier" } },
					-- yaml = { "yamlfmt" },
					mysql = { "sqlffluf" },
					python = { "isort", "black" },
				},
			},
		},
		{
			"j-hui/fidget.nvim",
			opts = {
				progress = {
					suppress_on_insert = true,
					ignore_done_already = true,
					display = {
						done_ttl = 1,
						done_icon = "",
						done_style = "Comment",
						progress_style = "Comment",
						progress_ttl = 30,
						group_style = "@method",
						icon_style = "@method",
						format_message = function(msg)
							local message = msg.message
							if not message then
								message = msg.done and "✔" or "..."
							end
							if msg.percentage ~= nil then
								message = string.format("%.0f%%", msg.percentage)
							end
							return message
						end,
					},
					ignore = {},
				},
				notification = { window = { winblend = 0 } },
			},
		},
	},
	keys = {
		{ "<leader>la", vim.lsp.buf.code_action, desc = "lsp Code Action", mode = { "n", "v" } },
		-- { "<leader>la", "<cmd>lua require('actions-preview').code_actions()<CR>", desc = "lsp Code Action", mode = { "n", "v" } },
		-- {
		-- 	"<leader>la",
		-- 	"<cmd>lua require('tiny-code-action').code_action()<CR>",
		-- 	desc = "lsp Code Action",
		-- 	mode = { "n", "v" },
		-- },
		{ "<leader>ld", "<cmd>Telescope diagnostics<CR>", desc = "lsp diagnostics" },
		{
			"<leader>lf",
			"<cmd>lua require('conform').format({ async = true, lsp_fallback = true })<CR>",
			desc = "lsp format buffer",
		},
		{ "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<CR>", desc = "lsp codelens" },
		-- { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "lsp rename variable" },
		{ "<leader>lr", '"hyiw:IncRename <C-r>h', desc = "lsp rename variable" },
		{ "<leader>li", "<cmd>LspInfo<CR>", desc = "lsp info" },
		{ "<leader>le", "<cmd>LspRestart<CR>", desc = "Restart lsp" },
	},
	config = function()
		require("plugins.lsp.mason")
		require("plugins.lsp.handlers").setup()
	end,
	event = { "BufReadPre", "BufNewFile" },
}
