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
		config = function()
			require("harpoon"):setup({
				settings = {
					key = function()
						local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
						local branch = string.gsub(vim.fn.system("git rev-parse --abbrev-ref HEAD"), "\n", "")
						if vim.v.shell_error == 0 then
							return branch .. "-" .. root
						end
						return vim.loop.cwd()
					end,
				},
				default = {
					get_root_dir = function()
						local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
						if vim.v.shell_error == 0 then
							return root
						end
						return vim.loop.cwd()
					end,
					create_list_item = function(config, short_path)
						local root = config.get_root_dir()
						local buf_path = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
						if short_path then
							buf_path = "."
							local prefix = "..."
							local isShortened = string.sub(short_path, 1, #prefix) == prefix
							if not isShortened then
								buf_path = root .. "/" .. short_path
							else
								local searchPath = string.gsub(short_path, "^" .. prefix, "*")
								local command = "find " .. root .. " -path " .. searchPath
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
            { "<leader>a", function() require("harpoon"):list():append() end, desc = "harpoon add file" },
            { "<C-e>", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "harpoon quick menu" },
            { "<C-h>", function() require("harpoon"):list():select(1) end, desc = "harpoon file 1" },
            { "<C-t>", function() require("harpoon"):list():select(2) end, desc = "harpoon file 2" },
            { "<C-n>", function() require("harpoon"):list():select(3) end, desc = "harpoon file 3" },
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
}
