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
				quickfix = { enabled = true, open = true },
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
		--stylua: ignore
		keys = {
			{ "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", desc = "test Run File" },
			{ "<leader>twf", "<cmd>lua require('neotest').watch.watch(vim.fn.expand('%'))<CR>", desc = "test Watch File" },
			{ "<leader>tdf", "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<CR>", desc = "test Debug File"},
			{ "<leader>tl", "<cmd>lua require('neotest').run.run_last()<CR>", desc = "test Run Last" },
			{ "<leader>twl", "<cmd>lua require('neotest').watch.watch_last()<CR>", desc = "test Watch Last" },
			{ "<leader>tdl", "<cmd>lua require('neotest').run.run_last({ strategy = 'dap' })<CR>", desc = "test Debug Last" },
			{ "<leader>tn", "<cmd>lua require('neotest').run.run()<CR>", desc = "test Run Nearest" },
			{ "<leader>twn", "<cmd>lua require('neotest').watch.watch()<CR>", desc = "test Watch Nearest" },
			{ "<leader>tdn", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>", desc = "test Debug Nearest" },
			{ "<leader>to", "<cmd>lua require('neotest').output.open({ enter = true })<CR>", desc = "test Output" },
			{ "<leader>ts", "<cmd>lua require('neotest').run.stop()<CR>", desc = "test Stop" },
			{ "<leader>twq", "<cmd>lua require('neotest').watch.stop()<CR>", desc = "test Stop" },
			{ "<leader>tt", "<cmd>lua require('neotest').summary.toggle()<CR>", desc = "test Summary" },
		},
	},
	{
		"andythigpen/nvim-coverage",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("coverage").setup({
				auto_reload = true,
				lang = { go = { coverage_file = ".coverage.out" } },
			})

			vim.api.nvim_create_user_command("LoadCov", function()
				vim.fn.jobstart("make test", {
					on_exit = function(_, exit_code)
						if exit_code ~= 0 then
							vim.notify("There was an error running the tests", vim.log.levels.ERROR)
							return
						end
						require("coverage").load(true)
						vim.notify("Test coverage loaded", vim.log.levels.INFO)
					end,
				})
			end, {})
		end,
		keys = {
			{ "<leader>tc", "<cmd>CoverageToggle<CR>", desc = "Test Coverage" },
			{ "<leader>tq", "<cmd>LoadCov<CR>", desc = "Test Coverage Load" },
		},
	},
}
