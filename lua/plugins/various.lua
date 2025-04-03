return {
	{
		"topaxi/pipeline.nvim",
		keys = { { "<leader>ci", "<cmd>Pipeline<cr>", desc = "Open pipeline.nvim" } },
		build = "make",
		opts = {
			providers = { gitlab = { "https://gitlab.telecom-it.be/api/graphql/" } },
			allowed_hosts = { "gitlab.telecom-it.be" },
		},
	},
	{ "nanotee/sqls.nvim", lazy = false },
	{ "typicode/bg.nvim", lazy = false }, -- Sync bg colors between nvim and terminal
	{ "tpope/vim-eunuch", event = "VeryLazy" }, -- :Remove
	{ "tpope/vim-dispatch", event = "VeryLazy" }, -- :Make
	{ "johmsalas/text-case.nvim", opts = { substitude_command_name = "S" }, event = "VeryLazy" },
	{ "wsdjeg/vim-fetch", lazy = false }, -- :e file:line
	{ "akinsho/git-conflict.nvim", config = true, event = "VeryLazy" },
	{ "chrisbra/csv.vim", ft = "csv" },
	{ "pearofducks/ansible-vim", ft = "yaml" },
	{ "chentoast/marks.nvim", event = "VeryLazy", opts = { default_mappings = false } },
	{ "mbbill/undotree", keys = { { "<leader>eu", "<cmd>UndotreeToggle<CR>" } } },
	{ "mcauley-penney/visual-whitespace.nvim", event = "VeryLazy", opts = { nl_char = "" } },
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
			require("Comment.ft").set("mysql", { "--%s", "/*%s*/" })
		end,
		event = "VeryLazy",
	},
	{
		"MagicDuck/grug-far.nvim",
		opts = {
			startInInsertMode = false,
			transient = true,
		},
		config = true,
		keys = {
			{ "<leader>ss", "<cmd>lua require('grug-far').grug_far()<CR>" },
			{ "<leader>ss", "<cmd>lua require('grug-far').with_visual_selection()<CR>", mode = "x" },
		},
	},
	{
		"Wansmer/treesj",
		keys = {
			{ "<space>ej", "<cmd>lua require('treesj').join()<CR>", desc = "Join lines" },
			{ "<space>ek", "<cmd>lua require('treesj').split()<CR>", desc = "Split lines" },
		},
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = { use_default_keymaps = false },
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"gbprod/yanky.nvim",
		opts = {
			ring = { storage = "sqlite" },
			system_clipboard = { sync_with_ring = false },
			highlight = { timer = 75, on_yank = false },
			preserve_cursor_position = { enabled = false },
			textobj = { enabled = true },
		},
		keys = {
			{ "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" } },
			{ "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" } },
			{ "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" } },
			{ "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" } },
			{ "<c-n>", "<Plug>(YankyNextEntry)" },
			{ "<c-p>", "<Plug>(YankyPreviousEntry)" },
		},
	},
}
