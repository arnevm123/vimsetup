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
			"fredrikaverpil/neotest-golang",
			"rouge8/neotest-rust",
		},
		event = "VeryLazy",
		config = function()
			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						local message =
							diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
						return message
					end,
				},
			}, neotest_ns)
			---@diagnostic disable-next-line: missing-fields
			require("neotest").setup({
				quickfix = { enabled = true, open = false },
				diagnostic = {
					enabled = true,
					severity = 4,
				},
				adapters = {
					require("neotest-golang")(), -- Registration
					require("neotest-plenary"),
					require("neotest-rust"),
				},
			})
		end,
		keys = {
			{ "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", desc = "test Run File" },
			{ "<leader>tn", "<cmd>lua require('neotest').run.run()<CR>", desc = "test Run Nearest" },
			{ "<leader>tl", "<cmd>lua require('neotest').run.run_last()<CR>", desc = "test Run Last" },
			{ "<leader>td", "<cmd>lua require('neotest').run.run_last({strategy = 'dap'})<CR>", desc = "test Debug", },
			{ "<leader>tt", "<cmd>lua require('neotest').summary.toggle()<CR>", desc = "test Summary" },
		},
	},
}
