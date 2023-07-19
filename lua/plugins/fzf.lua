return {
	"ibhagwan/fzf-lua",
	opts = {
		"default",
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
		{ "<leader>fl", ":FzfLua resume<CR>", desc = "fzf resume grep" },
		{
			"<leader>fp",
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
			"<leader>fg",
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
			"<leader>fg",
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
			"<leader>ff",
			function()
				local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
				if vim.v.shell_error == 0 then
					require("fzf-lua").live_grep_native({ cwd = root })
				else
					require("fzf-lua").live_grep_native()
				end
			end,
			desc = "fzf native grep",
		},
		{
			"<leader>fi",
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
			"<leader>fu",
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
			"<leader>fu",
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
		-- {
		-- 	"<leader>fY",
		-- 	function()
		-- 		vim.cmd('noau normal! vi""vy')
		-- 		local text = '(ctx, "' .. vim.fn.getreg("v") .. '", in, out,'
		-- 		local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
		-- 		if vim.v.shell_error == 0 then
		-- 			require("fzf-lua").grep({ search = text, cwd = root })
		-- 		else
		-- 			require("fzf-lua").grep({ search = text })
		-- 		end
		-- 	end,
		-- 	desc = "Telescope grpc string back",
		-- },
		-- {
		-- 	"<leader>fy",
		-- 	function()
		-- 		vim.cmd('noau normal! vi""vy')
		-- 		local text = 'FullMethod: "' .. vim.fn.getreg("v") .. '"'
		-- 		local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
		-- 		if vim.v.shell_error == 0 then
		-- 			require("fzf-lua").grep({ search = text, cwd = root })
		-- 		else
		-- 			require("fzf-lua").grep({ search = text })
		-- 		end
		-- 	end,
		-- 	desc = "Telescope grpc string",
		-- },
	},
	cmd = { "FzfLua" },
}
