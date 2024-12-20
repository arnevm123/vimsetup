return {
	{
		"ibhagwan/fzf-lua",
		lazy = false,
		dependencies = {
			{ "kkharji/sqlite.lua", module = "sqlite" },
			"AckslD/nvim-neoclip.lua",
		},
		config = function()
			local actions = require("fzf-lua.actions")

			require("neoclip").setup({
				enable_persistent_history = true,
				db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
				preview = false,
				keys = { fzf = { paste = "ctrl-y" } },
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

			require("fzf-lua").setup({
				winopts = {
					border = false,
					row = 0,
					col = 0,
					height = 1.0,
					width = 1.0,
					preview = {
						vertical = "up:75%",
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
			{ "<leader>f;", "<cmd>lua require('neoclip.fzf')()<CR>", mode = { "n", "v", "x" }, desc = "Neoclip" },
			{ "<leader>ff", "<cmd>FzfLua resume<CR>", mode = { "n", "v" }, desc = "FZF resume" },
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
}
