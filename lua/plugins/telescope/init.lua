return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-telescope/telescope-smart-history.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-frecency.nvim",
		"nvim-telescope/telescope-live-grep-args.nvim",
		"AckslD/nvim-neoclip.lua",
		"aaronhallaert/ts-advanced-git-search.nvim",
		{
			"AdeAttwood/ivy.nvim",
			build = "cargo build --release",
			opts = {
				backends = {
					{ "ivy.backends.buffers", { keymap = "<leader>bb" } },
					{ "ivy.backends.files", { keymap = "<leader>fd" } },
					{ "ivy.backends.ag", { keymap = "<leader>/" } },
					-- require("plugins.ivy.recent_files"),
				},
			},
		},
		{ "nvim-telescope/telescope-fzf-native.nvim", enabled = vim.fn.executable("make") == 1, build = "make" },
		{ "kkharji/sqlite.lua", module = "sqlite" },
	},
	event = "VeryLazy",
	keys = {
		{ "<leader>fc", "<cmd>TelescopeDiff<CR>", desc = "Telescope diff master" },
		{ "<leader>f'", "<cmd>Telescope registers<CR>", mode = { "n", "v", "x" }, desc = "Telescope registers" },
		{ "<leader>fj", "<cmd>Telescope jumplist<CR>", mode = { "n", "v", "x" }, desc = "Telescope jumplist" },
		{ "<leader>f;", "<cmd>Telescope neoclip<CR>", mode = { "n", "v", "x" }, desc = "Neoclip" },
		{
			"<C-r><C-r>",
			"<Plug>(TelescopeFuzzyCommandSearch)",
			mode = { "c" },
			desc = "Telescope fuzzy command search",
		},
		{
			"<C-p>",
			function()
				local paste = require("neoclip.storage").get().yanks[1]
				vim.fn.setreg('"', paste.contents)
				vim.api.nvim_put(paste.contents, paste.regtype, true, true)
			end,
			mode = { "n", "v", "x" },
			desc = "Neoclip paste last",
		},
		{
			"<leader>FF",
			function()
				vim.ivy.run(
					-- The name given to the results window and displayed to the user
					"Title",
					-- Call back function to get all the candidates that will be displayed in
					-- the results window, The `input` will be passed in, so you can filter
					-- your results with the value from the prompt
					function(input)
						return {
							{ content = "One" },
							{ content = "Two" },
							{ content = "Three" },
						}
					end,
					-- Action callback that will be called on the completion or peek actions.
					-- The currently selected item is passed in as the result.
					function(result)
						vim.cmd("edit " .. result)
					end
				)
			end,
			mode = { "n" },
		},

		{ "<leader>fh", "<cmd>Telescope help_tags<CR>", mode = { "n", "v", "x" }, desc = "Telescope help tags" },
		{ "<leader>fk", "<cmd>Telescope keymaps<CR>", mode = { "n", "v", "x" }, desc = "Telescope keymaps" },
		{ "<leader>fl", "<cmd>Telescope pickers<CR>", mode = { "n", "v", "x" }, desc = "Telescope last searches" },
		{ "<leader>fo", "<cmd>Telescope oldfiles hidden=true<CR>", mode = { "n", "v", "x" }, desc = "Telescope old files" },
		{ "<leader>fq", "<cmd>Telescope quickfix<CR>", mode = { "n", "v", "x" }, desc = "Telescope quickfix" },
		{
			"<leader>fs",
			"<cmd>Telescope git_status hidden=true<CR>",
			mode = { "n", "v", "x" },
			desc = "Telescope git status",
		},
		{ "<leader>ft", "<cmd>Telescope<CR>", mode = { "n", "v", "x" }, desc = "Telescope" },
		-- { "<leader>bb", "<cmd>IvyBuffers<CR>", mode = { "n", "v", "x" }, desc = "Ivy buffers" },
		{ "<leader>f/", "<cmd>IvyLines<CR>", mode = { "n", "v", "x" }, desc = "Ivy current buffer fuzzy" },
		-- {
		-- 	"<leader>fc",
		-- 	"<cmd>Telescope advanced_git_search changed_on_branch<CR>",
		-- 	mode = { "n", "v", "x" },
		-- 	desc = "Telescope diff branched",
		-- },
		{
			"<leader>fp",
			function()
				local text = vim.fn.getreg("+")
				if not text then
					vim.notify("No text in register", vim.log.levels.ERROR)
					return
				end
				text = text:match("([^\n]+)")
				text = string.gsub(text, "^%s*(.-)%s*$", "%1")
				require("telescope.builtin").find_files({ default_text = text, hidden = true })
			end,
			mode = { "n", "v" },
			desc = "Telescope find copied file",
		},
		{
			"<leader>fi",
			function()
				require("telescope.builtin").live_grep({ cwd = vim.fn.expand("%:h"), hidden = true })
			end,
			mode = { "n", "v" },
			desc = "Telescope live grep current folder",
		},
		{
			"<leader>fe",
			function()
				require("telescope.builtin").fd({ cwd = vim.fn.expand("%:h"), hidden = true })
			end,
			mode = { "n", "v" },
			desc = "Telescope fd current folder",
		},
		{
			"<leader>fr",
			function()
				require("telescope").extensions.frecency.frecency({ workspace = "CWD", hidden = true })
			end,
			mode = { "n", "v" },
			desc = "Telescope live grep",
		},
		{
			"<leader>fg",
			function()
				require("telescope.builtin").grep_string({
					search = vim.fn.input("Grep > "),
					additional_args = { "--hidden" },
				})
			end,
			desc = "Telescope grep",
		},
		{
			"<leader>ff",
			function()
				require("telescope").extensions.live_grep_args:live_grep_args({
					vimgrep_arguments = { "rg", "--hidden" },
				})
			end,
			mode = { "n", "v" },
			desc = "Telescope live grep",
		},
		{
			"<leader>fu",
			function()
				require("telescope-live-grep-args.shortcuts").grep_word_under_cursor({ hidden = true })
			end,
			desc = "Telescope live grep cursor word",
		},
		{
			"<leader>fu",
			function()
				require("telescope-live-grep-args.shortcuts").grep_visual_selection({ hidden = true })
			end,
			desc = "Telescope live grep visual selection",
			mode = "v",
		},
	},
	config = function()
		-- { "<C-r><C-r>", "<Plug>(TelescopeFuzzyCommandSearch)", mode = { "c"}, desc = "Telescope fuzzy command search" },
		function Searchlatest()
			vim.ivy.run(
				-- The name given to the results window and displayed to the user
				"Old files",
				-- Call back function to get all the candidates that will be displayed in
				-- the results window, The `input` will be passed in, so you can filter
				-- your results with the value from the prompt
				function(_)
					local files = vim.v.oldfiles
					local result = {}
					for _, file in ipairs(files) do
						local file_stat = vim.loop.fs_stat(file)
						if
							file_stat
							and file_stat.type == "file"
							and file ~= vim.fn.expand("%:p")
							and not string.find(file, ".git/COMMIT_EDITMSG")
						then
							local cwd = vim.loop.cwd() .. require("plenary.path").path.sep
							if vim.fn.matchstrpos(file, cwd)[2] ~= -1 then
								-- remove cwd from filename

								local filename = string.sub(file, string.len(cwd) + 1)
								table.insert(result, #result, { content = filename })
							end
						end
					end
					return result
				end,
				-- Action callback that will be called on the completion or peek actions.
				-- The currently selected item is passed in as the result.
				function(result)
					vim.cmd("edit " .. result.path)
				end
			)
		end
		local status_ok, telescope = pcall(require, "telescope")
		if not status_ok then
			return
		end

		require("neoclip").setup({
			enable_persistent_history = true,
			db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
			preview = true,
			on_select = { move_to_front = true, close_telescope = true },
			on_paste = { set_reg = true, move_to_front = true, close_telescope = true },
			keys = { telescope = { i = { paste = "<c-y>" } } },
		})

		vim.api.nvim_create_autocmd("FocusLost", {
			group = vim.api.nvim_create_augroup("NeoClipFocusLost", {}),
			pattern = "*",
			callback = function()
				require("neoclip").db_push()
			end,
		})

		vim.api.nvim_create_autocmd("FocusGained", {
			group = vim.api.nvim_create_augroup("NeoClipFocusGained", {}),
			pattern = "*",
			callback = function()
				require("nio").run(function()
					require("nio").sleep(200)
					require("neoclip").db_pull()
				end)
			end,
		})

		local actions = require("telescope.actions")
		local lga_actions = require("telescope-live-grep-args.actions")
		telescope.setup({
			defaults = {
				history = {
					path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
					limit = 100,
				},
				cache_picker = {
					num_pickers = 10,
					limit_entries = 1000,
				},
				prompt_prefix = "",
				entry_prefix = " ",
				selection_caret = ">",
				layout_config = {
					-- The extension supports both "top" and "bottom" for the prompt.
					prompt_position = "top",

					-- You can adjust these settings to your liking.
					width = 0.8,
					height = 0.8,
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
				-- path_display = { shorten = { len = 5, exclude = { 1, -3, -2, -1 } } },
				path_display = {
					"filename_first",
				},
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
					hidden = true,
				},
				buffers = {
					sort_lastused = true,
					sort_mru = true,
					ignore_current_buffer = true,
					layout_config = {
						width = 0.5,
						height = 0.4,
						preview_width = 0,
					},
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
							["<C-u>"] = lga_actions.quote_prompt(),
							["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
							["<C-k>"] = lga_actions.quote_prompt({ postfix = " -t " }),
						},
						n = {
							["<C-u>"] = lga_actions.quote_prompt(),
							["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
							["<C-k>"] = lga_actions.quote_prompt({ postfix = " -t " }),
						},
					},
				},
			},
			-- To get telescope-file-browser loaded and working with telescope,
			-- you need to call load_extension, somewhere after setup function:
		})
		require("plugins.telescope.custom")
		telescope.load_extension("smart_history")
		telescope.load_extension("git_worktree")
		telescope.load_extension("fzf")
		telescope.load_extension("neoclip")
		telescope.load_extension("live_grep_args")
		telescope.load_extension("advanced_git_search")
	end,
}
