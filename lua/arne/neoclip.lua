if vim.fn.has "macunix" ~= 1 then
	return {}
end
return {
	"AckslD/nvim-neoclip.lua",
	dependencies = { { "kkharji/sqlite.lua" , module = 'sqlite'} },
	event = "BufEnter",
	keys = {
		{ "<leader>f;", ":Telescope neoclip<cr>", desc = "Telescope clipboard manager" },
	},
	opts = {
		default_register = '+',
		db_path = vim.fn.stdpath("data") .. "/neoclip.sqlite3",
		enable_persistent_history = true,
		continuous_sync = true,
		default_register_macros = "a",
		enable_macro_history = true,
		keys = {
			telescope = {
				i = {
					select = "<cr>",
					paste = "<c-i>",
					paste_behind = "<c-o>",
					replay = "<c-q>", -- replay a macro
					delete = "<c-d>", -- delete an entry
					custom = {},
				},
				n = {
					select = "<cr>",
					paste = "p",
					paste_behind = "P",
					replay = "q",
					delete = "d",
					custom = {},
				},
			},
		},
	},
}
