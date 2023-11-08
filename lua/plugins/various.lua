return {
	-- text manipulation
	{ "tommcdo/vim-exchange", keys = { { "X", mode = "v" }, "cx" } },
	{ "wellle/targets.vim", event = "BufEnter" },
	{ "numToStr/Comment.nvim", config = true, keys = { "gc", "gb", { "gc", mode = "x" }, { "gb", mode = "x" } } },
	{ "kylechui/nvim-surround", config = true, keys = { "ds", "cs", "ys", { "S", mode = "v" }, { "gS", mode = "v" } } },
	{ "nvim-pack/nvim-spectre", keys = { { "<leader>S", ":lua require('spectre').open()<CR>" } } },
	{
		"tpope/vim-rsi",
		event = "BufEnter",
		config = function()
			vim.g.rsi_no_meta = 1
		end,
	},
	{
		"Wansmer/treesj",
		dependencies = "nvim-treesitter/nvim-treesitter",
		opts = { use_default_keymaps = false },
		keys = {
			{ "ga", ":TSJJoin<CR>", desc = "Join lines" },
			{ "gs", ":TSJSplit<CR>", desc = "Split lines" },
		},
	},
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = {
			default_mappings = {
				ours = "<leader>zo",
				theirs = "<leader>zt",
				none = "<leader>z0",
				both = "<leader>zb",
				next = "]x",
				prev = "[x",
			},
		},
		lazy = false,
	},
	-- file types
	{ "chrisbra/csv.vim", ft = "csv" },
	{ "tpope/vim-dispatch", cmd = { "Make", "Dispatch" } },
	{ "pearofducks/ansible-vim", ft = "yaml" },
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
	-- navigation
	{ "wsdjeg/vim-fetch", lazy = false },
	{ "moll/vim-bbye", keys = { { "<leader>bq", ":Bdelete!<CR>", desc = "delete current buffer" } } },
	{ "mbbill/undotree", keys = { { "<leader>eu", ":UndotreeToggle<CR>", desc = "Toggle undo tree" } } },
	{ "arnevm123/unimpaired.nvim", config = true, keys = { "[", "]", "yo" } },
	{
		"kevinhwang91/nvim-bqf",
		dependencies = { "junegunn/fzf" },
		ft = "qf",
		opts = {
			preview = { auto_preview = false },
			filter = {
				fzf = {
					action_for = { ["ctrl-s"] = "split", ["ctrl-t"] = "tab drop" },
					extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
				},
			},
		},
	},
	{
		"Everduin94/nvim-quick-switcher",
		--stylua: ignore
		keys = {
			{ "<leader>os", function() require("nvim-quick-switcher").find(".service.ts") end, desc = "Go to service" },
			{ "<leader>ou", function() require("nvim-quick-switcher").find(".component.ts") end, desc = "Go to TS" },
			{ "<leader>oo", function() require("nvim-quick-switcher").find(".component.html") end, desc = "Go to html" },
			{ "<leader>op", function() require("nvim-quick-switcher").find(".module.ts") end, desc = "Go to module" },
			{ "<leader>ol", function() require("nvim-quick-switcher").find("*util.*") end, desc = "Go to util" },
			{
				"<leader>oi",
				function() require("nvim-quick-switcher").find(".+css|.+scss|.+sass", { regex = true, prefix = "full" }) end,
				desc = "Go to stylesheet",
			},
		},
	},
	{
		"ThePrimeagen/harpoon",
		opts = {
			save_on_toggle = false,
			save_on_change = true,
			enter_on_sendcmd = true,
			tmux_autoclose_windows = false,
			excluded_filetypes = { "harpoon" },
			mark_branch = true,
		},
		event = "BufEnter",
		--stylua: ignore
		keys = {
			{ "<leader>a", function() require("harpoon.mark").add_file() end, desc = "harpoon add file" },
			{
				"<leader>A",
				function()
					require("harpoon.ui").toggle_quick_menu()
					vim.cmd.norm("$ze")
				end,
				desc = "harpoon quick menu",
			},
			{ "<C-h>", function() require("harpoon.ui").nav_file(1) end, desc = "harpoon file 1" },
			{ "<C-j>", function() require("harpoon.ui").nav_file(2) end, desc = "harpoon file 2" },
			{ "<C-k>", function() require("harpoon.ui").nav_file(3) end, desc = "harpoon file 3" },
			{ "<C-l>", function() require("harpoon.ui").nav_file(4) end, desc = "harpoon file 4" },
		},
	},

	-- AI
	{
		"Exafunction/codeium.vim",
		--stylua: ignore
		--selene: allow(multiple_statements)
		config = function()
			vim.keymap.set("i", "<tab>", function() return vim.fn["codeium#Accept"]() end, { expr = true })
			vim.keymap.set("i", "<C-l>", function() return vim.fn["codeium#Complete"]() end, { expr = true })
			vim.keymap.set("i", "<C-k>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true })
			vim.keymap.set("i", "<C-j>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true })
			vim.keymap.set("i", "<c-h>", function() return vim.fn["codeium#Clear"]() end, { expr = true })
			vim.g.codeium_filetypes = { telescope = false }
			vim.g.codeium_manual = true
		end,
		event = "BufReadPost",
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
	-- {
	-- 	"harrisoncramer/gitlab.nvim",
	-- 	dependencies = {
	-- 		"MunifTanjim/nui.nvim",
	-- 		"nvim-lua/plenary.nvim",
	-- 	},
	-- 	build = function()
	-- 		require("gitlab").build()
	-- 	end,
	-- 	config = function()
	-- 		require("gitlab").setup()
	-- 	end,
	-- },
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = "BufReadPre",
		opts = {
			keywords = {
				FIX = {
					icon = "? ", -- icon used for the sign, and in search results
					color = "error", -- can be a hex color, or a named color (see below)
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
					-- signs = false, -- configure signs for some keywords individually
				},
				TODO = { icon = "✓ ", color = "info" },
				NOTE = { icon = "󰲶 ", color = "hint", alt = { "INFO" } },
				HACK = { icon = " ", color = "error" },
				TEST = { icon = "󱈲 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
				PERF = { icon = "󰅒 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				AAA = { icon = " ", color = "test" },
			},
			highlight = {
				before = "fg", -- "fg" or "bg" or empty
				keyword = "bg", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
			},
		},
		keys = {
			{ "]t", "<cmd>lua require('todo-comments').jump_next()<CR>", desc = "Next todo comment" },
			{ "[t", "<cmd>lua require('todo-comments').jump_prev()<CR>", desc = "Previous todo comment" },
			-- { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo Trouble" },
			{ "<leader>xa", "<cmd>TodoQuickFix keywords=AAA<cr>", desc = "Todo Trouble Arne" },
			{ "<leader>xA", "<cmd>TodoTelescope keywords=AAA<cr>", desc = "Todo Telescope Arne" },
			{ "<leader>xt", "<cmd>TodoQuickFix<cr>", desc = "Todo Trouble" },
			{ "<leader>xT", "<cmd>TodoTelescope<cr>", desc = "Todo Telescope" },
		},
	},
	{
		-- Show help for keycombos
		"folke/which-key.nvim",
		event = "BufReadPost",
		opts = {
			plugins = {
				marks = true, -- shows a list of your marks on ' and `
				registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
				spelling = {
					enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
					suggestions = 20, -- how many suggestions should be shown in the list?
				},
				presets = {
					operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
					motions = false, -- adds help for motions
					text_objects = false, -- help for text objects triggered after entering an operator
					windows = true, -- default bindings on <c-w>
					nav = true, -- misc bindings to work with windows
					z = true, -- bindings for folds, spelling and others prefixed with z
					g = true, -- bindings for prefixed with g
				},
			},
			key_labels = {},
			icons = {
				breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
				separator = "➜", -- symbol used between a key and it's label
				group = "+", -- symbol prepended to a group
			},
			popup_mappings = {
				scroll_down = "<c-d>", -- binding to scroll down inside the popup
				scroll_up = "<c-u>", -- binding to scroll up inside the popup
			},
			window = {
				border = "none", -- none, single, double, shadow
				position = "bottom", -- bottom, top
				margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
				padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
				winblend = 0,
			},
			layout = {
				height = { min = 4, max = 25 }, -- min and max height of the columns
				width = { min = 20, max = 50 }, -- min and max width of the columns
				spacing = 3, -- spacing between columns
				align = "left", -- align columns left, center or right
			},
			ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
			hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
			show_help = true, -- show help message on the command line when the popup is visible
			triggers = "auto", -- automatically setup triggers
			-- triggers = {"<leader>"} -- or specify a list manually
			triggers_blacklist = {
				i = { "j", "k" },
				v = { "j", "k" },
			},
		},
	},
	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({
				delay = 0,
				under_cursor = false,
				large_file_cutoff = 3000,
			})
			require("illuminate").toggle()
			vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#4B4B4B" })
		end,
		keys = {
			{ "yor", '<cmd>lua require("illuminate").toggle()<cr>' },
			{ "]r", '<cmd>lua require("illuminate").goto_next_reference(wrap)<cr>' },
			{ "[r", '<cmd>lua require("illuminate").goto_prev_reference(wrap)<cr>' },
		},
	},
	{
		"tzachar/highlight-undo.nvim",
		opts = {
			duration = 75,
		},
		event = "BufEnter",
	},
	{
		"lambdalisue/suda.vim",
		cmd = { "SudaRead", "SudaWrite" },
	},
	{
		"kevinhwang91/nvim-fundo",
		dependencies = "kevinhwang91/promise-async",
		run = function()
			require("fundo").install()
		end,
		config = function()
			vim.o.undofile = true
			require("fundo").setup()
		end,
		lazy = false,
	},
}
