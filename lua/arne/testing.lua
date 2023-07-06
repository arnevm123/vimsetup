return {
	"nvim-neotest/neotest",
	dependencies = {
		"vim-test/vim-test",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-neotest/neotest-python",
		"nvim-neotest/neotest-plenary",
		"nvim-neotest/neotest-go",
		"rouge8/neotest-rust",
	},
	cmd = {
		"TestNearest",
		"TestFile",
		"TestSuite",
		"TestLast",
		"TestVisit",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-go"),
				require("neotest-plenary"),
				require("neotest-rust"),
			},
		})
	end,
	--stylua: ignore
	keys = {
		{ "<leader>ta", "<cmd>lua require('neotest').run.attach()<cr>", desc = "test Attach" },
		{ "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "test Run File" },
		{ "<leader>tF", "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", desc = "test Debug File"},
		{ "<leader>tl", "<cmd>lua require('neotest').run.run_last()<cr>", desc = "test Run Last" },
		{ "<leader>tL", "<cmd>lua require('neotest').run.run_last({ strategy = 'dap' })<cr>", desc = "test Debug Last" },
		{ "<leader>tn", "<cmd>lua require('neotest').run.run()<cr>", desc = "test Run Nearest" },
		{ "<leader>tN", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", desc = "test Debug Nearest" },
		{ "<leader>to", "<cmd>lua require('neotest').output.open({ enter = true })<cr>", desc = "test Output" },
		{ "<leader>tS", "<cmd>lua require('neotest').run.stop()<cr>", desc = "test Stop" },
		{ "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<cr>", desc = "test Summary" },
		{ "<leader>tp", "<Plug>PlenarytestFile", desc = "PlenarytestFile" },
		{ "<leader>tv", "<cmd>TestVisit<cr>", desc = "test Visit" },
		{ "<leader>tx", "<cmd>TestSuite<cr>", desc = "test Suite" },
	},
}
