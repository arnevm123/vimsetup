return {
	{ "tpope/vim-rsi", event = "VeryLazy" }, -- c-w in insert and more
	{ "tpope/vim-eunuch", event = "VeryLazy" }, -- :Remove
	{ "tpope/vim-dispatch", event = "VeryLazy" }, -- :Make
	{ "johmsalas/text-case.nvim", opts = { substitude_command_name = "S" }, event = "VeryLazy" },
	{ "wsdjeg/vim-fetch", lazy = false }, -- :e file:line
	{ "akinsho/git-conflict.nvim", config = true, event = "VeryLazy" },
	{ "kylechui/nvim-surround", config = true, event = "VeryLazy" },
	{ "chrisbra/csv.vim", ft = "csv" },
	{ "pearofducks/ansible-vim", ft = "yaml" },
	{ "arnevm123/unimpaired.nvim", config = true, event = "VeryLazy" },
	{ "chrisgrieser/nvim-various-textobjs", event = "UIEnter", opts = { keymaps = { useDefaults = true } } },
	{ "chentoast/marks.nvim", event = "VeryLazy", opts = { default_mappings = false } },
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
			{ "<leader>ss", "<cmd>lua require('grug-far').grug_far()<CR>", desc = "Toggle Grug Far" },
			{
				"<leader>su",
				"<cmd>lua require('grug-far').grug_far({ prefills = { search = vim.fn.expand('<cword>') } } )<CR>",
				desc = "Toggle Grug Far",
			},
			{
				"<leader>ss",
				"<cmd>lua require('grug-far'). with_visual_selection()<CR>",
				mode = "x",
				desc = "Toggle Grug Far",
			},
		},
	},
	{
		"mbbill/undotree",
		config = function()
			vim.cmd([[ let g:undotree_WindowLayout=4 ]])
		end,
		keys = { { "<leader>eu", "<cmd>UndotreeToggle<CR>", desc = "Toggle undo tree" } },
	},
	{
		"amadanmath/diag_ignore.nvim",
		keys = {
			{ "<Leader>le", "<Plug>(diag_ignore)", mode = "n", desc = "Diagnostic: ignore" },
		},
		opts = {
			ignores = {
				python = { "endline", " # pyright: ignore[", "]" },
				lua = { "prevline", "---@diagnostic disable-next-line: " },
				go = { "endline", " // nolint: ", code = "source" },
			},
		},
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.code_actions.gomodifytags,
					null_ls.builtins.code_actions.impl,
					null_ls.builtins.code_actions.refactoring,
				},
			})
		end,
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
		"chrisgrieser/nvim-scissors",
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
}
