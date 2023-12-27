return {
	-- text manipulation
	{ "tpope/vim-dispatch", cmd = { "Make", "Dispatch" } },
	{ "tpope/vim-eunuch", cmd = { "Remove", "Delete", "Move", "Chmod", "Mkdir", "Cfind", "SudoWrite", "SudoEdit" } },
	{ "wsdjeg/vim-fetch", lazy = false }, -- :e with line numpers
	{ "wellle/targets.vim", event = "BufEnter" }, -- better cib
	{ "numToStr/Comment.nvim", config = true, keys = { "gc", "gb", { "gc", mode = "x" }, { "gb", mode = "x" } } },
	{ "kylechui/nvim-surround", config = true, keys = { "ds", "cs", "ys", { "S", mode = "v" }, { "gS", mode = "v" } } },
	{ "brenoprata10/nvim-highlight-colors", config = true, cmd = { "HighlightColorsOn" } },
	{ "chrisbra/csv.vim", ft = "csv" },
	{ "pearofducks/ansible-vim", ft = "yaml" },
	{ "mbbill/undotree", keys = { { "<leader>eu", ":UndotreeToggle<CR>", desc = "Toggle undo tree" } } },
	{ "arnevm123/unimpaired.nvim", config = true, keys = { "[", "]", "yo" } },
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = {
			default_mappings = {
				ours = "<leader>zo",
				theirs = "<leader>zt",
				none = "<leader>zn",
				both = "<leader>zb",
				next = "]z",
				prev = "[z",
			},
		},
		lazy = false,
	},
	{
		"toppair/peek.nvim",
		cmd = { "Peek" },
		build = "deno task --quiet build:fast",
		config = function()
			require("peek").setup()
			vim.api.nvim_create_user_command("Peek", function()
				local peek = require("peek")
				if peek.is_open() then
					peek.close()
				else
					peek.open()
				end
			end, {})
		end,
	},
	{
		"kevinhwang91/nvim-bqf",
		dependencies = { "junegunn/fzf" },
		ft = "qf",
		opts = {
			preview = { auto_preview = false },
			filter = {
				fzf = {
					action_for = { ["ctrl-s"] = "split", ["ctrl-t"] = "tab drop" },
					extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
				},
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
				"<leader>ot",
				function()
					local toggle_test = function(p)
						local extension = p.file_type
						local path = p.path .. "/"
						local file_name = p.full_prefix
						if extension == "go" then
							if string.find(file_name, "test") ~= nil then
								return path .. string.gsub(file_name, "_test", "") .. "." .. extension
							end
							local test_path = path .. file_name .. "_test." .. extension
							if not io.open(test_path, "r") then
								io.open(test_path, "w"):close()
							end
							return test_path
						end
						return path .. file_name
					end
					require("nvim-quick-switcher").find_by_fn(toggle_test)
				end,
				desc = "Go to service",
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
		keys = {
			{ "ga" },
			{ "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "v" } },
		},
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		config = function()
			require("harpoon"):setup({
				settings = {
					key = function()
						local root = require("base.utils").git_cwd({})
						local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD")
						if vim.v.shell_error == 0 and branch then
							return string.gsub(branch, "\n", "") .. "-" .. root
						end
						return root
					end,
				},
				default = {
					get_root_dir = require("base.utils").git_cwd,
					create_list_item = function(config, short_path)
						local root = config.get_root_dir()
						local buf_path = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
						if buf_path == "" then
							buf_path = root
						end
						if short_path then
							buf_path = "."
							if vim.fn.filereadable(root .. "/" .. short_path) == 1 then
								buf_path = root .. "/" .. short_path
							else
								local prefix = "..."
								local isShortened = string.sub(short_path, 1, #prefix) == prefix
								if isShortened then
									short_path = string.sub(short_path, #prefix + 1)
								end
								local search_path =
									string.gsub(short_path, "^%.{3}", ""):gsub("/", ".*"):gsub(" ", ".*")
								local command = "fd -p " .. search_path .. " " .. root
								local handle = io.popen(command)
								if handle ~= nil then
									local result = handle:read("*l")
									handle:close()
									if result then
										buf_path = result
									end
								end
							end
						end
						short_path = require("plenary.path"):new(buf_path):normalize(root)
						local bufnr = vim.fn.bufnr(short_path, false)
						local pos = { 1, 0 }
						if bufnr ~= -1 then
							pos = vim.api.nvim_win_get_cursor(0)
						end
						return {
							value = buf_path,
							context = { row = pos[1], col = pos[2], name = short_path },
						}
					end,
					display = function(item)
						local t = {}
						local str = item.context.name
						for s in string.gmatch(str, "([^" .. "/" .. "]+)") do
							table.insert(t, s)
						end
						if #t <= 5 then
							return str
						end
						return ".../" .. t[#t - 3] .. "/" .. t[#t - 2] .. "/" .. t[#t - 1] .. "/" .. t[#t]
					end,
				},
			})
		end,
		event = "BufEnter",
		--stylua: ignore
		keys = {
            { "<leader>aa", function() require("harpoon"):list():append() end, desc = "harpoon add file" },
            { "<leader>as", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "harpoon quick menu" },
            { "<C-h>", function() require("harpoon"):list():select(1) end, desc = "harpoon file 1" },
            { "<C-j>", function() require("harpoon"):list():select(2) end, desc = "harpoon file 2" },
            { "<C-k>", function() require("harpoon"):list():select(3) end, desc = "harpoon file 3" },
            { "<C-s>", function() require("harpoon"):list():select(4) end, desc = "harpoon file 4" },
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
			-- vim.g.codeium_manual = true
		end,
		event = "BufReadPost",
	},
	{
		"harrisoncramer/gitlab.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			enabled = true,
		},
		build = function()
			require("gitlab.server").build(true)
		end, -- Builds the Go binary
		config = function()
			require("gitlab").setup()
		end,
		lazy = false,
	},
	{
		"kevinhwang91/nvim-fundo",
		dependencies = "kevinhwang91/promise-async",
		run = function()
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
                if system('pgrep firefox') > 0
                  execute "silent ! firefox --new-window " . a:url
                else
                  execute "silent ! firefox & firefox " . a:url
                endif
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
				go = { 'fmt.Printf("%s %%v \\n", %s)' },
			},
		},
		keys = {
			{
				"<leader>rr",
				function()
					require("refactoring").select_refactor({})
				end,
				mode = { "n", "x" },
				desc = "refactor",
			},
			{
				"<leader>rp",
				function()
					require("refactoring").debug.print_var({})
				end,
				mode = { "x", "n" },
				desc = "refactor print",
			},
			{
				"<leader>rc",
				function()
					require("refactoring").debug.cleanup({})
				end,
				mode = { "x", "n" },
				desc = "refactor cleanup",
			},
		},
	},
	{
		"dzfrias/arena.nvim",
		event = "BufWinEnter",
		opts = {
			max_items = 5,
			always_context = {
				"mod.rs",
				"init.lua",
			},
			ignore_current = false,
			buf_opts = { ["relativenumber"] = false },
			window = { height = 15 },
			per_project = true,
		},
		keys = { { "<leader>af", ":lua require('arena').toggle()<CR>", desc = "Arena" } },
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
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			key_labels = { ["<space>"] = "SPC", ["<cr>"] = "RET", ["<tab>"] = "TAB" },
			icons = { separator = ">" },
			triggers = { "g", "'", '"', "z" },
			triggers_nowait = { "'", "ga", "g`", "g'", '"', "z=" },
		},
	},
	{
		"piersolenski/wtf.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		opts = {},
		keys = {
			{ "gw", ":lua require('wtf').search()<CR>", desc = "Search diagnostic with Google" },
		},
	},
}
