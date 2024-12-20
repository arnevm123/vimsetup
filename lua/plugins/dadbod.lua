return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod" },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" } },
	},
	cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
	keys = {
		{ "<leader>qt", "<cmd>DBUIToggle<CR>", desc = "DadBod Toggle" },
		{ "<leader>qo", "<cmd>lua require('base.utils').DbuiToggle()<CR>", desc = "DadBod Open new tab" },
		{ "<leader>ql", "<cmd>DBUILastQueryInfo<CR>", desc = "DadBod last query info" },
		{ "<leader>qs", "<PLUG>(DBUI_SaveQuery)", desc = "DadBod save query" },
		{ "<leader>qq", "<PLUG>(DBUI_ExecuteQuery)", mode = { "v", "x", "n" }, desc = "DadBod run query" },
		{ "<C-q>", "<PLUG>(DBUI_ExecuteQuery)", mode = { "v", "x", "n" }, desc = "DadBod run query" },
	},
	config = function()
		vim.g.db_ui_auto_execute_table_helpers = 1
		vim.g.db_ui_dotenv_variable_prefix = "DB_UI_"
		vim.g.db_ui_save_location = vim.fn.stdpath("config") .. require("plenary.path").path.sep .. ".db_connections"
		vim.g.db_ui_execute_on_save = 0
	end,
}
