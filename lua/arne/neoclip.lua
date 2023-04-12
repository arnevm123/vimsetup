-- Does not work on linux.
if vim.fn.has("macunix") ~= 1 then
	return {}
end
return {
	"AckslD/nvim-neoclip.lua",
	dependencies = { { "kkharji/sqlite.lua", module = "sqlite" } },
	event = "BufEnter",
	keys = {
		{ "<leader>f;", ":Telescope neoclip<cr>", desc = "Telescope clipboard manager" },
	},
	opts = {
		history = 1000,
		enable_persistent_history = true,
		length_limit = 1048576,
		continuous_sync = true,
		db_path = vim.fn.stdpath("data") .. "/neoclip.sqlite3",
		filter = nil,
		preview = true,
		prompt = nil,
		default_register = '"',
		default_register_macros = "q",
		enable_macro_history = true,
		content_spec_column = false,
		on_select = {
			move_to_front = true,
			close_telescope = true,
		},
		on_paste = {
			set_reg = false,
			move_to_front = false,
			close_telescope = true,
		},
		on_replay = {
			set_reg = false,
			move_to_front = true,
			close_telescope = true,
		},
		on_custom_action = {
			close_telescope = true,
		},
		keys = {
			telescope = {
				i = {
					select = "<cr>",
					paste = "<c-i>",
					paste_behind = "<c-o>",
					replay = "<c-q>", -- replay a macro
					delete = "<c-d>", -- delete an entry
					edit = "<c-e>", -- edit an entry
					custom = {},
				},
				n = {
					select = "<cr>",
					paste = "p",
					--- It is possible to map to more than one key.
					-- paste = { 'p', '<c-p>' },
					paste_behind = "P",
					replay = "q",
					delete = "d",
					edit = "e",
					custom = {},
				},
			},
			fzf = {
				select = "default",
				paste = "ctrl-p",
				paste_behind = "ctrl-k",
				custom = {},
			},
		},
	},
}
