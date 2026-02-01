return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			-- "vim-test/vim-test",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/nvim-nio",
			"nvim-neotest/neotest-python",
			"nvim-neotest/neotest-plenary",
			{
				"fredrikaverpil/neotest-golang",
				version = "*",
				build = function() vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait() end,
			},
			"rouge8/neotest-rust",
		},
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("neotest").setup({
				quickfix = { enabled = true, open = false },
				diagnostic = {
					enabled = true,
					severity = 4,
				},
				adapters = {
					require("neotest-golang")({ runner = "gotestsum" }),
					require("neotest-plenary"),
					require("neotest-rust"),
				},
			})
		end,
		keys = {
			{ "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", desc = "test Run File" },
			{ "<leader>tn", "<cmd>lua require('neotest').run.run()<CR>", desc = "test Run Nearest" },
			{ "<leader>tdn", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>", desc = "test Run Nearest" },
			{ "<leader>tl", "<cmd>lua require('neotest').run.run_last()<CR>", desc = "test Run Last" },
			{ "<leader>tdl", "<cmd>lua require('neotest').run.run_last({strategy = 'dap'})<CR>", desc = "test Debug" },
			{ "<leader>tt", "<cmd>lua require('neotest').summary.toggle()<CR>", desc = "test Summary" },
		},
	},
}
