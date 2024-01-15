return {
	-- text manipulation
	{ "tpope/vim-dispatch", event = "VeryLazy" },
	{ "tpope/vim-eunuch", event = "VeryLazy" },
	{ "wsdjeg/vim-fetch", event = "VeryLazy" }, -- :e with line numpers
	{ "wellle/targets.vim", event = "VeryLazy" }, -- better cib
	{ "numToStr/Comment.nvim", config = true, event = "VeryLazy" },
	{ "kylechui/nvim-surround", config = true, event = "VeryLazy" },
	{ "duane9/nvim-rg", cmd = { "Rg" } },
	{ "brenoprata10/nvim-highlight-colors", config = true, cmd = { "HighlightColorsOn" } },
	{ "chrisbra/csv.vim", ft = "csv" },
	{ "pearofducks/ansible-vim", ft = "yaml" },
	{ "mbbill/undotree", keys = { { "<leader>eu", ":UndotreeToggle<CR>", desc = "Toggle undo tree" } } },
	{ "arnevm123/unimpaired.nvim", config = true, event = "VeryLazy" },
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
	-- {
	-- 	"toppair/peek.nvim",
	-- 	cmd = { "Peek" },
	-- 	build = "deno task --quiet build:fast",
	-- 	config = function()
	-- 		require("peek").setup()
	-- 		vim.api.nvim_create_user_command("Peek", function()
	-- 			local peek = require("peek")
	-- 			if peek.is_open() then
	-- 				peek.close()
	-- 			else
	-- 				peek.open()
	-- 			end
	-- 		end, {})
	-- 	end,
	-- },
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
								io.open(test_path, "w"):close()
							end
							return test_path
						end
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
			-- vim.g.codeium_manual = true
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
				go = { 'fmt.Printf("%s %%v \\n", %s)' },
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
		"dzfrias/arena.nvim",
		event = "BufWinEnter",
		opts = {
			max_items = 5,
			always_context = {
				"mod.rs",
				"init.lua",
				"main.go",
			},
			ignore_current = false,
			per_project = true,
		},
		keys = { { "<leader>af", ":lua require('arena').toggle()<CR>", desc = "Arena" } },
	},
	-- {
	-- 	"Wansmer/treesj",
	-- 	keys = {
	-- 		{ "<space>ej", ":lua require('treesj').join()<CR>", desc = "Join lines" },
	-- 		{ "<space>ek", ":lua require('treesj').split()<CR>", desc = "Split lines" },
	-- 	},
	-- 	dependencies = { "nvim-treesitter/nvim-treesitter" },
	-- 	opts = { use_default_keymaps = false },
	-- },
	-- {
	-- 	"folke/which-key.nvim",
	-- 	event = "VeryLazy",
	-- 	init = function()
	-- 		vim.o.timeout = true
	-- 		vim.o.timeoutlen = 300
	-- 	end,
	-- 	opts = {
	-- 		key_labels = { ["<space>"] = "SPC", ["<CR>"] = "RET", ["<tab>"] = "TAB" },
	-- 		icons = { separator = ">" },
	-- 		triggers = { "g", "'", '"', "z" },
	-- 		triggers_nowait = { "'", "ga", "g`", "g'", '"', "z=" },
	-- 	},
	-- },
}
