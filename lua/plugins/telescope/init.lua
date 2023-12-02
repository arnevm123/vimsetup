return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"aaronhallaert/ts-advanced-git-search.nvim",
		"nvim-telescope/telescope-live-grep-args.nvim",
		"AckslD/nvim-neoclip.lua",
		"nvim-lua/plenary.nvim",
		"freestingo/telescope-changed-files",
		{ "nvim-telescope/telescope-fzf-native.nvim", enabled = vim.fn.executable("make") == 1, build = "make" },
		{ "kkharji/sqlite.lua", module = "sqlite" },
	},
	cmd = { "Telescope", "TelescopeDiff", "TelescopeDelta" },
	event = "VeryLazy",
	keys = {
		{ "<leader>fb", ":Telescope buffers<cr>", desc = "Telescope buffers" },
		-- { "<leader>fc", ":TelescopeDiff<CR>", desc = "Telescope diff master" },
		{ "<leader>fc", ":Telescope advanced_git_search changed_on_branch<CR>", desc = "Telescope diff branched" },
		{ "<leader>fg", ":Telescope git_branches<CR>", desc = "Telescope branches" },
		{ "<leader>fr", ":Telescope oldfiles<cr>", desc = "Telescope old files" },
		{ "<leader>fl", ":Telescope resume<cr>", desc = "Telescope resume" },
		{ "<leader>fq", ":Telescope quickfix<cr>", desc = "Telescope quickfix" },
		{ "<leader>fs", ":Telescope<CR>", desc = "Telescope" },
		{ "<leader>f;", ":Telescope neoclip<CR>", desc = "Neoclip" },
		{ "<leader>fk", ":Telescope keymaps<CR>", desc = "Telescope keymaps" },
		{ "<leader>f/", ":Telescope current_buffer_fuzzy_find<CR>", desc = "Telescope current buffer fuzzy" },
		{ "<leader>f'", ":Telescope registers<cr>", desc = "Telescope registers" },
		{ "<leader>fw", ":TelescopeDelta<CR>", desc = "Telescope delta" },
		{ "<leader>fh", ":Telescope help_tags<CR>", desc = "Telescope help tags" },
		{ "<leader>f=", ":Telescope advanced_git_search show_custom_functions<CR>", desc = "Telescope git stuff" },
		{ "<leader>go", ":Telescope git_status<CR>", desc = "Telescope git status" },
		{
			"<leader>fp",
			function()
				local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
				if vim.v.shell_error == 0 then
					require("telescope.builtin").find_files({ cwd = root, no_ignore = true })
				else
					require("telescope.builtin").find_files()
				end
			end,
			desc = "Telescope live grep",
		},
		{
			"<leader>ff",
			function()
				local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
				if vim.v.shell_error == 0 then
					require("telescope").extensions.live_grep_args.live_grep_args({ search_dirs = { root } })
				else
					require("telescope").extensions.live_grep_args.live_grep_args()
				end
			end,
			desc = "Telescope live grep",
		},
		{
			"<leader>fu",
			function()
				local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
				if vim.v.shell_error == 0 then
					require("telescope-live-grep-args.shortcuts").grep_word_under_cursor({ search_dirs = { root } })
				else
					require("telescope-live-grep-args.shortcuts").grep_word_under_cursor()
				end
			end,
			desc = "Telescope live grep cursor word",
		},
		{
			"<leader>fu",
			function()
				local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
				if vim.v.shell_error == 0 then
					require("telescope-live-grep-args.shortcuts").grep_visual_selection({ search_dirs = { root } })
				else
					require("telescope-live-grep-args.shortcuts").grep_visual_selection()
				end
			end,
			desc = "Telescope live grep visual selection",
			mode = "v",
		},
		{
			"<leader>fa",
			function()
				require("telescope.builtin").live_grep({
					prompt_title = "find string in open buffers...",
					grep_open_files = true,
				})
			end,
			desc = "Telescope live grep open files",
		},
	},
	config = function()
		local status_ok, telescope = pcall(require, "telescope")
		if not status_ok then
			return
		end

		require("neoclip").setup({
			enable_persistent_history = true,
			continuous_sync = true,
			db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
			preview = false,
			on_select = { move_to_front = true, close_telescope = true },
			on_paste = { set_reg = true, move_to_front = true, close_telescope = true },
			keys = { telescope = { i = { paste = "<c-y>" } } },
		})

		require("plugins.telescope.custom")
		telescope.load_extension("fzf")
		telescope.load_extension("neoclip")
		telescope.load_extension("live_grep_args")
		telescope.load_extension("advanced_git_search")
		telescope.load_extension("grey")
		telescope.load_extension("changed_files")

		local actions = require("telescope.actions")
		local lga_actions = require("telescope-live-grep-args.actions")
		local cf_actions = telescope.extensions.changed_files.actions
		telescope.setup({
			defaults = {
				prompt_prefix = "",
				entry_prefix = " ",
				selection_caret = " ",
				layout_strategy = "grey",
				layout_config = {
					-- The extension supports both "top" and "bottom" for the prompt.
					prompt_position = "top",

					-- You can adjust these settings to your liking.
					width = 0.8,
					height = 0.8,
					preview_width = 0.6,
					vertical = {
						mirror = true,
						prompt_position = "top",
						preview_cutoff = 10,
					},
					center = {
						preview_cutoff = 1000000,
						prompt_position = "bottom",
					},
				},
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-Down>"] = actions.cycle_history_next,
						["<C-Up>"] = actions.cycle_history_prev,

						["<C-n>"] = actions.move_selection_next,
						["<C-p>"] = actions.move_selection_previous,

						["<C-c>"] = actions.close,

						["<Down>"] = actions.move_selection_next,
						["<Up>"] = actions.move_selection_previous,

						["<CR>"] = actions.select_default,
						["<C-x>"] = actions.delete_buffer,
						["<C-h>"] = actions.select_horizontal,
						["<C-v>"] = actions.select_vertical,
						["<C-t>"] = actions.select_tab,

						["<C-u>"] = actions.preview_scrolling_up,
						["<C-d>"] = actions.preview_scrolling_down,

						["<PageUp>"] = actions.results_scrolling_up,
						["<PageDown>"] = actions.results_scrolling_down,

						["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
						["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
						["<C-Q>"] = actions.send_to_qflist,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
						["<C-l>"] = actions.complete_tag,
						["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
					},

					n = {
						["<esc>"] = actions.close,
						["<CR>"] = actions.select_default,
						["<C-x>"] = actions.delete_buffer,
						["dd"] = actions.delete_buffer,
						["<C-h>"] = actions.select_horizontal,
						["<C-v>"] = actions.select_vertical,
						["<C-t>"] = actions.select_tab,

						["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
						["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
						["<C-Q>"] = actions.send_to_qflist,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
						["q"] = actions.send_selected_to_qflist,

						["j"] = actions.move_selection_next,
						["k"] = actions.move_selection_previous,
						["H"] = actions.move_to_top,
						["M"] = actions.move_to_middle,
						["L"] = actions.move_to_bottom,

						["<Up>"] = actions.move_selection_previous,
						["gg"] = actions.move_to_top,
						["G"] = actions.move_to_bottom,

						["<C-u>"] = actions.preview_scrolling_up,
						["<C-d>"] = actions.preview_scrolling_down,

						["?"] = actions.which_key,
					},
				},
			},
			pickers = {
				git_branches = {
					mappings = {
						i = {
							["<C-f>"] = cf_actions.find_changed_files,
						},
						n = {
							["<C-f>"] = cf_actions.find_changed_files,
						},
					},
				},
				oldfiles = {
					cwd_only = true,
				},
				buffers = {
					sort_lastused = true,
					sort_mru = true,
				},
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				},
				live_grep_args = {
					auto_quoting = true, -- enable/disable auto-quoting
					-- define mappings, e.g.
					mappings = { -- extend mappings
						i = {
							["<C-k>"] = lga_actions.quote_prompt(),
							["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
							["<C-t>"] = lga_actions.quote_prompt({ postfix = " -t" }),
						},
						n = {
							["<C-k>"] = lga_actions.quote_prompt(),
							["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
							["<C-t>"] = lga_actions.quote_prompt({ postfix = " -t" }),
						},
					},
				},
			},
			-- To get telescope-file-browser loaded and working with telescope,
			-- you need to call load_extension, somewhere after setup function:
		})

		local previewers = require("telescope.previewers")
		local builtin = require("telescope.builtin")

		local delta = previewers.new_termopen_previewer({
			get_command = function(entry)
				return { "git", "-c", "core.pager=delta", "-c", "delta.side-by-side=false", "diff", entry.value .. "^!" }
			end,
		})

		vim.api.nvim_create_user_command("TelescopeDelta", function()
			local options = {}
			options.previewer = {
				delta,
				require("telescope.previewers").git_commit_message.new(options),
				previewers.git_commit_diff_as_was.new(options),
			}
			builtin.git_commits(options)
		end, {})
	end,
}
