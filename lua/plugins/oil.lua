return {
	{
		"stevearc/oil.nvim",
		opts = {
			columns = { "permissions", "size" },
			buf_options = { buflisted = false },
			win_options = {
				wrap = false,
				signcolumn = "no",
				cursorcolumn = false,
				foldcolumn = "0",
				spell = false,
				list = false,
				conceallevel = 3,
				concealcursor = "n",
			},
			default_file_explorer = false,
			restore_win_options = true,
			skip_confirm_for_simple_edits = false,
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<leader>v"] = "actions.select_vsplit",
				["<leader>h"] = "actions.select_split",
				["<leader>t"] = "actions.select_tab",
				["<leader>p"] = "actions.preview",
				["<leader>r"] = "actions.refresh",
				["<leader>cd"] = "actions.cd",
				["q"] = "actions.close",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["~"] = "actions.tcd",
				["g."] = "actions.toggle_hidden",
			},
			use_default_keymaps = false,
			view_options = {
				show_hidden = true,
				is_hidden_file = function(name, bufnr)
					return vim.startswith(name, ".")
				end,
				is_always_hidden = function(name, bufnr)
					return false
				end,
			},
			float = {
				padding = 2,
				max_width = 0,
				max_height = 0,
				border = "rounded",
				win_options = {
					winblend = 10,
				},
			},
			preview = {
				max_width = 0.9,
				min_width = { 40, 0.4 },
				width = nil,
				max_height = 0.9,
				min_height = { 5, 0.1 },
				height = nil,
				border = "rounded",
				win_options = {
					winblend = 0,
				},
			},
			progress = {
				max_width = 0.9,
				min_width = { 40, 0.4 },
				width = nil,
				max_height = { 10, 0.9 },
				min_height = { 5, 0.1 },
				height = nil,
				border = "rounded",
				minimized_border = "none",
				win_options = {
					winblend = 0,
				},
			},
		},
		cmd = { "Oil" },
	},
}
