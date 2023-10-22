return {
	"ibhagwan/fzf-lua",
	opts = {
		"default",
		grep = {
			rg_glob = true,
			glob_flag = "--iglob",
			glob_separator = "%s%-%-",
		},
		keymap = {
			builtin = {
				["<F1>"] = "toggle-help",
				["<F2>"] = "toggle-fullscreen",
				-- Only valid with the 'builtin' previewer
				["<F3>"] = "toggle-preview-wrap",
				["<F4>"] = "toggle-preview",
				["<F5>"] = "toggle-preview-ccw",
				["<F6>"] = "toggle-preview-cw",
				["<C-d>"] = "preview-page-down",
				["<C-u>"] = "preview-page-up",
				["<S-left>"] = "preview-page-reset",
			},
			fzf = {
				["ctrl-z"] = "abort",
				["ctrl-f"] = "half-page-down",
				["ctrl-b"] = "half-page-up",
				["ctrl-a"] = "beginning-of-line",
				["ctrl-e"] = "end-of-line",
				["alt-a"] = "toggle-all",
				-- Only valid with fzf previewers (bat/cat/git/etc)
				["f3"] = "toggle-preview-wrap",
				["f4"] = "toggle-preview",
				["ctrl-d"] = "preview-page-down",
				["ctrl-u"] = "preview-page-up",
				["ctrl-y"] = "select",
				["ctrl-q"] = "select-all+accept",
			},
		},
		winopts = {
			preview = {
				layout = "vertical",
			},
		},
	},
	keys = {
		{ "<leader>FL", ":FzfLua resume<CR>", desc = "fzf resume grep" },
		{
			"<leader>FP",
			function()
				local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
				if vim.v.shell_error == 0 then
					require("fzf-lua").files({ cwd = root })
				else
					require("fzf-lua").files()
				end
			end,
			desc = "fzf files",
		},

		{
			"<leader>FG",
			function()
				local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
				if vim.v.shell_error == 0 then
					require("fzf-lua").grep({ cwd = root })
				else
					require("fzf-lua").grep()
				end
			end,
			desc = "fzf files",
		},
		{
			"<leader>FG",
			function()
				local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
				if vim.v.shell_error == 0 then
					require("fzf-lua").grep({ cwd = root })
				else
					require("fzf-lua").grep()
				end
			end,
			desc = "fzf grep",
		},
		{
			"<leader>FF",
			function()
				local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
				if vim.v.shell_error == 0 then
					require("fzf-lua").live_grep_glob({ cwd = root })
				else
					require("fzf-lua").live_grep_glob()
				end
			end,
			desc = "fzf native grep",
		},
		{
			"<leader>FU",
			function()
				local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
				if vim.v.shell_error == 0 then
					require("fzf-lua").grep_cword({ cwd = root })
				else
					require("fzf-lua").grep_cword()
				end
			end,
			desc = "fzf word under cursor",
		},
		{
			"<leader>FU",
			function()
				local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
				if vim.v.shell_error == 0 then
					require("fzf-lua").grep_visual({ cwd = root })
				else
					require("fzf-lua").grep_visual()
				end
			end,
			desc = "fzf visual selection",
			mode = "v",
		},
	},
	cmd = { "FzfLua" },
}
