return {
	"AckslD/nvim-neoclip.lua",
	dependencies = {
		{ "kkharji/sqlite.lua", module = "sqlite" },
		"nvim-neotest/nvim-nio",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("neoclip").setup({
			enable_persistent_history = true,
			db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
			preview = true,
			keys = {
				telescope = {
					i = { paste = "ctrl-y" },
					n = { paste = "p" },
				},
			},
		})

		vim.api.nvim_create_autocmd("FocusLost", {
			group = vim.api.nvim_create_augroup("NeoClipFocusLost", {}),
			pattern = "*",
			callback = function()
				require("neoclip").db_push()
			end,
		})

		vim.api.nvim_create_autocmd("FocusGained", {
			group = vim.api.nvim_create_augroup("NeoClipFocusGained", {}),
			pattern = "*",
			callback = function()
				require("nio").run(function()
					require("nio").sleep(200)
					require("neoclip").db_pull()
				end)
			end,
		})
	end,
	keys = {
		{ "<leader>f;", "<cmd>Telescope neoclip<CR>", mode = { "n", "v", "x" }, desc = "Neoclip" },
	},
}
