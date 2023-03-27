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
				function() require("neogen").generate() end,
				desc = "Generate comment",
			},
			{
				"<Leader>nc",
				function() require("neogen").generate({ type = "class" }) end,
				desc = "Generate class comment",
			},
			{
				"<Leader>nf",
				function() require("neogen").generate({ type = "func" }) end,
				desc = "Generate function comment",
			},
			{
				"<Leader>nt",
				function() require("neogen").generate({ type = "type" }) end,
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
		"lukas-reineke/headlines.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			vim.api.nvim_set_hl(0, "Headline1", { bg = "#1e2718" })
			vim.api.nvim_set_hl(0, "Headline2", { bg = "#21262d" })
			vim.api.nvim_set_hl(0, "CodeBlock", { bg = "#1c1c1c" })
			vim.api.nvim_set_hl(0, "Dash", { bg = "#D19A66" })
			require("headlines").setup({
				markdown = {
					headline_highlights = { "Headline1", "Headline2" },
				},
			})
		end, -- or `opts = {}`
		ft = "markdown",
	},
	{
		"chrisbra/csv.vim",
		ft = "csv",
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
		-- TODO: use this when stable
		-- "toppair/peek.nvim",
		"hulufei/peek.nvim",
		branch = "use-browser",
		build = "deno task --quiet build:fast",
		cmd = { "PeekOpen", "PeekClose" },
		config = function()
			require("peek").setup({
				auto_load = true,
				close_on_bdelete = true,
				syntax = true,
				theme = "dark",
				update_on_change = true,
				throttle_at = 200000,
				throttle_time = "auto",
			})
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open(), {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close(), {})
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
}
