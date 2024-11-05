return {
	{
		{ "meznaric/key-analyzer.nvim", opts = {}, cmd = "KeyAnalyzer" },
	},
	{
		"chrisgrieser/nvim-various-textobjs",
		event = "UIEnter",
		opts = { useDefaultKeymaps = true },
	},
	{
		"keaising/textobj-backtick.nvim",
		event = "UIEnter",
		config = true,
	},
	-- {
	-- 	"yetone/avante.nvim",
	-- 	event = "VeryLazy",
	-- 	lazy = false,
	-- 	version = false, -- set this if you want to always pull the latest change
	-- 	opts = {
	-- 		hints = { enabled = true },
	-- 	},
	-- 	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	-- 	build = "make",
	-- 	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		{
	-- 			"stevearc/dressing.nvim",
	-- 			opts = {
	-- 				input = { enabled = true },
	-- 				select = { enabled = true },
	-- 			},
	-- 		},
	-- 		"nvim-lua/plenary.nvim",
	-- 		"MunifTanjim/nui.nvim",
	-- 		{
	-- 			-- Make sure to set this up properly if you have lazy=true
	-- 			"MeanderingProgrammer/render-markdown.nvim",
	-- 			opts = {
	-- 				file_types = { "Avante" },
	-- 			},
	-- 			ft = { "Avante" },
	-- 		},
	-- 	},
	-- },
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
		opts = {
			default_mappings = false,
		},
	},
	{
		"https://gitlab.com/itaranto/preview.nvim",
		version = "*",
		opts = {
			{
				previewers_by_ft = {
					markdown = {
						name = "pandoc_wkhtmltopdf",
						renderer = { type = "command", opts = { cmd = { "zathura" } } },
					},
					plantuml = {
						name = "plantuml_svg",
						renderer = { type = "imv" },
					},
					groff = {
						name = "groff_ms_pdf",
						renderer = { type = "command", opts = { cmd = { "zathura" } } },
					},
				},
				render_on_write = true,
			},
		},
		cmd = { "PreviewFile" },
	},
	{
		"GustavEikaas/code-playground.nvim",
		config = function()
			require("code-playground").setup()
		end,
		cmd = {
			"Code",
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			---@type false | "classic" | "modern" | "helix"
			preset = "classic",
			-- Delay before showing the popup. Can be a number or a function that returns a number.
			---@type number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
			delay = function(ctx)
				return ctx.plugin and 0 or 200
			end,
			---@param mapping wk.Mapping
			filter = function(mapping)
				-- example to exclude mappings without a description
				-- return mapping.desc and mapping.desc ~= ""
				return true
			end,
			--- You can add any mappings here, or use `require('which-key').add()` later
			---@type wk.Spec
			spec = {},
			-- show a warning when issues were detected with your mappings
			notify = true,
			-- Which-key automatically sets up triggers for your mappings.
			-- But you can disable this and setup the triggers manually.
			-- Check the docs for more info.
			---@type wk.Spec
			triggers = {
				{ "<auto>", mode = "nxso" },
			},
			-- Start hidden and wait for a key to be pressed before showing the popup
			-- Only used by enabled xo mapping modes.
			---@param ctx { mode: string, operator: string }
			defer = function(ctx)
				return ctx.mode == "V" or ctx.mode == "<C-V>"
			end,
			plugins = {
				marks = true, -- shows a list of your marks on ' and `
				registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
				-- the presets plugin, adds help for a bunch of default keybindings in Neovim
				-- No actual key bindings are created
				spelling = {
					enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
					suggestions = 20, -- how many suggestions should be shown in the list?
				},
				presets = {
					operators = false, -- adds help for operators like d, y, ...
					motions = false, -- adds help for motions
					text_objects = false, -- help for text objects triggered after entering an operator
					windows = true, -- default bindings on <c-w>
					nav = true, -- misc bindings to work with windows
					z = true, -- bindings for folds, spelling and others prefixed with z
					g = true, -- bindings for prefixed with g
				},
			},
			---@type wk.Win.opts
			win = {
				-- don't allow the popup to overlap with the cursor
				no_overlap = true,
				-- width = 1,
				-- height = { min = 4, max = 25 },
				-- col = 0,
				-- row = math.huge,
				-- border = "none",
				padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
				title = true,
				title_pos = "center",
				zindex = 1000,
				-- Additional vim.wo and vim.bo options
				bo = {},
				wo = {
					-- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
				},
			},
			layout = {
				width = { min = 20 }, -- min and max width of the columns
				spacing = 3, -- spacing between columns
			},
			keys = {
				scroll_down = "<c-d>", -- binding to scroll down inside the popup
				scroll_up = "<c-u>", -- binding to scroll up inside the popup
			},
			---@type (string|wk.Sorter)[]
			--- Mappings are sorted using configured sorters and natural sort of the keys
			--- Available sorters:
			--- * local: buffer-local mappings first
			--- * order: order of the items (Used by plugins like marks / registers)
			--- * group: groups last
			--- * alphanum: alpha-numerical first
			--- * mod: special modifier keys last
			--- * manual: the order the mappings were added
			--- * case: lower-case first
			sort = { "local", "order", "group", "alphanum", "mod" },
			---@type number|fun(node: wk.Node):boolean?
			expand = 0, -- expand groups when <= n mappings
			-- expand = function(node)
			--   return not node.desc -- expand all nodes without a description
			-- end,
			-- Functions/Lua Patterns for formatting the labels
			---@type table<string, ({[1]:string, [2]:string}|fun(str:string):string)[]>
			replace = {
				key = {
					function(key)
						return require("which-key.view").format(key)
					end,
					-- { "<Space>", "SPC" },
				},
				desc = {
					{ "<Plug>%(?(.*)%)?", "%1" },
					{ "^%+", "" },
					{ "<[cC]md>", "" },
					{ "<[cC][rR]>", "" },
					{ "<[sS]ilent>", "" },
					{ "^lua%s+", "" },
					{ "^call%s+", "" },
					{ "^:%s*", "" },
				},
			},
			icons = {
				breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
				separator = "➜", -- symbol used between a key and it's label
				group = "+", -- symbol prepended to a group
				ellipsis = "…",
				-- set to false to disable all mapping icons,
				-- both those explicitly added in a mapping
				-- and those from rules
				mappings = true,
				--- See `lua/which-key/icons.lua` for more details
				--- Set to `false` to disable keymap icons from rules
				---@type wk.IconRule[]|false
				rules = {},
				-- use the highlights from mini.icons
				-- When `false`, it will use `WhichKeyIcon` instead
				colors = true,
				-- used by key format
				keys = {
					Up = " ",
					Down = " ",
					Left = " ",
					Right = " ",
					C = "󰘴 ",
					M = "󰘵 ",
					D = "󰘳 ",
					S = "󰘶 ",
					CR = "󰌑 ",
					Esc = "󱊷 ",
					ScrollWheelDown = "󱕐 ",
					ScrollWheelUp = "󱕑 ",
					NL = "󰌑 ",
					BS = "BS",
					Space = "󱁐 ",
					Tab = "󰌒 ",
					F1 = "󱊫",
					F2 = "󱊬",
					F3 = "󱊭",
					F4 = "󱊮",
					F5 = "󱊯",
					F6 = "󱊰",
					F7 = "󱊱",
					F8 = "󱊲",
					F9 = "󱊳",
					F10 = "󱊴",
					F11 = "󱊵",
					F12 = "󱊶",
				},
			},
			show_help = true, -- show a help message in the command line for using WhichKey
			show_keys = true, -- show the currently pressed key and its label as a message in the command line
			-- disable WhichKey for certain buf types and file types.
			disable = {
				ft = {},
				bt = {},
			},
			debug = false, -- enable wk.log in the current directory
		},
	},
	{
		"jinh0/eyeliner.nvim",
		keys = { "f", "F", "t", "T" },
		config = function()
			require("eyeliner").setup({
				-- show highlights only after keypress
				highlight_on_key = true,

				-- dim all other characters if set to true (recommended!)
				dim = false,

				-- set the maximum number of characters eyeliner.nvim will check from
				-- your current cursor position; this is useful if you are dealing with
				-- large files: see https://github.com/jinh0/eyeliner.nvim/issues/41
				max_length = 9999,

				-- add eyeliner to f/F/t/T keymaps;
				-- see section on advanced configuration for more information
				default_keymaps = true,
			})
		end,
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
	{
		"tpope/vim-capslock",
		keys = { { "<C-g>c", mode = "i" }, { "gC", mode = "n" } },
	},

	{ "wsdjeg/vim-fetch", lazy = false }, -- :e file:line
	-- { "wellle/targets.vim", event = "VeryLazy" }, -- better cib
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
	-- {
	-- 	"sourcegraph/sg.nvim",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 	},
	-- 	keys = {
	-- 		{ "<leader>cc", "<cmd>CodyToggle<CR>", mode = { "n", "v" }, desc = "Toggle Cody chat window" },
	-- 		{ "<leader>cq", ":CodyAsk ", mode = { "n", "v" }, desc = "Ask Cody a question" },
	-- 		{ "<leader>ct", ":CodyTask ", mode = { "n", "v" }, desc = "Create a new Cody task" },
	-- 		{ "<leader>cp", "<cmd>CodyTaskPrevious<CR>", mode = { "n", "v" }, desc = "Go to previous Cody task" },
	-- 		{ "<leader>cn", "<cmd>CodyTaskNext<CR>", mode = { "n", "v" }, desc = "Go to next Cody task" },
	-- 		{ "<leader>ca", "<cmd>CodyTaskAccept<CR>", mode = { "n", "v" }, desc = "Accept current Cody task" },
	-- 	},
	-- 	config = true,
	-- 	build = "nvim -l build/init.lua",
	-- 	event = "VimEnter",
	-- },
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
	-- {
	-- 	"Exafunction/codeium.vim",
	-- 	--stylua: ignore
	-- 	--selene: allow(multiple_statements)
	-- 	config = function()
	-- 		vim.keymap.set("i", "<C-.>", function() return vim.fn["codeium#Accept"]() end, { expr = true })
	-- 		vim.keymap.set("i", "<C-;>", function() return vim.fn["codeium#Complete"]() end, { expr = true })
	-- 		vim.keymap.set("i", "<C-,>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true })
	-- 		vim.g.codeium_filetypes = { telescope = false }
	-- 		vim.g.codeium_manual = true
	-- 	end,
	-- 	event = "VeryLazy",
	-- },
	-- {
	-- 	"monkoose/neocodeium",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		local neocodeium = require("neocodeium")
	-- 		neocodeium.setup({
	-- 			filetypes = {
	-- 				TelescopePrompt = false,
	-- 				["dap-repl"] = false,
	-- 			},
	-- 		})
	-- 		vim.keymap.set("i", "<C-;>", function()
	-- 			require("neocodeium").accept()
	-- 		end)
	-- 		vim.keymap.set("i", "<c-.>", function()
	-- 			require("neocodeium").cycle_or_complete()
	-- 		end)
	-- 		vim.keymap.set("i", "<C-,>", function()
	-- 			require("neocodeium").cycle_or_complete(-1)
	-- 		end)
	-- 		vim.keymap.set("i", "<C-/>", function()
	-- 			require("neocodeium").clear()
	-- 		end)
	-- 	end,
	-- },
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
	-- {
	-- 	"OXY2DEV/markview.nvim",
	-- 	ft = "markdown"
	-- },
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
