return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},

	keys = {
		{ "<leader>qo", ":DBUIToggle<cr>", desc = "DadBod toggle" },
		{ "<leader>qf", ":DBUIFindBuffer<cr>", desc = "DadBod find buffer" },
		{ "<leader>ql", ":DBUILastQueryInfo<cr>", desc = "DadBod last query info" },
		{ "<leader>qr", ":DB<cr>", mode = "v", desc = "DadBod run selected" },
	},
	config = function()
		vim.g.db_ui_dotenv_variable_prefix = "DB_UI_"
		vim.g.db_ui_save_location = vim.fn.stdpath("config") .. require("plenary.path").path.sep .. ".db_connections"

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"sql",
			},
			command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
		})

		local function db_completion()
			require("cmp").setup.buffer({
				formatting = {
					fields = { "abbr", "menu", "kind" },
					format = function(entry, vim_item)
						vim_item.menu = ({
							["vim-dadbod-completion"] = "[DB]",
							buffer = "Buf",
						})[entry.source.name]
						return vim_item
					end,
				},
				sources = {
					{ name = "vim-dadbod-completion" },
					{ name = "buffer" },
				},
			})
		end
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"sql",
				"mysql",
				"plsql",
			},
			callback = function()
				vim.schedule(db_completion)
			end,
		})
	end,
}
