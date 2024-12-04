return {
	{ "nvzone/typr", dependencies = { "nvzone/volt" }, cmd = { "Typr", "TyprStats" } },
	{
		"claydugo/browsher.nvim",
		event = "VeryLazy",
		config = function()
			-- Specify empty to use below default options
			require("browsher").setup({
				providers = {
					["gitlab.telecom%-it.be"] = {
						url_template = "%s/-/blob/%s/%s",
						single_line_format = "#L%d",
						multi_line_format = "#L%d-%d",
					},
				},
			})
		end,
	},
	{
		"folke/twilight.nvim",
		opts = {},
		event = "VeryLazy",
	},
	{
		"kelvinauta/focushere.nvim",
		event = "VeryLazy",
		config = function()
			require("focushere").setup()
			-- Optional KeyMap
			vim.keymap.set("v", "zf", ":FocusHere<CR>", { noremap = true, silent = true })
			vim.keymap.set("n", "zf", ":FocusClear<CR>", { noremap = true, silent = true })
		end,
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			notifier = { enabled = false },
			quickfile = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = false },
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
			{
				"<leader>N",
				desc = "Neovim News",
				function()
					require("snacks").win({
						file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
						width = 0.6,
						height = 0.6,
						wo = {
							spell = false,
							wrap = false,
							signcolumn = "yes",
							statuscolumn = " ",
							conceallevel = 3,
						},
					})
				end,
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
		"oysandvik94/curl.nvim",
		cmd = { "CurlOpen" },
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			open_with = "tab",
		},
	},
	{ "meznaric/key-analyzer.nvim", opts = {}, cmd = "KeyAnalyzer" },
	{
		"chrisgrieser/nvim-various-textobjs",
		event = "UIEnter",
		opts = { useDefaultKeymaps = true },
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false, -- set this if you want to always pull the latest change
		opts = {
			hints = { enabled = true },
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			{
				"stevearc/dressing.nvim",
				opts = {
					input = { enabled = true },
					select = { enabled = true },
				},
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
	{
		"maxandron/goplements.nvim",
		config = function()
			local goplements = require("goplements")
			---@diagnostic disable-next-line: missing-fields
			goplements.setup({
				prefix = {
					interface = "󰘧 ",
					struct = "󰡱 ",
				},
				display_package = true,
			})

			local enabled = false
			vim.api.nvim_create_user_command("GoIpmlToggle", function()
				if enabled then
					enabled = false
					goplements.disable()
				else
					enabled = true
					goplements.enable()
				end
			end, {})
		end,
		keys = {
			{ "yop", "<cmd>GoIpmlToggle<CR>", desc = "Toggle Goplements" },
		},
	},
	{
		"chrisgrieser/nvim-lsp-endhints",
		opts = {
			icons = {
				type = "",
				parameter = "",
			},
		},
		keys = {
			{
				"yoi",
				"<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>",
				desc = "Toggle inlay hints",
			},
		},
	},
	-- {
	-- 	"kndndrj/nvim-dbee",
	-- 	dependencies = {
	-- 		"MunifTanjim/nui.nvim",
	-- 	},
	-- 	lazy = false,
	-- 	build = function()
	-- 		-- Install tries to automatically detect the install method.
	-- 		-- if it fails, try calling it with one of these parameters:
	-- 		--    "curl", "wget", "bitsadmin", "go"
	-- 		require("dbee").install()
	-- 	end,
	-- 	config = function()
	-- 		require("dbee").setup({
	-- 			sources = {
	-- 				require("dbee.sources").FileSource:new(vim.fn.stdpath("config") .. "/.db_connections/dbee.json"),
	-- 			},
	-- 		})
	-- 	end,
	-- },
	-- text manipulation
	{ "tpope/vim-dispatch", event = "VeryLazy" }, -- :Make
	{ "tpope/vim-eunuch", event = "VeryLazy" }, -- :Remove
	{ "tpope/vim-tbone", event = "VeryLazy" }, -- :Remove
	{ "wsdjeg/vim-fetch", lazy = false }, -- :e file:line
	{ "kylechui/nvim-surround", config = true, event = "VeryLazy" },
	{ "brenoprata10/nvim-highlight-colors", opts = { render = "virtual" }, config = true, event = { "VeryLazy" } },
	{ "chrisbra/csv.vim", ft = "csv" },
	{ "pearofducks/ansible-vim", ft = "yaml" },
	{
		"mbbill/undotree",
		config = function()
			vim.cmd([[
				let g:undotree_WindowLayout=4
            ]])
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
		opts = {
			default_mappings = {
				ours = "<leader>zo",
				theirs = "<leader>zt",
				none = "<leader>zn",
				both = "<leader>zb",
				next = "]z",
				prev = "[z",
			},
		},
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
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("textcase").setup({
				substitude_command_name = "S",
			})
			require("telescope").load_extension("textcase")
		end,
		event = "VeryLazy",
		keys = {
			{ "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "v" } },
		},
	},
	{
		"supermaven-inc/supermaven-nvim",
		lazy = false,
		-- event = "VeryLazy",
		config = function()
			require("supermaven-nvim").setup({
				keymaps = {
					accept_suggestion = "<C-;>",
					clear_suggestion = "<C-/>",
					accept_word = "<C-.>",
				},
				color = {
					suggestion_color = "#6B6B6B",
					cterm = 244,
				},
			})
		end,
	},
	{
		"kevinhwang91/nvim-fundo",
		dependencies = "kevinhwang91/promise-async",
		build = function()
			require("fundo").install()
		end,
		config = function()
			vim.o.undofile = true
			require("fundo").setup()
		end,
		lazy = false,
	},
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
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		event = "BufEnter",
		opts = {
			print_var_statements = {
				go = { 'log.Info("%s %%v \\n", spew.Sdump(%s))' },
				cs = { 'Logger.Error($"%s {%s}");' },
			},
		},
		keys = {
			{
				"<leader>rr",
				function()
					require("refactoring"):select_refactor()
				end,
				mode = { "n", "x" },
				desc = "refactor",
			},
			{
				"<leader>rp",
				function()
					require("refactoring").debug:print_var()
				end,
				mode = { "x", "n" },
				desc = "refactor print",
			},
			{
				"<leader>rc",
				function()
					require("refactoring").debug:cleanup()
				end,
				mode = { "x", "n" },
				desc = "refactor cleanup",
			},
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
