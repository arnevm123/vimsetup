return {
	{
		"moll/vim-bbye",
		cmd = { "Bdelete", "Bwipeout" },
		keys = {
			{ "<leader>qq", ":Bdelete!<CR>", desc = "delete current buffer" },
		},
	},
	{
		"nanotee/sqls.nvim",
		ft = "ddl",
	},
	{
		"andymass/vim-matchup",
		config = function()
			vim.g.matchup_matchparen_offscreen = {}
			vim.g.matchup_text_obj_enabled = 0
			vim.g.matchup_surround_enabled = 1
		end,
		event = "BufReadPre",
	},
	-- Git
	-- Various
	{
		"numToStr/Comment.nvim",
		keys = { "gc", "gb", { "gc", mode = "x" }, { "gb", mode = "x" } },
		config = true,
	},
	{
		"tommcdo/vim-exchange",
		keys = { { "X", mode = "v" }, "cx" },
	},
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		keys = {
			{ "<leader>eu", ":UndotreeToggle<CR>", desc = "Toggle undo tree" },
		},
	},
	{
		"Wansmer/treesj",
		dependencies = "nvim-treesitter/nvim-treesitter",
		cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
		config = function()
			require("treesj").setup({ use_default_keymaps = false })
		end,
		keys = {
			{ "gj", ":TSJJoin<CR>", desc = "Join lines" },
			{ "gs", ":TSJSplit<CR>", desc = "Split lines" },
		},
	},
	-- Database
	{
		"arnevm123/vim-dadbod",
		dependencies = {
			"kristijanhusak/vim-dadbod-ui",
			"kristijanhusak/vim-dadbod-completion",
		},
		cmd = { "DBUIToggle", "DBUI", "DBUIAddConnection", "DBUIFindBuffer", "DBUIRenameBuffer", "DBUILastQueryInfo" },
	},
	{
		"danymat/neogen",
		config = true,
		dependencies = "nvim-treesitter/nvim-treesitter",
		keys = {
			{
				"<Leader>ng",
				function()
					require("neogen").generate({})
				end,
				desc = "Generate comment",
			},
			{
				"<Leader>nc",
				function()
					require("neogen").generate({ type = "class" })
				end,
				desc = "Generate class comment",
			},
			{
				"<Leader>nf",
				function()
					require("neogen").generate({ type = "func" })
				end,
				desc = "Generate function comment",
			},
			{
				"<Leader>nt",
				function()
					require("neogen").generate({ type = "type" })
				end,
				desc = "Generate type comment",
			},
		},
	},
	{
		"kylechui/nvim-surround",
		config = true,
		keys = { "ds", "cs", "ys", { "S", mode = "v" }, { "gS", mode = "v" } },
	},
	{
		"chrisbra/csv.vim",
		ft = "csv",
	},
	{
		"pearofducks/ansible-vim",
		ft = "yaml",
	},
	{
		"Everduin94/nvim-quick-switcher",
		keys = {
			{
				"<leader>os",
				function()
					require("nvim-quick-switcher").find(".service.ts")
				end,
				desc = "Go to service",
			},
			{
				"<leader>ou",
				function()
					require("nvim-quick-switcher").find(".component.ts")
				end,
				desc = "Go to TS",
			},
			{
				"<leader>oo",
				function()
					require("nvim-quick-switcher").find(".component.html")
				end,
				desc = "Go to html",
			},
			{
				"<leader>op",
				function()
					require("nvim-quick-switcher").find(".module.ts")
				end,
				desc = "Go to module",
			},
			{
				"<leader>ol",
				function()
					require("nvim-quick-switcher").find("*util.*")
				end,
				desc = "Go to util",
			},
			{
				"<leader>oi",
				function()
					require("nvim-quick-switcher").find(".+css|.+scss|.+sass", { regex = true, prefix = "full" })
				end,
				desc = "Go to stylesheet",
			},
		},
	},
	{
		"Exafunction/codeium.vim",
		config = function()
			vim.keymap.set("i", "<tab>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })
			vim.keymap.set("i", "<C-h>", function()
				return vim.fn["codeium#Complete"]()
			end, { expr = true })
			vim.keymap.set("i", "<C-k>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true })
			vim.keymap.set("i", "<C-j>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true })
			vim.keymap.set("i", "<c-x>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true })
			vim.g.codeium_filetypes = {
				telescope = false,
			}
			vim.g.codeium_manual = true
		end,
		event = "BufReadPost",
	},
	{
		"buoto/gotests-vim",
		cmd = { "Gotests", "GoaTestsAll" },
	},
	{
		"nvim-pack/nvim-spectre",
		keys = {
			{ "<leader>S", ":lua require('spectre').open()<CR>", desc = "Search and replace accros multiple files" },
		},
	},
	{
		"toppair/peek.nvim",
		build = "deno task --quiet build:fast",
		cmd = { "PeekOpen", "PeekClose" },
		config = function()
			-- default config:
			require("peek").setup({
				auto_load = true, -- whether to automatically load preview when entering another markdown buffer
				close_on_bdelete = true, -- close preview window on buffer delete
				syntax = true, -- enable syntax highlighting, affects performance
				theme = "dark", -- 'dark' or 'light'
				update_on_change = true,
				app = "webview", -- 'webview', 'browser', string or a table of strings
				filetype = { "markdown" }, -- list of filetypes to recognize as markdown
				throttle_at = 200000, -- start throttling when file exceeds this
				throttle_time = "auto", -- minimum amount of time in milliseconds
			})
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		end,
	},
	{
		-- makes :e /path:101 work
		"wsdjeg/vim-fetch",
		lazy = false,
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = {
			"lua",
			"css",
			DEFAULT_OPTIONS = {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				names = false, -- "Name" codes like Blue
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
				rgb_fn = false, -- CSS rgb() and rgba() functions
				hsl_fn = false, -- CSS hsl() and hsla() functions
				mode = "background", -- Set the display mode.
			},
		},
		event = "BufReadPost",
	},
	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({
				providers = { "lsp", "treesitter", "regex" },
				delay = 0,
				filetype_overrides = {},
				filetypes_denylist = {
					"dirvish",
					"fugitive",
					"alpha",
					"NvimTree",
					"packer",
					"neogitstatus",
					"Trouble",
					"lir",
					"Outline",
					"spectre_panel",
					"toggleterm",
					"DressingSelect",
					"TelescopePrompt",
				},
				filetypes_allowlist = {},
				modes_denylist = {},
				modes_allowlist = {},
				providers_regex_syntax_denylist = {},
				providers_regex_syntax_allowlist = {},
				under_cursor = false,
				large_file_cutoff = nil,
				large_file_overrides = nil,
				min_count_to_highlight = 1,
			})
			vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#4B4B4B" })
			vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#4B4B4B" })
			vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#4B4B4B" })
			vim.keymap.set("n", "yor", '<cmd>lua require("illuminate").toggle()<cr>', { noremap = true, silent = true })
			vim.keymap.set(
				"n",
				"]r",
				'<cmd>lua require("illuminate").goto_next_reference(wrap)<cr>',
				{ noremap = true, silent = true }
			)
			vim.keymap.set(
				"n",
				"[r",
				'<cmd>lua require("illuminate").goto_prev_reference(wrap)<cr>',
				{ noremap = true, silent = true }
			)
			require("illuminate").toggle()
		end,
		event = "BufReadPost",
	},
	{
		"stevearc/oil.nvim",
		opts = {
			-- Id is automatically added at the beginning, and name at the end
			-- See :help oil-columns
			columns = {
				-- "mtime",
				"permissions",
				"size",
				"icon",
			},
			-- Buffer-local options to use for oil buffers
			buf_options = {
				buflisted = false,
			},
			-- Window-local options to use for oil buffers
			win_options = {
				wrap = false,
				signcolumn = "no",
				cursorcolumn = false,
				foldcolumn = "0",
				spell = false,
				list = false,
				conceallevel = 3,
				concealcursor = "n",
			},
			-- Oil will take over directory buffers (e.g. `vim .` or `:e src/`
			default_file_explorer = false,
			-- Restore window options to previous values when leaving an oil buffer
			restore_win_options = true,
			-- Skip the confirmation popup for simple operations
			skip_confirm_for_simple_edits = false,
			-- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
			-- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
			-- Additionally, if it is a string that matches "actions.<name>",
			-- it will use the mapping at require("oil.actions").<name>
			-- Set to `false` to remove a keymap
			-- See :help oil-actions for a list of all available actions
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<leader>v"] = "actions.select_vsplit",
				["<leader>h"] = "actions.select_split",
				["<leader>t"] = "actions.select_tab",
				["<leader>p"] = "actions.preview",
				["<leader>r"] = "actions.refresh",
				["<leader>cd"] = "actions.cd",
				["q"] = "actions.close",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["~"] = "actions.tcd",
				["g."] = "actions.toggle_hidden",
			},
			-- Set to false to disable all of the above keymaps
			use_default_keymaps = false,
			view_options = {
				-- Show files and directories that start with "."
				show_hidden = true,
				-- This function defines what is considered a "hidden" file
				is_hidden_file = function(name, bufnr)
					return vim.startswith(name, ".")
				end,
				-- This function defines what will never be shown, even when `show_hidden` is set
				is_always_hidden = function(name, bufnr)
					return false
				end,
			},
			-- Configuration for the floating window in oil.open_float
			float = {
				-- Padding around the floating window
				padding = 2,
				max_width = 0,
				max_height = 0,
				border = "rounded",
				win_options = {
					winblend = 10,
				},
			},
			-- Configuration for the actions floating preview window
			preview = {
				-- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
				-- min_width and max_width can be a single value or a list of mixed integer/float types.
				-- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
				max_width = 0.9,
				-- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
				min_width = { 40, 0.4 },
				-- optionally define an integer/float for the exact width of the preview window
				width = nil,
				-- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
				-- min_height and max_height can be a single value or a list of mixed integer/float types.
				-- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
				max_height = 0.9,
				-- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
				min_height = { 5, 0.1 },
				-- optionally define an integer/float for the exact height of the preview window
				height = nil,
				border = "rounded",
				win_options = {
					winblend = 0,
				},
			},
			-- Configuration for the floating progress window
			progress = {
				max_width = 0.9,
				min_width = { 40, 0.4 },
				width = nil,
				max_height = { 10, 0.9 },
				min_height = { 5, 0.1 },
				height = nil,
				border = "rounded",
				minimized_border = "none",
				win_options = {
					winblend = 0,
				},
			},
		},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = { "Oil" },
	},
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		config = true,
	},
}
