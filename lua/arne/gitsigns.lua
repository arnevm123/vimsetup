return {
	"lewis6991/gitsigns.nvim",
	event = "BufReadPre",
	keys = {
		{ "]g", ":Gitsigns next_hunk<cr>", desc = "Gitsigns next hunk" },
		{ "[g", ":Gitsigns prev_hunk<cr>", desc = "Gitsigns prev hunk" },
		{ "<leader>gp", ":Gitsigns preview_hunk_inline<cr>", desc = "Gitsigns preview hunk" },
		{ "<leader>gr", ":Gitsigns reset_hunk<cr>", desc = "Gitsigns reset hunk" },
		{ "<leader>gR", ":Gitsigns reset_buffer<cr>", desc = "Gitsigns reset buffer" },
		{ "<leader>gs", ":Gitsigns stage_hunk<cr>", desc = "Gitsigns stage hunk" },
		{ "<leader>gS", ":Gitsigns stage_buffer<cr>", desc = "Gitsigns stage buffer" },
		{ "<leader>gu", ":Gitsigns undo_stage_hunk<cr>", desc = "Gitsigns undo stage hunk" },
		{ "<leader>gU", ":Gitsigns undo_stage_buffer<cr>", desc = "Gitsigns undo stage buffer" },
		{ "<leader>gd", ":Gitsigns diffthis HEAD<cr>", desc = "Gitsigns diff with HEAD" },
		{ "<leader>gm", ":Gitsigns diffthis master<cr>", desc = "Gitsigns diff with master" },
		{ "<leader>gl", ":Gitsigns blame_line<cr>", desc = "Gitsigns blame current line" },
		{ "yob", ":Gitsigns toggle_current_line_blame<CR>", desc = "Toggle inline blame" },
		{
			"<leader>gL",
			function()
				require("gitsigns").blame_line({ full = true })
			end,
			desc = "Gitsigns blame full current line",
		},
		{
			"<leader>gD",
			function()
				require("gitsigns").diffthis("~")
			end,
			desc = "",
		},
	},
	opts = {
		signs = {
			add = { hl = "DiffAdd", text = "│", numhl = "DiffAdd" },
			change = { hl = "DiffChange", text = "│", numhl = "DiffChange" },
			delete = { hl = "DiffDelete", text = "_", numhl = "DiffDelete" },
			topdelete = { hl = "DiffDelete", text = "‾", numhl = "DiffDelete" },
			changedelete = { hl = "DiffDelete", text = "~", numhl = "DiffChange" },
			untracked = { hl = "DiffAdd", text = "║", numhl = "DiffAdd" },
		},
		signcolumn = true, -- toggle with `:gitsigns toggle_signs`
		numhl = false, -- toggle with `:gitsigns toggle_numhl`
		linehl = false, -- toggle with `:gitsigns toggle_linehl`
		word_diff = false, -- toggle with `:gitsigns toggle_word_diff`
		watch_gitdir = {
			interval = 1000,
			follow_files = true,
		},
		attach_to_untracked = true,
		current_line_blame = false, -- toggle with `:gitsigns toggle_current_line_blame`
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
			delay = 0,
			ignore_whitespace = true,
		},
		current_line_blame_formatter_opts = {
			relative_time = false,
		},
		sign_priority = 6,
		update_debounce = 100,
		status_formatter = nil, -- use default
		max_file_length = 40000,
		preview_config = {
			-- options passed to nvim_open_win
			border = "single",
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
		},
		yadm = {
			enable = false,
		},
	},
}
