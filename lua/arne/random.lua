return {
	{
		"elihunter173/dirbuf.nvim",
		config = function()
			require("dirbuf").setup({
				hash_padding = 2,
				show_hidden = true,
				sort_order = "default",
				write_cmd = "DirbufSync",
			})
		end,
		cmd = "Dirbuf",
	},
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
		-- UI IMPROVEMENTS
		"stevearc/dressing.nvim",
		config = {
			input = {
				insert_only = false,
			},
		},
		event = "VeryLazy",
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
					require("neogen").generate()
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
	-- {
	-- 	"Exafunction/codeium.vim",
	-- 	--stylua: ignore
	-- 	config = function()
	-- 		vim.keymap.set('i', '<C-k>', function () return vim.fn['codeium#Accept']() end, { expr = true })
	-- 		vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
	-- 		vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
	-- 		vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
	-- 	end,
	-- 	event = "BufReadPost",
	-- },
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
		"vibovenkat123/rgpt.nvim",
		cmd = { "ReviewGPT" },
		keys = {
			{ "<leader>er", ":ReviewGPT review<CR>", desc = "review" },
		},
		config = true,
	},
	{
		-- makes :e /path:101 work
		"wsdjeg/vim-fetch",
		lazy = false,
	},
	{
		"JellyApple102/easyread.nvim",
		config = true,
		cmd = {
			"EasyreadToggle",
			"EasyreadSaccadeInterval",
			"EasyreadSaccadeReset",
			"EasyreadUpdateWhileInsert",
		},
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = {
			"lua",
			"css",
			DEFAULT_OPTIONS = {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				names = true, -- "Name" codes like Blue
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
				rgb_fn = false, -- CSS rgb() and rgba() functions
				hsl_fn = false, -- CSS hsl() and hsla() functions
				mode = "background", -- Set the display mode.
			},
		},
		event = "BufReadPost",
	},
}
