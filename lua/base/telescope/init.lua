return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", enabled = vim.fn.executable("make") == 1, build = "make" },
		"aaronhallaert/ts-advanced-git-search.nvim",
		"tpope/vim-fugitive",
		"nvim-telescope/telescope-live-grep-args.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-lua/plenary.nvim",
	},
	cmd = { "Telescope", "TelescopeDiff", "TelescopeDelta" },
	event = "VeryLazy",
	keys = {
		{ "<leader>fb", ":Telescope buffers<cr>", desc = "Telescope buffers" },
		{ "<leader>fc", ":TelescopeDiff<CR>", desc = "Telescope diff master" },
		{ "<leader>fr", ":Telescope oldfiles<cr>", desc = "Telescope old files" },
		{ "<leader>fq", ":Telescope quickfix<cr>", desc = "Telescope quickfix" },
		{ "<leader>fs", ":Telescope<CR>", desc = "Telescope" },
		{ "<leader>fk", ":Telescope keymaps<CR>", desc = "Telescope keymaps" },
		{ "<leader>f/", ":Telescope current_buffer_fuzzy_find<CR>", desc = "Telescope current buffer fuzzy" },
		{ "<leader>f'", ":Telescope registers<cr>", desc = "Telescope registers" },
		{ "<leader>fw", ":TelescopeDelta<CR>", desc = "Telescope delta" },
		{ "<leader>fh", ":Telescope help_tags<CR>", desc = "Telescope help tags" },
		{ "<leader>f=", ":Telescope advanced_git_search show_custom_functions<CR>", desc = "Telescope git stuff" },
		{ "<leader>tr", ":Telescope resume<CR>", desc = "Telescope git stuff" },
		{ "<leader>go", ":Telescope git_status<CR>", desc = "Telescope git status" },
		{
			"<leader>FP",
			function()
				local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
				if vim.v.shell_error == 0 then
					require("telescope.builtin").find_files({ cwd = root })
				else
					require("telescope.builtin").find_files()
				end
			end,
			desc = "Telescope live grep",
		},
		{
			"<leader>FF",
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
			"<leader>FU",
			function()
				local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
				if vim.v.shell_error == 0 then
					require("telescope-live-grep-args.shortcuts").grep_word_under_cursor({ search_dirs = { root } })
				else
					require("telescope.builtin").grep_word_under_cursor()
				end
			end,
			desc = "Telescope live grep cursor word",
		},
		{
			"<leader>FU",
			function()
				local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
				if vim.v.shell_error == 0 then
					require("telescope-live-grep-args.shortcuts").grep_visual_selection({ search_dirs = { root } })
				else
					require("telescope.builtin").grep_visual_selection()
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

		require("base.telescope.custom")

		local border_chars = { "─", " ", " ", " ", " ", " ", " ", " " }
		local actions = require("telescope.actions")
		telescope.setup({
			defaults = {
				layout_strategy = "vertical",
				layout_config = {
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
					auto_quoting = false, -- enable/disable auto-quoting
				},
			},
			-- To get telescope-file-browser loaded and working with telescope,
			-- you need to call load_extension, somewhere after setup function:
		})

		telescope.load_extension("neoclip")
		telescope.load_extension("refactoring")
		telescope.load_extension("fzf")
		telescope.load_extension("live_grep_args")
		telescope.load_extension("advanced_git_search")

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
-- {
-- 	"<leader>fy",
-- 	function()
-- 		vim.cmd('noau normal! vi""vy')
-- 		local text = 'FullMethod: "' .. vim.fn.getreg("v") .. '"'
-- 		local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
-- 		if vim.v.shell_error == 0 then
-- 			require("telescope.builtin").grep_string({ search = text, cwd = root })
-- 		else
-- 			require("telescope.builtin").grep_string({ search = text })
-- 		end
-- 	end,
-- 	desc = "Telescope grpc string",
-- },
-- {
-- 	"<leader>fY",
-- 	function()
-- 		vim.cmd('noau normal! vi""vy')
-- 		local text = '(ctx, "' .. vim.fn.getreg("v") .. '", in, out,'
-- 		local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
-- 		if vim.v.shell_error == 0 then
-- 			require("telescope.builtin").grep_string({ search = text, cwd = root })
-- 		else
-- 			require("telescope.builtin").grep_string({ search = text })
-- 		end
-- 	end,
-- 	desc = "Telescope grpc string back",
-- },
-- 	git_dir = string.gsub(git_dir, "\n", "") -- remove newline character from git_dir
-- 	local opts = {
-- 		cwd = git_dir,
-- 	}
-- 	require('telescope.builtin').live_grep(opts)
-- 	end, desc = "Telescope live grep" },
-- { "<C-p>", ":Telescope git_files<cr>", desc = "Telescope find files" },
-- { "<leader>fp", ":Telescope find_files<cr>", desc = "Telescope find files" },
-- {
-- 	"<leader>ff",
-- 	function()
-- 		local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
-- 		if vim.v.shell_error == 0 then
-- 			require("telescope.builtin").live_grep({ cwd = root })
-- 		else
-- 			require("telescope.builtin").live_grep()
-- 		end
-- 	end,
-- 	desc = "Telescope live grep",
-- },
-- { "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", desc = "Telescope live grep args" },
-- { "<leader>fz", function()
-- 	require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
-- end , desc = "Telescope live grep" },
-- {
-- 	"<leader>fy",
-- 	'vi""hy:lua require("telescope.builtin").grep_string({ search = \'FullMethod: \\"<C-r>h\\",\'})<CR>',
-- },
