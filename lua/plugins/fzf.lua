return {
	{

		"ibhagwan/fzf-lua",
		lazy = false,
		config = function()
			local actions = require("fzf-lua.actions")
			require("fzf-lua").setup({
				oldfiles = { include_current_session = true },
				previewers = { builtin = { syntax_limit_b = 1024 * 100 } },
				lines = { file_icons = false, show_bufname = false },
				files = {
					formatter = "path.filename_first",
					no_header_i = true,
					header = false,
					fzf_opts = { ["--literal"] = true },
				},
				actions = { files = { true, ["Ctrl-q"] = { fn = actions.file_edit_or_qf, prefix = "select-all+" } } },
				fzf_opts = { ["--border"] = "top", ["--layout"] = "reverse", ["--pointer"] = ">" },
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
						title = true,
					},
				},
				grep = {
					formatter = "path.filename_first",
					no_header_i = true,
					header = false,
					rg_glob = true,
				},
			})
		end,
		keys = {
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
			{ "<leader>fis", "<cmd>FzfLua live_grep cwd=%:h<CR>", mode = { "n", "v", "x" }, desc = "live_grep dir" },
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
					require("fzf-lua").files({ default_text = text, hidden = true })
				end,
				mode = { "n", "v" },
				desc = "FzfLua find copied file",
			},
		},
	},
}
