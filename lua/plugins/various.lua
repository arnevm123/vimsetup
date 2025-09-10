return {
	{ "nvim-tree/nvim-web-devicons", opts = { color_icons = false } },
	{ "catgoose/nvim-colorizer.lua", event = "VeryLazy", opts = { lazy_load = true } },
	{ "nanotee/sqls.nvim", lazy = false },
	{ "typicode/bg.nvim", lazy = false }, -- Sync bg colors between nvim and terminal
	{ "tpope/vim-eunuch", event = "VeryLazy" }, -- :Remove
	{ "tpope/vim-dispatch", event = "VeryLazy" }, -- :Make
	{ "wsdjeg/vim-fetch", lazy = false }, -- :e file:line
	{ "akinsho/git-conflict.nvim", config = true, event = "VeryLazy" },
	{ "chrisbra/csv.vim", ft = "csv" },
	{ "pearofducks/ansible-vim", ft = "yaml" },
	{ "chentoast/marks.nvim", event = "VeryLazy", opts = { default_mappings = false } },
	{ "mbbill/undotree", event = "VeryLazy", keys = { { "<leader>eu", "<cmd>UndotreeToggle<CR>" } } },
	{
		"johmsalas/text-case.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("textcase").setup({ substitude_command_name = "S", default_keymappings_enabled = false })
			require("telescope").load_extension("textcase")
		end,
		keys = {
			-- { "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope" },
			{ "ga.", "<cmd>lua require('base.utils').try_lsp_rename()<CR>", mode = { "n", "x" } },
			{ "gau", "<cmd>lua require('base.utils').try_lsp_rename('to_constant_case')<CR>", mode = { "n", "x" } },
			{ "gas", "<cmd>lua require('base.utils').try_lsp_rename('to_snake_case')<CR>", mode = { "n", "x" } },
			{ "gad", "<cmd>lua require('base.utils').try_lsp_rename('to_dash_case')<CR>", mode = { "n", "x" } },
			{ "gac", "<cmd>lua require('base.utils').try_lsp_rename('to_camel_case')<CR>", mode = { "n", "x" } },
			{ "gap", "<cmd>lua require('base.utils').try_lsp_rename('to_pascal_case')<CR>", mode = { "n", "x" } },
		},
		event = "VeryLazy",
	},
	{
		"mcauley-penney/visual-whitespace.nvim",
		event = "ModeChanged *:[vV\22]",
		opts = { fileformat_chars = { unix = "" } },
	},
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
	{
		"lambdalisue/vim-suda",
		lazy = false,
	},
	{
		"ej-shafran/compile-mode.nvim",
		event = "VeryLazy",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "m00qek/baleia.nvim", tag = "v1.3.0" },
		},
		config = function()
			local function get_build_root()
				local ok, clients = pcall(vim.lsp.get_clients)
				if not ok or not clients or #clients == 0 then
					return nil
				end
				local root = clients[1].config and clients[1].config.cmd_cwd
				if root and vim.fn.isdirectory(root) == 1 then
					return root
				end
				return nil
			end

			local function run_compile(cmd)
				vim.g.compilation_directory = get_build_root()
				if not cmd then
					vim.cmd("below 15 Compile")
				elseif cmd == "recompile" then
					vim.cmd("below 15 Recompile")
				else
					vim.cmd("below 15 Compile " .. cmd)
				end
			end

			-- Keymaps
			local nosilent = { noremap = true }
			local opts = { noremap = true, silent = true }
			local keymap = vim.keymap.set
			keymap("n", "<leader>bu", function()
				run_compile("make build")
			end, nosilent)
			keymap("n", "<leader>bt", function()
				run_compile("make test")
			end, nosilent)
			keymap("n", "<leader>bl", function()
				run_compile("make lint")
			end, nosilent)
			keymap("n", "<leader>bg", function()
				run_compile()
			end, nosilent)
			keymap("n", "<leader>br", function()
				run_compile("LOG_LEVEL=trace make run")
			end, nosilent)
			keymap("n", "<leader>be", function()
				run_compile("recompile")
			end, nosilent)

			-- Other keymaps
			keymap("n", "<leader>bn", ":lua require('compile-mode').next_error()<CR>", opts)
			keymap("n", "<leader>bp", ":lua require('compile-mode').prev_error()<CR>", opts)
			keymap("n", "<leader>bd", ":silent! execute 'bdelete' bufname('*compilation*')<CR>", opts)
			keymap(
				"n",
				"<leader>bq",
				":silent! execute 'bdelete' bufname('*compilation*')<CR>:QuickfixErrors<CR>",
				opts
			)
			---@module "compile-mode"
			---@type CompileModeOpts
			vim.g.compile_mode = {
				default_command = "",
				baleia_setup = true,
				bang_expansion = true,
				error_ignore_file_list = { "Makefile$", "makefile$", "GNUmakefile$" },
				hidden_output = "\\v^(\\d{2}-\\d{2}-\\d{4} )",
				error_regexp_table = {
					go_logs = {
						regex = "\\v.*\\[(.+):([0-9]+)\\]",
						filename = 1,
						row = 2,
					},
				},
				focus_compilation_buffer = true,
			}
		end,
	},
}
