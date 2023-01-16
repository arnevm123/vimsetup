return {
	-- Useful lua functions used by lots of plugins
	"nvim-lua/plenary.nvim",
	-- Nerd font helper
	"kyazdani42/nvim-web-devicons",
	-- Colorschemes
	{
		"mcchrish/zenbones.nvim",
		priority = 1000,
		dependencies = { "rktjmp/lush.nvim" },
		config = function()
			require("base.colorscheme")
		end,
		lazy = false,
	},

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
		"akinsho/bufferline.nvim",
		config = function()
			require("arne.bufferline")
		end,
		event = "BufReadPost",
	},
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("arne.lualine")
		end,
		event = "BufReadPost",
	},
	{
		-- Show help for keycombos
		"folke/which-key.nvim",
		config = function()
			require("arne.whichkey")
		end,
		event = "BufReadPost",
	},
	{
		-- Show help for keycombos
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({
				window = {
					width = 160,
					options = {
						number = true,
						relativenumber = true,
					},
				},
			})
		end,
	},
	-- session management
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help" } },
        -- stylua: ignore
        keys = {
            { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
            { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
            { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
        },
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			-- Autocompletion
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			-- Snippets
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			-- for formatters and linters
			"jose-elias-alvarez/null-ls.nvim",
			"SmiteshP/nvim-navic",
			{
				"j-hui/fidget.nvim",
				opts = {
					text = {
						spinner = "dots",
					},
					window = {
						blend = 0,
					},
				},
			},
		},
		config = function()
			require("base.lsp")
		end,
		event = "BufEnter",
	},

	-- Be fast
	{
		"ThePrimeagen/refactoring.nvim",
		config = true,
	},
	{
		"ThePrimeagen/harpoon",
		opts = {
			-- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
			save_on_toggle = false,
			-- saves the harpoon file upon every change. disabling is unrecommended.
			save_on_change = true,
			-- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
			enter_on_sendcmd = true,
			-- closes any tmux windows harpoon that harpoon creates when you close Neovim.
			tmux_autoclose_windows = false,
			-- filetypes that you want to prevent from adding to the harpoon list menu.
			excluded_filetypes = { "harpoon" },
			-- set marks specific to each git branch inside git repository
			mark_branch = true,
		},
	},

	-- Debugger
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-telescope/telescope-dap.nvim",
		},
		config = function()
			require("arne.debug")
		end,
		cmd = { "GoDebug", "GoTest" },
	},
	{
		"moll/vim-bbye",
		cmd = { "Bdelete", "Bwipeout" },
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-file-browser.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-live-grep-args.nvim",
		},
		config = function()
			require("base.telescope")
		end,
		cmd = { "Telescope", "TelescopeDiffMaster", "TelescopeDelta" },
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		event = "BufReadPost",
		config = function()
			require("base.treesitter")
		end,
	},
	-- Git
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("arne.gitsigns")
		end,
		event = "BufReadPost",
	},
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "Gclog", "Gvdiff", "Gvdiffsplit", "Gdiffsplit" },
	},
	{
		"TimUntersberger/neogit",
		cmd = "Neogit",
		config = function()
			require("arne.neogit")
		end,
		dependencies = "sindrets/diffview.nvim",
	},

	-- Golang
	{
		"ray-x/go.nvim",
		dependencies = {
			"ray-x/guihua.lua",
		},
		ft = "go",
		config = function()
			require("arne.go")
		end,
	},
	-- Various
	{
		"numToStr/Comment.nvim",
		config = function()
			require("arne.comment")
		end,
		keys = { "gc", "gb", { "gc", mode = "x" }, { "gb", mode = "x" } },
	},
	{
		"monaqa/dial.nvim",
		keys = { "<C-a>", "<C-x>" },
		config = function()
			require("arne.dial")
		end,
	},
	{
		"tommcdo/vim-exchange",
		keys = { { "X", mode = "v" }, "cx" },
	},
	{
		"RRethy/vim-illuminate",
		config = function()
			require("arne.illuminate")
		end,
	},
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
	},
	{
		"Wansmer/treesj",
		dependencies = "nvim-treesitter/nvim-treesitter",
		cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
		config = function()
			require("treesj").setup({ use_default_keymaps = false })
		end,
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

	-- General functionality
	{
		"AckslD/nvim-neoclip.lua",
		dependencies = { { "kkharji/sqlite.lua" } },
		config = function()
			require("arne.neoclip")
		end,
		lazy = false,
	},
	{
		"danymat/neogen",
		config = function()
			require("neogen").setup({})
		end,
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
	{
		"kylechui/nvim-surround",
		config = true,
		keys = { "ds", "cs", "ys", { "S", mode = "v" }, { "gS", mode = "v" } },
	},
	{
		"tpope/vim-unimpaired",
		keys = { "[", "]", "yo" },
	},
	{
		"chrisbra/csv.vim",
		ft = "csv",
	},
	{
		"jackMort/ChatGPT.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("arne.chatgpt")
		end,
		cmd = { "ChatGPT", "ChatGPTActAs", "ChatGPTEditWithInstructions", "ChatGPTRun" },
	},
	"Everduin94/nvim-quick-switcher",

	-- better diagnostics list and others
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
		keys = {
			{ "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
		},
	},

	-- todo comments
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = "BufReadPre",
		opts = {
			keywords = {
				AAA = { icon = "A ", color = "warning" },
			},
			highlight = {
				before = "fg", -- "fg" or "bg" or empty
				keyword = "bg", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
			},
		},
		keys = {
			{ "]t", "<cmd> require('todo-comments').jump_next()<CR>", desc = "Next todo comment" },
			{ "[t", "<cmd> require('todo-comments').jump_prev()<CR>", desc = "Previous todo comment" },
			-- { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo Trouble" },
			{ "<leader>xa", "<cmd>TodoQuickFix keywords=AAA<cr>", desc = "Todo Trouble" },
			{ "<leader>xt", "<cmd>TodoQuickFix<cr>", desc = "Todo Trouble" },
			{ "<leader>xT", "<cmd>TodoTelescope keywords=AAA<cr>", desc = "Todo Telescope" },
		},
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

-- unused:
-- "ibhagwan/fzf-lua",
-- "nvim-telescope/telescope-smart-history.nvim",
-- "nvim-telescope/telescope-frecency.nvim",
-- -- cmp plugins
--  "hrsh7th/nvim-cmp", -- The completion plugin
--  "hrsh7th/cmp-buffer", -- buffer completions
--  "hrsh7th/cmp-path", -- path completions
--  "saadparwaiz1/cmp_luasnip", -- snippet completions
--  "hrsh7th/cmp-nvim-lsp",
--  "hrsh7th/cmp-nvim-lua",
-- --  "fatih/vim-go",
-- --  "lvimuser/lsp-inlayhints.nvim"
--
-- -- snippets
--  "L3MON4D3/LuaSnip", --snippet engine

-- LSP
--  "neovim/nvim-lspconfig", -- enable LSP
--  "williamboman/nvim-lsp-installer", -- simple to use language server installer

--"lewis6991/impatient.nvim", -- Make nvim load faster
-- "MunifTanjim/prettier.nvim",
-- "ThePrimeagen/git-worktree.nvim",
-- "nvim-treesitter/playground",
--  "leoluz/nvim-dap-go"
-- -- LSP
-- {
--     "VonHeikemen/lsp-zero.nvim",
--     dependencies = {
--         -- LSP Support
--         { "neovim/nvim-lspconfig" },
--         { "williamboman/mason.nvim" },
--         { "williamboman/mason-lspconfig.nvim" },
--
--         -- Autocompletion
--         { "hrsh7th/nvim-cmp" },
--         { "hrsh7th/cmp-buffer" },
--         { "hrsh7th/cmp-path" },
--         { "saadparwaiz1/cmp_luasnip" },
--         { "hrsh7th/cmp-nvim-lsp" },
--         { "hrsh7th/cmp-nvim-lua" },
--
--         -- Snippets
--         { "L3MON4D3/LuaSnip" },
--         { "rafamadriz/friendly-snippets" },
--
--         -- for formatters and linters
--         { "jose-elias-alvarez/null-ls.nvim" },
--    },
--     config = function() require("base.lspZero") end,
--     lazy = false,
-- },
