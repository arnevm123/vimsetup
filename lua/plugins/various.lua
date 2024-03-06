return {
	-- text manipulation
	{ "tpope/vim-dispatch", event = "VeryLazy" },
	{ "tpope/vim-eunuch", event = "VeryLazy" },
	{ "szw/vim-maximizer", keys = { { "<C-w>z", ":MaximizerToggle<CR>", desc = "Toggle maximizer" } } },
	{ "gpanders/editorconfig.nvim", event = "VeryLazy" },
	{ "wsdjeg/vim-fetch", lazy = false },
	{ "wellle/targets.vim", event = "VeryLazy" }, -- better cib
	{ "kylechui/nvim-surround", config = true, event = "VeryLazy" },
	{ "brenoprata10/nvim-highlight-colors", opts = { render = "virtual" }, config = true, event = { "VeryLazy" } },
	{ "chrisbra/csv.vim", ft = "csv" },
	{ "pearofducks/ansible-vim", ft = "yaml" },
	{ "mbbill/undotree", keys = { { "<leader>eu", ":UndotreeToggle<CR>", desc = "Toggle undo tree" } } },
	{ "arnevm123/unimpaired.nvim", config = true, event = "VeryLazy" },
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
		"laytan/cloak.nvim",
		config = function()
			require("cloak").setup({
				enabled = true,
				cloak_character = "*",
				-- The applied highlight group (colors) on the cloaking, see `:h highlight`.
				highlight_group = "Comment",
				patterns = {
					{
						-- Match any file starting with ".env".
						-- This can be a table to match multiple file patterns.
						file_pattern = {
							".env*",
							"wrangler.toml",
							".dev.vars",
							"tcit_vpn.conf",
						},
						-- Match an equals sign and any character after it.
						-- This can also be a table of patterns to cloak,
						-- example: cloak_pattern = { ":.+", "-.+" } for yaml files.
						cloak_pattern = { "=.+", "= .+" },
					},
				},
			})
		end,
		lazy = false,
	},
	{
		"sourcegraph/sg.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>cc", ":CodyToggle<CR>", mode = { "n", "v" }, desc = "Toggle Cody chat window" },
			{ "<leader>cq", ":CodyAsk ", mode = { "n", "v" }, desc = "Ask Cody a question" },
			{ "<leader>ct", ":CodyTask ", mode = { "n", "v" }, desc = "Create a new Cody task" },
			{ "<leader>cp", ":CodyTaskPrevious<CR>", mode = { "n", "v" }, desc = "Go to previous Cody task" },
			{ "<leader>cn", ":CodyTaskNext<CR>", mode = { "n", "v" }, desc = "Go to next Cody task" },
			{ "<leader>ca", ":CodyTaskAccept<CR>", mode = { "n", "v" }, desc = "Accept current Cody task" },
		},
		config = true,
		build = "nvim -l build/init.lua",
		event = "VimEnter",
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
		config = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "GitConflictDetected",
				callback = function()
					vim.notify("Conflict detected in " .. vim.fn.expand("<afile>"))
					vim.keymap.set("n", "cww", function()
						engage.conflict_buster()
						create_buffer_local_mappings()
					end)
				end,
			})
		end,
		event = "VeryLazy",
	},
	{
		"kevinhwang91/nvim-bqf",
		dependencies = { "junegunn/fzf" },
		ft = "qf",
		opts = {
			preview = { auto_preview = false },
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
		"Exafunction/codeium.vim",
		--stylua: ignore
		--selene: allow(multiple_statements)
		config = function()
			vim.keymap.set("i", "<C-.>", function() return vim.fn["codeium#Accept"]() end, { expr = true })
			vim.keymap.set("i", "<C-;>", function() return vim.fn["codeium#Complete"]() end, { expr = true })
            vim.keymap.set("i", "<C-,>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true })
			vim.g.codeium_filetypes = { telescope = false }
			vim.g.codeium_manual = true
		end,
		event = "VeryLazy",
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
			{ "<space>ej", ":lua require('treesj').join()<CR>", desc = "Join lines" },
			{ "<space>ek", ":lua require('treesj').split()<CR>", desc = "Split lines" },
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
				commands = { iferr = "iferr -message 'fmt.Errorf(\"failed to %w\", err)'" },
			})
		end,
		keys = {
			{ "<leader>ee", ":GoIfErr<CR>jf%", desc = "Go if err" },
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
