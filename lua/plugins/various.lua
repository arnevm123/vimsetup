return {
	{ "tpope/vim-eunuch", event = "VeryLazy" }, -- :Remove
	{ "tpope/vim-dispatch", event = "VeryLazy" }, -- :Make
	{ "johmsalas/text-case.nvim", opts = { substitude_command_name = "S" }, event = "VeryLazy" },
	{ "wsdjeg/vim-fetch", lazy = false }, -- :e file:line
	{ "akinsho/git-conflict.nvim", config = true, event = "VeryLazy" },
	{ "chrisbra/csv.vim", ft = "csv" },
	{ "pearofducks/ansible-vim", ft = "yaml" },
	{ "arnevm123/unimpaired.nvim", config = true, event = "VeryLazy" },
	{ "chentoast/marks.nvim", event = "VeryLazy", opts = { default_mappings = false } },
	{ "mbbill/undotree", keys = { { "<leader>eu", "<cmd>UndotreeToggle<CR>" } } },
	{ "mcauley-penney/visual-whitespace.nvim", event = "VeryLazy", config = true },
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
			require("Comment.ft").set("mysql", { "--%s", "/*%s*/" })
		end,
		event = "VeryLazy",
	},
	{
		"gcmt/vessel.nvim",
		opts = { create_commands = true, commands = { view_marks = "Marks" } },
		keys = {
			{ "<leader>hv", "<plug>(VesselViewMarks)" },
			{ "<leader>hb", "<plug>(VesselViewBufferMarks)" },
			{ "m.", "<plug>(VesselSetGlobalMark)" },
			{ "m,", "<plug>(VesselSetLocalMark)" },
		},
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
}
