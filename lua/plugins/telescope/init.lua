return {
	{
		"ibhagwan/fzf-lua",
		lazy = false,
		config = function()
			local actions = require("fzf-lua.actions")
			require("fzf-lua").setup({
				winopts = {
					border = false,
					row = 0,
					col = 0,
					height = 1.0,
					width = 1.0,
					preview = {
						vertical = "up:70%",
						horizontal = "right:50%",
						layout = "vertical",
						full_screen = true,
						title = false,
					},
				},
				previewers = { builtin = { syntax_limit_b = 1024 * 100 } },
				oldfiles = { include_current_session = true },
				grep = {
					formatter = "path.filename_first",
					no_header_i = true,
					header = false,
					rg_glob = true,
					-- first returned string is the new search query
					-- second returned string are (optional) additional rg flags
					-- @return string, string?
					rg_glob_fn = function(query, _)
						local regex, flags = query:match("^(.-)%s%-%-(.*)$")
						-- If no separator is detected will return the original query
						return (regex or query), flags
					end,
				},
				files = { formatter = "path.filename_first", no_header_i = true, header = false },
				actions = {
					files = {
						true,
						["Ctrl-q"] = {
							fn = actions.file_edit_or_qf,
							prefix = "select-all+",
						},
					},
				},
				lines = { file_icons = false, show_bufname = false },
				fzf_opts = {
					["--border"] = "top",
					["--layout"] = "reverse",
					["--pointer"] = ">",
				},
			})
		end,
		keys = {
			-- { "<leader>f;", "<cmd>lua require(')<CR>", mode = { "n", "v", "x" }, desc = "Neoclip" },
			{ "<leader>ff", "<cmd>FzfLua resume<CR>", mode = { "n", "v" }, desc = "FZF resume" },
			{ "<leader>f/", "<cmd>FzfLua lines<CR>", mode = { "n", "v" }, desc = "FZF current file" },
			{ "<leader>fd", "<cmd>FzfLua files<CR>", mode = { "n", "v" }, desc = "FZF current folder" },
			{ "<leader>fs", "<cmd>FzfLua live_grep_glob<CR>", mode = { "n", "v", "x" }, desc = "FzfLua live grep" },
			{ "<leader>fh", "<cmd>FzfLua help_tags<CR>", mode = { "n", "v", "x" }, desc = "FzfLua help tags" },
			{ "<leader>fk", "<cmd>FzfLua keymaps<CR>", mode = { "n", "v", "x" }, desc = "FzfLua keymaps" },
			{ "<leader>fo", "<cmd>FzfLua oldfiles cwd_only=true<CR>", mode = { "n", "v", "x" }, desc = "old files" },
			{ "<leader>fu", "<cmd>FzfLua grep_cword<CR>", mode = { "n" }, desc = "grep cword" },
			{ "<leader>fu", "<cmd>FzfLua grep_visual<CR>", mode = { "v", "x" }, desc = "grep visual" },
			{ "<leader>fg", "<cmd>FzfLua git_status<CR>", mode = { "n", "v", "x" }, desc = "FzfLua git status" },
			{ "<leader>ft", "<cmd>FzfLua<CR>", mode = { "n", "v", "x" }, desc = "FzfLua" },
			{ "<leader>fj", "<cmd>FzfLua jumps<CR>", mode = { "n", "v", "x" }, desc = "FzfLua jumplist" },
			{ "<leader>ft", "<cmd>FzfLua<CR>", mode = { "n", "v", "x" }, desc = "FzfLua" },
			{ "<leader>bb", "<cmd>FzfLua buffers<CR>", mode = { "n", "v", "x" }, desc = "FzfLua buffers" },
			{ "<leader>fie", "<cmd>FzfLua live_grep cwd=%:h<CR>", mode = { "n", "v", "x" }, desc = "live_grep dir" },
			{ "<leader>fid", "<cmd>FzfLua files cwd=%:h<CR>", mode = { "n", "v" }, desc = "find dir" },
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
					require("fzf-lua").find_files({ default_text = text, hidden = true })
				end,
				mode = { "n", "v" },
				desc = "FzfLua find copied file",
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			-- "nvim-telescope/telescope-smart-history.nvim",
			-- "nvim-lua/plenary.nvim",
			-- "nvim-telescope/telescope-frecency.nvim",
			-- "nvim-telescope/telescope-live-grep-args.nvim",
			-- "aaronhallaert/ts-advanced-git-search.nvim",
			"AckslD/nvim-neoclip.lua",
			{ "nvim-telescope/telescope-fzf-native.nvim", enabled = vim.fn.executable("make") == 1, build = "make" },
			{ "kkharji/sqlite.lua", module = "sqlite" },
		},
		event = "VeryLazy",
		keys = {
			{ "<leader>f;", "<cmd>Telescope neoclip<CR>", mode = { "n", "v", "x" }, desc = "Neoclip" },
			-- { "<leader>fc", "<cmd>TelescopeDiff<CR>", desc = "Telescope diff master" },
			-- { "<leader>fj", "<cmd>Telescope jumplist<CR>", mode = { "n", "v", "x" }, desc = "Telescope jumplist" },
			-- { "<leader>ft", "<cmd>Telescope<CR>", mode = { "n", "v", "x" }, desc = "Telescope" },
			-- { "<leader>bb", "<cmd>Telescope buffers<CR>", mode = { "n", "v", "x" }, desc = "Telescope buffers" },
			-- {
			-- 	"<leader>fie",
			-- 	function()
			-- 		require("telescope.builtin").live_grep({ cwd = vim.fn.expand("%:h"), hidden = true })
			-- 	end,
			-- 	mode = { "n", "v" },
			-- 	desc = "Telescope live grep current folder",
			-- },
			-- {
			-- 	"<leader>fig",
			-- 	function()
			-- 		require("telescope.builtin").fd({ cwd = vim.fn.expand("%:h"), hidden = true })
			-- 	end,
			-- 	mode = { "n", "v" },
			-- 	desc = "Telescope fd current folder",
			-- },
			-- {
			-- 	"<leader>fu",
			-- 	function()
			-- 		require("telescope-live-grep-args.shortcuts").grep_word_under_cursor({ hidden = true })
			-- 	end,
			-- 	desc = "Telescope live grep cursor word",
			-- },
			-- {
			-- 	"<leader>fu",
			-- 	function()
			-- 		require("telescope-live-grep-args.shortcuts").grep_visual_selection({ hidden = true })
			-- 	end,
			-- 	desc = "Telescope live grep visual selection",
			-- 	mode = "v",
			-- },
		},
		config = function()
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
			-- local lga_actions = require("telescope-live-grep-args.actions")
			telescope.setup({
				defaults = {
					borderchars = { "", "", "", "", "", "", "", "" },
					-- border = false,
					history = {
						path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
						limit = 100,
					},
					cache_picker = {
						num_pickers = 10,
						limit_entries = 1000,
					},
					prompt_prefix = "> ",
					entry_prefix = " ",
					selection_caret = ">",
					layout_strategy = "vertical",
					anchor_padding = 0,
					prompt_title = false,
					results_title = false,
					preview_title = false,
					layout_config = {
						vertical = {
							height = vim.o.lines,
							width = vim.o.columns,
							prompt_position = "top",
							preview_height = 0.70,
						},
						-- -- The extension supports both "top" and "bottom" for the prompt.
						-- prompt_position = "top",
						--
						-- -- You can adjust these settings to your liking.
						-- width = 0.8,
						-- height = 0.8,
						-- vertical = {
						-- 	mirror = true,
						-- 	prompt_position = "top",
						-- 	preview_cutoff = 10,
						-- },
						-- center = {
						-- 	preview_cutoff = 1000000,
						-- 	prompt_position = "bottom",
						-- },
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
						-- layout_config = {
						-- 	width = 0.5,
						-- 	height = 0.4,
						-- 	preview_width = 0,
						-- },
					},
				},
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					},
					-- live_grep_args = {
					-- 	auto_quoting = true, -- enable/disable auto-quoting
					-- 	-- define mappings, e.g.
					-- 	mappings = { -- extend mappings
					-- 		i = {
					-- 			["<C-u>"] = lga_actions.quote_prompt(),
					-- 			["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
					-- 			["<C-k>"] = lga_actions.quote_prompt({ postfix = " -t " }),
					-- 		},
					-- 		n = {
					-- 			["<C-u>"] = lga_actions.quote_prompt(),
					-- 			["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
					-- 			["<C-k>"] = lga_actions.quote_prompt({ postfix = " -t " }),
					-- 		},
					-- 	},
					-- },
				},
				-- To get telescope-file-browser loaded and working with telescope,
				-- you need to call load_extension, somewhere after setup function:
			})
			-- require("plugins.telescope.custom")
			-- telescope.load_extension("smart_history")
			-- telescope.load_extension("git_worktree")
			-- telescope.load_extension("fzf")
			telescope.load_extension("neoclip")
			-- telescope.load_extension("live_grep_args")
			-- telescope.load_extension("advanced_git_search")
		end,
	},
}
