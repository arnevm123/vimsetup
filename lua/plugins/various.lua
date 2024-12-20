return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			zen = { enabled = false },
			words = { enabled = false },
			scroll = { enabled = false },
			indent = { enabled = false },
			animate = { enabled = false },
			notifier = { enabled = false },
			statuscolumn = { enabled = false },

			bigfile = { enabled = true },
			quickfile = { enabled = true },
		},
		keys = {
			{
				"<leader>gb",
				function()
					require("snacks").git.blame_line()
				end,
				desc = "Git Blame Line",
			},
			{
				"<leader>gB",
				function()
					require("snacks").gitbrowse()
				end,
				desc = "Git Browse",
			},
			{
				"<leader>gf",
				function()
					require("snacks").lazygit.log_file()
				end,
				desc = "Lazygit Current File History",
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					require("snacks").toggle.diagnostics():map("yoe")
				end,
			})
		end,
	},
	{
		"chrisgrieser/nvim-various-textobjs",
		event = "UIEnter",
		opts = { keymaps = { useDefaults = true } },
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false, -- set this if you want to always pull the latest change
		opts = {
			provider = "copilot",
			hints = { enabled = false },
			windows = {
				position = "bottom",
				width = 70,
				sidebar_header = { enabled = false },
				-- input = { prefix = "> ", height = 8, },
				edit = { border = "single" },
				ask = { border = "single" },
			},
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			{
				"zbirenbaum/copilot.lua", -- for providers='copilot'
				event = "VeryLazy",
				opts = {
					panel = {
						enabled = true,
						auto_refresh = false,
						keymap = {
							jump_prev = "[[",
							jump_next = "]]",
							accept = "<CR>",
							refresh = "gr",
							open = "<C-CR>",
						},
						layout = {
							position = "top", -- | top | left | right
							ratio = 0.3,
						},
					},
					suggestion = {
						enabled = true,
						auto_trigger = true,
						hide_during_completion = true,
						debounce = 75,
						keymap = {
							accept = "<C-;>",
							accept_word = false,
							accept_line = false,
							next = false,
							prev = false,
							dismiss = "<C-/>",
						},
					},
				},
			},
			"nvim-treesitter/nvim-treesitter",
			{
				"stevearc/dressing.nvim",
				opts = { enabled = false, input = { enabled = false }, select = { enabled = false } },
			},
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			{
				-- Make sure to set this up properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "Avante" },
				},
				ft = { "Avante" },
			},
		},
	},
	{
		"gcmt/vessel.nvim",
		opts = {
			create_commands = true,
			commands = {
				view_marks = "Marks", -- you can customize each command name
				view_jumps = "Jumps",
			},
		},
		keys = {
			{ "<leader>hj", "<Plug>(VesselViewJumps)" },
			{ "<leader>hv", "<plug>(VesselViewMarks)" },
			{ "<leader>hb", "<plug>(VesselViewBufferMarks)" },
			{ "m.", "<plug>(VesselSetGlobalMark)" },
			{ "m,", "<plug>(VesselSetLocalMark)" },
		},
	},
	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		opts = { default_mappings = false },
	},
	{
		"stevearc/quicker.nvim",
		lazy = false,
		opts = {
			keys = {
				{
					"]",
					function()
						require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
					end,
					desc = "Expand quickfix context",
				},
				{
					"[",
					function()
						require("quicker").collapse()
					end,
					desc = "Collapse quickfix context",
				},
			},
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
	-- text manipulation
	{ "tpope/vim-dispatch", event = "VeryLazy" }, -- :Make
	{ "tpope/vim-eunuch", event = "VeryLazy" }, -- :Remove
	{ "wsdjeg/vim-fetch", lazy = false }, -- :e file:line
	{ "kylechui/nvim-surround", config = true, event = "VeryLazy" },
	{ "chrisbra/csv.vim", ft = "csv" },
	{ "pearofducks/ansible-vim", ft = "yaml" },
	{
		"mbbill/undotree",
		config = function()
			vim.cmd([[ let g:undotree_WindowLayout=4 ]])
		end,
		keys = { { "<leader>eu", "<cmd>UndotreeToggle<CR>", desc = "Toggle undo tree" } },
	},
	{ "arnevm123/unimpaired.nvim", config = true, event = "VeryLazy" },
	{
		"amadanmath/diag_ignore.nvim",
		keys = {
			{ "<Leader>ci", "<Plug>(diag_ignore)", mode = "n", desc = "Diagnostic: ignore" },
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
		"mrcjkb/rustaceanvim",
		version = "^4", -- Recommended
		ft = { "rust" },
		config = function()
			vim.g.rustaceanvim = {
				server = {
					on_attach = require("plugins.lsp.handlers").on_attach,
					default_settings = {
						["rust-analyzer"] = require("plugins.lsp.settings.rust_analyzer"),
					},
				},
			}
		end,
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
		"tpope/vim-rsi",
		event = "VeryLazy",
		config = function()
			vim.g.rsi_no_meta = 1
		end,
	},
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = true,
		event = "VeryLazy",
	},
	{
		"kevinhwang91/nvim-bqf",
		dependencies = { "junegunn/fzf" },
		ft = "qf",
		opts = {
			preview = {
				auto_preview = false,
				border = "single",
				show_title = false,
				show_scroll_bar = false,
				winblend = 0,
				win_height = 100,
			},
			filter = {
				fzf = { extra_opts = { "--bind", "ctrl-y:toggle-all" } },
			},
		},
	},
	{
		"Everduin94/nvim-quick-switcher",
		keys = {
        -- stylua: ignore
			{ "<leader>os", function() require("nvim-quick-switcher").find(".service.ts") end, desc = "Go to service" },
        -- stylua: ignore
			{ "<leader>ou", function() require("nvim-quick-switcher").find(".component.ts") end, desc = "Go to TS" },
        -- stylua: ignore
			{ "<leader>oo", function() require("nvim-quick-switcher").find(".component.html") end, desc = "Go to html" },
        -- stylua: ignore
			{ "<leader>op", function() require("nvim-quick-switcher").find(".module.ts") end, desc = "Go to module" },
        -- stylua: ignore
			{ "<leader>ol", function() require("nvim-quick-switcher").find("*util.*") end, desc = "Go to util" },
			{
				"<leader>ow",
				function()
					local toggle_os = function(p)
						local extension = p.file_type
						local path = p.path .. "/"
						local file_name = p.full_prefix
						if string.find(file_name, "linux") ~= nil then
							local pth = path .. string.gsub(file_name, "linux", "windows") .. "." .. extension
							if not io.open(pth, "r") then
								vim.cmd(":e " .. pth)
							end
							return pth
						end
						if string.find(file_name, "windows") ~= nil then
							local pth = path .. string.gsub(file_name, "windows", "linux") .. "." .. extension
							if not io.open(pth, "r") then
								vim.cmd(":e " .. pth)
							end
							return pth
						end
						return path .. file_name
					end
					require("nvim-quick-switcher").find_by_fn(toggle_os)
				end,
				desc = "Go to windows or linux",
			},
			{
				"<leader>ot",
				function()
					local toggle_test = function(p)
						local extension = p.file_type
						local path = p.path .. "/"
						local file_name = p.full_prefix
						if extension == "py" then
							if string.find(file_name, "test") ~= nil then
								return string.gsub(path, "tests/", "")
									.. string.gsub(file_name, "test_", "")
									.. "."
									.. extension
							end
							local test_path = string.gsub(path, "src/", "src/tests/")
								.. "test_"
								.. file_name
								.. "."
								.. extension
							if not io.open(test_path, "r") then
								vim.cmd(":e " .. test_path)
							end
							return test_path
						end
						if extension == "go" then
							-- name contains test -> remove it
							if string.find(file_name, "test") ~= nil then
								return path .. string.gsub(file_name, "_test", "") .. "." .. extension
							end

							-- name does not contain test -> add it
							local test_path = path .. file_name .. "_test." .. extension
							if not io.open(test_path, "r") then
								vim.cmd(":e " .. test_path)
							end
							return test_path
						end
						return path .. file_name
					end
					require("nvim-quick-switcher").find_by_fn(toggle_test)
				end,
				desc = "Go to test",
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
		"johmsalas/text-case.nvim",
		config = function()
			require("textcase").setup({
				substitude_command_name = "S",
			})
		end,
		event = "VeryLazy",
	},
	-- {
	-- 	"supermaven-inc/supermaven-nvim",
	-- 	lazy = false,
	-- 	-- event = "VeryLazy",
	-- 	config = function()
	-- 		require("supermaven-nvim").setup({
	-- 			keymaps = {
	-- 				accept_suggestion = "<C-;>",
	-- 				clear_suggestion = "<C-/>",
	-- 				accept_word = "<C-.>",
	-- 			},
	-- 			color = {
	-- 				suggestion_color = "#6B6B6B",
	-- 				cterm = 244,
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		config = function()
			vim.cmd([[
				function OpenMarkdownPreview (url)
					execute "silent ! firefox --new-window " . a:url
				endfunction
				let g:mkdp_browserfunc = 'OpenMarkdownPreview'
				let g:mkdp_auto_close = 0
            ]])
		end,
		build = function()
			vim.fn["mkdp#util#install"]()
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
		"olexsmir/gopher.nvim",
		ft = { "go", "gomod" },
		branch = "develop",
		config = function()
			require("gopher").setup({
				gotests = { template = "testify" },
				commands = { iferr = "iferr -message 'fmt.Errorf(\"%w\", err)'" },
			})
		end,
		keys = {
			{ "<leader>ee", '0f=llvt("hy:GoIfErr<CR>jf%i<C-r>h: <esc>', desc = "Go if err" },
			{
				"<leader>er",
				function()
					local line = vim.api.nvim_get_current_line()
					if line:match("^%s*if") then
						if string.find(line, ";") then
							vim.api.nvim_feedkeys("^df f;s\x0dif \x1b", "n", true)
							return
						end
						vim.api.nvim_feedkeys("k", "n", true)
					end
					vim.api.nvim_feedkeys("Jcff;\x1bIif \x1b", "n", true)
				end,
				desc = "Go if err join",
			},
			{ "<leader>ew", "^df f;s<CR>if <esc>", desc = "Go if err split" },
			{
				"<leader>en",
				function()
					local var = vim.fn.expand("<cword>")
					vim.api.nvim_input("o" .. "_ = " .. var .. "<esc>^")
				end,
				desc = "Go empty assign",
			},
		},
	},
}
