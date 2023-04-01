return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-telescope/telescope-file-browser.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"aaronhallaert/ts-advanced-git-search.nvim",
		"tpope/vim-fugitive",
		"nvim-telescope/telescope-live-grep-args.nvim",
		"nvim-lua/plenary.nvim",
	},
	cmd = { "Telescope", "TelescopeDiff", "TelescopeDelta" },
	event = "VeryLazy",
	-- stylua: ignore
	keys = {
		{ "<C-p>", ":Telescope git_files<cr>", desc = "Telescope find files" },
		{ "<leader>fp", ":Telescope find_files<cr>", desc = "Telescope find files" },
		{ "<leader>fb", ":Telescope buffers<cr>", desc = "Telescope buffers" },
		{ "<leader>fc", ":TelescopeDiff<CR>", desc = "Telescope diff master" },
		{ "<leader>fr", ":Telescope oldfiles<cr>", desc = "Telescope old files" },
		{ "<leader>ff", function ()
			local git_dir = vim.fn.system(string.format("git -C %s rev-parse --show-toplevel", vim.fn.expand("%:p:h")))
			git_dir = string.gsub(git_dir, "\n", "") -- remove newline character from git_dir
			local opts = {
				cwd = git_dir,
			}
			require('telescope.builtin').live_grep(opts)
			end, desc = "Telescope live grep" },
		{ "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", desc = "Telescope live grep args" },
		{ "<leader>fz", function()
			require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
		end , desc = "Telescope live grep" },
		{ "<leader>fu", ":Telescope live_grep default_text=<C-r><C-w><cr>", desc = "Telescope live grep cursor word" },
		{ "<leader>fu", '"hy:Telescope live_grep default_text=<C-r>h<cr>', desc = "Telescope live grep paste", mode = "v" },
		{ "<leader>fq", ":Telescope quickfix<cr>", desc = "Telescope quickfix" },
		{ "<leader>fs", ":Telescope<CR>", desc = "Telescope" },
		{ "<leader>fk", ":Telescope keymaps<CR>", desc = "Telescope keymaps" },
		{ "<leader>ft", ":Telescope file_browser<cr>", desc = "Telescope file browser" },
		{ "<leader>fo", ":Telescope file_browser path=%:p:h<cr>", desc = "Telescope file browser file path" },
		{ "<leader>f/", ":Telescope current_buffer_fuzzy_find<CR>", desc = "Telescope current buffer fuzzy" },
		{ "<leader>f'", ":Telescope registers<cr>", desc = "Telescope registers" },
		{ "<leader>f;", ":Telescope neoclip<cr>", desc = "Telescope clipboard manager" },
		{ "<leader>fa", function ()
			require('telescope.builtin').live_grep({
				prompt_title = 'find string in open buffers...',
				grep_open_files = true })
			end, desc = "Telescope live grep open files" },
		{ "<leader>fw", ":TelescopeDelta<CR>", desc = "Telescope delta" },
		{ "<leader>fh", ":Telescope help_tags<CR>", desc = "Telescope help tags" },
		{ "<leader>f=", ":Telescope advanced_git_search show_custom_functions<CR>", desc = "Telescope git stuff" },
		{ "<leader>go", ":Telescope git_status<CR>", desc = "Telescope git status" },

	},
	config = function()
		local status_ok, telescope = pcall(require, "telescope")
		if not status_ok then
			return
		end

		require("base.telescope.custom")

		local border_chars_both = { "─", " ", "─", " ", " ", " ", " ", " " }
		local border_chars = { "─", " ", " ", " ", " ", " ", " ", " " }
		local actions = require("telescope.actions")
		telescope.setup({
			defaults = {
				borderchars = {
					prompt = border_chars_both,
					results = border_chars,
					preview = border_chars,
				},
				-- layout_config = {
				-- 	vertical = { width = 0.8, height = 0.9 },
				-- 	horizontal = { width = 0.9 },
				-- 	-- other layout configuration here
				-- },
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
				-- You don't need to set any of these options.
				-- IMPORTANT!: this is only a showcase of how you can set default options!
				file_browser = {
					theme = "ivy",
					-- disables netrw and use telescope-file-browser in its place
					hijack_netrw = false,
					mappings = {
						["i"] = {
							-- your custom insert mode mappings
						},
						["n"] = {
							-- your custom normal mode mappings
						},
					},
				},
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

		telescope.load_extension("refactoring")
		telescope.load_extension("neoclip")
		telescope.load_extension("fzf")
		telescope.load_extension("file_browser")
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
