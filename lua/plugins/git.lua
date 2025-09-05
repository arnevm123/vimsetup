return {
	{
		"TimUntersberger/neogit",
		cmd = { "Neogit", "DiffviewOpen", "DiffviewFileHistory" },
		dependencies = {
			"sindrets/diffview.nvim",
			opts = {
				use_icons = false,
				view = {
					default = { layout = "diff2_horizontal" },
					merge_tool = { layout = "diff3_mixed", disable_diagnostics = true },
					file_history = { layout = "diff2_horizontal" },
				},
			},
		},
		keys = {
			{ "<leader>gg", "<cmd>Neogit<CR>", desc = "open Neogit" },
			{ "<leader>GG", "<cmd>DiffviewOpen master<CR>", desc = "open diff with master" },
		},
		opts = {
			ignored_settings = {},
			disable_signs = false,
			disable_hint = false,
			disable_context_highlighting = false,
			disable_commit_confirmation = false,
			auto_refresh = true,
			disable_builtin_notifications = false,
			use_magit_keybindings = false,
			kind = "tab",
			commit_popup = {
				kind = "split",
			},
			popup = {
				kind = "split",
			},
			signs = {
				-- { CLOSED, OPENED }
				section = { ">", "v" },
				item = { ">", "v" },
				hunk = { "", "" },
			},
			integrations = { diffview = true },
			-- Setting any section to `false` will make the section not render at all
			sections = {
				untracked = { folded = false },
				unstaged = { folded = false },
				staged = { folded = false },
				stashes = { folded = true },
				unpulled = { folded = true, hidden = false },
				unmerged = { folded = false, hidden = false },
				recent = { folded = true },
			},
			-- override/add mappings
			-- mappings = { status = { ["B"] = "BranchPopup" } },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		keys = {
			{ "]g", "<cmd>Gitsigns next_hunk<CR>", desc = "Gitsigns next hunk" },
			{ "[g", "<cmd>Gitsigns prev_hunk<CR>", desc = "Gitsigns prev hunk" },
			{ "<leader>gp", "<cmd>Gitsigns preview_hunk_inline<CR>", desc = "Gitsigns preview hunk" },
			{ "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", mode = { "n", "v" }, desc = "Gitsigns reset hunk" },
			{ "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", mode = { "n", "v" }, desc = "Gitsigns stage hunk" },
			{
				"<leader>gu",
				"<cmd>Gitsigns undo_stage_hunk<CR>",
				mode = { "n", "v" },
				desc = "Gitsigns undo stage hunk",
			},
			{ "<leader>gar", "<cmd>Gitsigns reset_buffer<CR>", desc = "Gitsigns reset buffer" },
			{ "<leader>gau", "<cmd>Gitsigns undo_stage_buffer<CR>", desc = "Gitsigns undo stage buffer" },
			{ "<leader>gas", "<cmd>Gitsigns stage_buffer<CR>", desc = "Gitsigns stage buffer" },
			{ "<leader>gd", "<cmd>Gitsigns diffthis HEAD<CR>", desc = "Gitsigns diff with HEAD" },
			{
				"<leader>gm",
				function()
					local branch = require("base.utils").git_main()
					if not branch then
						branch = vim.fn.input("No main branch found, enter branch name > ")
						if not branch or branch == "" then
							return
						end
					end
					require("gitsigns").diffthis(branch)
				end,
				desc = "Gitsigns diff with main",
			},
			{ "<leader>gl", "<cmd>Gitsigns blame_line<CR>", desc = "Gitsigns blame current line" },
			{ "yob", "<cmd>Gitsigns toggle_current_line_blame<CR>", desc = "Toggle inline blame" },
			{
				"<leader>gal",
				function()
					require("gitsigns").blame_line({ full = true })
				end,
				desc = "Gitsigns blame full current line",
			},
			{
				"<leader>gad",
				function()
					require("gitsigns").diffthis("~")
				end,
				desc = "",
			},
		},
		opts = {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "║" },
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
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil, -- use default
			max_file_length = 40000,
			preview_config = {
				-- options passed to nvim_open_win
				border = "none",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
		},
	},
	{
		"rbong/vim-flog",
		lazy = true,
		cmd = { "Flog", "Flogsplit", "Floggit" },
		keys = {
			{ "<leader>gf", "<cmd>lua require('base.utils').FlogToggle()<CR>", desc = "Flog" },
		},
		dependencies = {
			{
				"tpope/vim-fugitive",
				cmd = { "Git", "Gclog", "Gvdiff", "Gvdiffsplit", "Gdiffsplit" },
				keys = {
					{ "<leader>gc", "<cmd>Gvdiffsplit!<CR>", desc = "merge conflict vertical" },
					{ "<leader>gC", "<cmd>Gdiffsplit!<CR>", desc = "merge conflict horizontal" },
					{ "<leader>gh", "<cmd>0Gclog<CR>", desc = "Git history" },
					{ "<leader>gh", "<cmd>Gclog<CR>", desc = "Git history", mode = "x" },
				},
			},
		},
	},
}
