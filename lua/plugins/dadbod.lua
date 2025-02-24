return {
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod" },
		},
		cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
		keys = {
			{ "<leader>qt", "<cmd>DBUIToggle<CR>", desc = "DadBod Toggle" },
			{ "<leader>qo", "<cmd>lua require('base.utils').DbuiToggle()<CR>", desc = "DadBod Open new tab" },
			{ "<leader>qq", "<PLUG>(DBUI_ExecuteQuery)", mode = { "v", "x", "n" }, desc = "DadBod run query" },
			{ "<C-q>", "<PLUG>(DBUI_ExecuteQuery)", mode = { "v", "x", "n" }, desc = "DadBod run query" },
		},
		config = function()
			vim.g.db_ui_auto_execute_table_helpers = 1
			vim.g.db_ui_dotenv_variable_prefix = "DB_UI_"
			vim.g.db_ui_save_location = vim.fn.stdpath("config")
				.. require("plenary.path").path.sep
				.. ".db_connections"
			vim.g.db_ui_execute_on_save = 0
			vim.api.nvim_create_autocmd("FileType", {
			  pattern = "dbout",
			  callback = function()
				vim.api.nvim_buf_set_keymap(0, "n", "gd", "<Plug>(DBUI_JumpToForeignKey)", { noremap = false, silent = true })
			  end
			})
		end,
	},
}
