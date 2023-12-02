return {
	-- text manipulation
	{ "tpope/vim-dispatch", cmd = { "Make", "Dispatch" } },
	{ "lambdalisue/suda.vim", cmd = { "SudaRead", "SudaWrite" } },
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
		"tpope/vim-rsi",
		event = "BufEnter",
		config = function()
			vim.g.rsi_no_meta = 1
		end,
	},
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
		--stylua: ignore
		keys = {
			{ "<leader>os", function() require("nvim-quick-switcher").find(".service.ts") end, desc = "Go to service" },
			{ "<leader>ou", function() require("nvim-quick-switcher").find(".component.ts") end, desc = "Go to TS" },
			{ "<leader>oo", function() require("nvim-quick-switcher").find(".component.html") end, desc = "Go to html" },
			{ "<leader>op", function() require("nvim-quick-switcher").find(".module.ts") end, desc = "Go to module" },
			{ "<leader>ol", function() require("nvim-quick-switcher").find("*util.*") end, desc = "Go to util" },
			{
				"<leader>oi",
				function() require("nvim-quick-switcher").find(".+css|.+scss|.+sass", { regex = true, prefix = "full" }) end,
				desc = "Go to stylesheet",
			},
		},
	},
	{
		"ThePrimeagen/harpoon",
		opts = {
			save_on_toggle = false,
			save_on_change = true,
			enter_on_sendcmd = true,
			tmux_autoclose_windows = false,
			excluded_filetypes = { "harpoon" },
			mark_branch = true,
		},
		event = "BufEnter",
		--stylua: ignore
		keys = {
			{ "<leader>a", function() require("harpoon.mark").add_file() end, desc = "harpoon add file" },
			{
				"<leader>A",
				function()
					require("harpoon.ui").toggle_quick_menu()
					vim.cmd.norm("$ze")
				end,
				desc = "harpoon quick menu",
			},
			{ "<C-h>", function() require("harpoon.ui").nav_file(1) end, desc = "harpoon file 1" },
			{ "<C-j>", function() require("harpoon.ui").nav_file(2) end, desc = "harpoon file 2" },
			{ "<C-k>", function() require("harpoon.ui").nav_file(3) end, desc = "harpoon file 3" },
			{ "<C-l>", function() require("harpoon.ui").nav_file(4) end, desc = "harpoon file 4" },
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
}
