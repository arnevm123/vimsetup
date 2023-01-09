local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

require("base.telescope.custom")

local actions = require("telescope.actions")
telescope.load_extension("file_browser")
telescope.load_extension("dap")
-- telescope.load_extension("harpoon")
telescope.load_extension("fzf")
-- local h_actions = require "telescope".extensions.harpoon.actions
telescope.setup({
	defaults = {

		path_display = { "smart" },

		mappings = {
			i = {
				["<C-j>"] = actions.cycle_history_next,
				["<C-k>"] = actions.cycle_history_prev,

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
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
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
			-- the default case_mode is "smart_case"
		},
		-- harpoon = {
		-- 	mappings = {
		-- 		i = {
		-- 			["<C-n>"] = actions.move_selection_next,
		-- 			["<C-p>"] = actions.move_selection_previous,
		-- 			["<C-j>"] = h_actions.move_mark_down,
		-- 			["<C-k>"] = h_actions.move_mark_up,
		-- 			["<C-x>"] = h_actions.delete_harpoon_mark,
		-- 		},
		-- 		n = {
		-- 			["dd"] = h_actions.delete_harpoon_mark,
		-- 			["<C-n>"] = actions.move_selection_next,
		-- 			["<C-p>"] = actions.move_selection_previous,
		-- 			["<C-j>"] = h_actions.move_mark_down,
		-- 			["<C-k>"] = h_actions.move_mark_up,
		-- 		},
		-- 	},
		-- },
	},
	-- To get telescope-file-browser loaded and working with telescope,
	-- you need to call load_extension, somewhere after setup function:
})

-- load refactoring Telescope extension
telescope.load_extension("refactoring")
telescope.load_extension("neoclip")
