return {
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
				{ path = "lazy.nvim", words = { "LazyVim" } },
			},
		},
		dependencies = {
			{ "Bilal2453/luvit-meta" },
		},
	},
	{
		"olexsmir/gopher.nvim",
		ft = { "go", "gomod" },
		opts = {
			gotests = { template = "testify" },
			iferr = {
				message = 'fmt.Errorf("%w", err)',
			},
		},
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
}
