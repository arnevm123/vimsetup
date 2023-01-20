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
	-- Be fast
	{
		"moll/vim-bbye",
		cmd = { "Bdelete", "Bwipeout" },
		keys = {
			{ "<leader>qq", ":Bdelete!<CR>", desc = "delete current buffer" },
		},
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
		-- stylua: ignore
		keys = {
			{ "<Leader>ng",  function() require('neogen').generate() end },
			{ "<Leader>nc",  function() require('neogen').generate({ type = 'class' }) end },
			{ "<Leader>nf",  function() require('neogen').generate({ type = 'func' }) end },
			{ "<Leader>nt",  function() require('neogen').generate({ type = 'type' }) end },
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
		"Everduin94/nvim-quick-switcher",
		keys = {
			{
				"<leader>os",
				function()
					require("nvim-quick-switcher").find(".service.ts")
				end,
				{ noremap = true, silent = true, desc = "Go to service" },
			},
			{
				"<leader>ou",
				function()
					require("nvim-quick-switcher").find(".component.ts")
				end,
				{ noremap = true, silent = true, desc = "Go to TS" },
			},
			{
				"<leader>oo",
				function()
					require("nvim-quick-switcher").find(".component.html")
				end,
				{ noremap = true, silent = true, desc = "Go to html" },
			},
			{
				"<leader>op",
				function()
					require("nvim-quick-switcher").find(".module.ts")
				end,
				{ noremap = true, silent = true, desc = "Go to module" },
			},
			{
				"<leader>ol",
				function()
					require("nvim-quick-switcher").find("*util.*")
				end,
				{ noremap = true, silent = true, desc = "Go to util" },
			},
			{
				"<leader>oi",
				function()
					require("nvim-quick-switcher").find(".+css|.+scss|.+sass", { regex = true, prefix = "full" })
				end,
				{ noremap = true, silent = true, desc = "Go to stylesheet" },
			},
		},
	},

	-- better diagnostics list and others
	{
		"Exafunction/codeium.vim",
		config = function()
			vim.keymap.set("i", "<C-k>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })
		end,
		event = "BufReadPost",
	},
	{
		-- TODO: use this when stable
		-- "toppair/peek.nvim",
		"hulufei/peek.nvim",
		branch = "use-browser",
		build = "deno task --quiet build:fast",
		opts = {
			auto_load = true, -- whether to automatically load preview when
			-- entering another markdown buffer
			close_on_bdelete = true, -- close preview window on buffer delete
			syntax = true, -- enable syntax highlighting, affects performance
			theme = "dark", -- 'dark' or 'light'
			update_on_change = true,
			-- relevant if update_on_change is true
			throttle_at = 200000, -- start throttling when file exceeds this
			-- amount of bytes in size
			throttle_time = "auto", -- minimum amount of time in milliseconds
			-- that has to pass before starting new render
		},
	},
}
