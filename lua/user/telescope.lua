local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

local actions = require "telescope.actions"
telescope.load_extension "file_browser"
telescope.load_extension "fzf"
telescope.setup {
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
                ["<C-q>"] = actions.send_to_qflist,
                ["<C-Q>"] = actions.send_to_qflist + actions.open_qflist,
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
                ["<C-q>"] = actions.send_to_qflist,
                ["<C-Q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

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
            hijack_netrw = true,
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
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    }
    -- To get telescope-file-browser loaded and working with telescope,
    -- you need to call load_extension, somewhere after setup function:
}

-- load refactoring Telescope extension
telescope.load_extension("refactoring")
-- load harpoon Telescope extension
-- telescope.load_extension('harpoon')

local telescope_pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local previewers = require "telescope.previewers"
local putils = require "telescope.previewers.utils"
local from_entry = require "telescope.from_entry"
local conf = require("telescope.config").valueslocal

branch_diff = function (opts)
	return previewers.new_buffer_previewer {
		title = "Git Branch Diff Preview",
		get_buffer_by_name = function(_, entry)
			return entry.value
		end,

		define_preview = function(self, entry, _)
			local file_name = entry.value
			local get_git_status_command = "git status -s -- " .. file_name
			local git_status = io.popen(get_git_status_command):read("*a")
			local git_status_short = string.sub(git_status, 1, 1)
			if git_status_short ~= "" then
				local p = from_entry.path(entry, true)
				if p == nil or p == "" then
					return
				end
				-- conf.buffer_previewer_maker(p, self.state.bufnr, {
				-- 	bufname = self.state.bufname,
				-- 	winid = self.state.winid,
				-- })
			else
				putils.job_maker({ "git", "--no-pager", "diff", opts.base_branch .. "..HEAD", "--", file_name }, self.state.bufnr, {
					value = file_name,
					bufname = self.state.bufname,
				})
				putils.regex_highlighter(self.state.bufnr, "diff")
			end
		end,
	}
end

function telescope_diff_master()
    vim.api.nvim_command("cd `git rev-parse --show-toplevel`")
	local command = "git diff --name-only $(git merge-base master HEAD)"
    local previewer = branch_diff({base_branch = "master" })
	local entry_maker = function(entry)
		return {
			value = entry,
			display = entry,
			ordinal = entry,
		}
	end

	local handle = io.popen(command)

	if (handle == nil) then
		print('could not run specified command:' .. command)
		return
	end

	local result = handle:read("*a")

	handle:close()

	local files = {}

	for token in string.gmatch(result, "[^%c]+") do
		table.insert(files, token)
	end
    local opts = {
		prompt_title = "changes from master_files",
		finder = finders.new_table {
			results = files,
			entry_maker = entry_maker,
		},
		previewer = previewer,
	}

	telescope_pickers.new(opts):find()
end

