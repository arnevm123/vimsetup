return {
	{
		"folke/snacks.nvim",
		lazy = false,
		---@type snacks.Config
		dependencies = {
			{
				"dmtrKovalenko/fff.nvim",
				build = "cargo build --release",
				lazy = false,
				opts = {
					prompt = "> ",
					layout = {
						width = 1,
						height = 1,
						prompt_position = "top",
						preview_position = "top",
					},
				},
			},
			{ "madmaxieee/fff-snacks.nvim", cmd = "FFFSnacks", config = true },
		},
		opts = {
			zen = { enabled = false },
			words = { enabled = false },
			scroll = { enabled = false },
			indent = { enabled = false },
			animate = { enabled = false },
			notifier = { enabled = false },
			statuscolumn = { enabled = false },
			picker = {
				enabled = true,
				sources = {
					select = {
						config = function(opts)
							local max = math.floor(vim.o.lines * 0.8 - 10)
							-- Hack: this is to work around these two issues
							-- https://github.com/folke/snacks.nvim/issues/2035
							-- https://github.com/folke/snacks.nvim/issues/902#issuecomment-2649284650
							-- the vscode layout has an extra 0.5 of height, so we take the existing max
							-- and use that
							opts.layout.layout.height = math.min(max, opts.layout.layout.height + 0.5)
						end,
						layout = {
							preset = "bottom",
						},
					},
				},
				layouts = { ivy_split = { layout = { height = 0.25 } } },
				layout = { preset = "ivy_split" },
			},
			bigfile = { enabled = true },
			quickfile = { enabled = true },
		},
		keys = {
			{ "<leader>gb", "<cmd>lua Snacks.git.blame_line() <CR>", desc = "Git Blame Line" },
			{ "<leader>gB", "<cmd>lua Snacks.gitbrowse()<CR>", desc = "Git Browse" },
			{ "]r", "<cmd>lua Snacks.words.jump(vim.v.count1)<CR>", desc = "Next Reference" },
			{ "[r", "<cmd>lua Snacks.words.jump(-vim.v.count1)<CR>", desc = "Prev Reference" },
			{
				"yor",
				function()
					if Snacks.words.is_enabled() then
						Snacks.words.disable()
					else
						Snacks.words.enable()
						vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(":<Esc>", true, false, true), "n", false)
					end
				end,
				desc = "toggle lsp words",
			},
			{ "<leader>ff", "<cmd>lua Snacks.picker.resume()<CR>", desc = "Resume picker" },
			{ "<leader>fd", "<cmd>FFFSnacks <cr>", desc = "Find files" },
			{ "<leader>fs", "<cmd>lua Snacks.picker.grep()<CR>", desc = "Live grep" },
			{
				"<leader>fo",
				function()
					Snacks.picker.recent({
						filter = {
							cwd = true,
							filter = function(item)
								return vim.fn.isdirectory(item.file) == 0
							end,
						},
					})
				end,
				desc = "Old files",
			},
			{ "<leader>f/", "<cmd>lua Snacks.picker.lines()<CR>", desc = "Buffer lines" },
			{ "<leader>fh", "<cmd>lua Snacks.picker.help()<CR>", desc = "Help tags" },
			{ "<leader>fk", "<cmd>lua Snacks.picker.keymaps()<CR>", desc = "Keymaps" },
			{
				"<leader>fu",
				"<cmd>lua Snacks.picker.grep_word()<CR>",
				desc = "Visual selection or word",
				mode = { "n", "x" },
			},
			{ "<leader>ft", "<cmd>lua Snacks.picker()<CR>", desc = "Pickers list" },
			{ "<leader>fj", "<cmd>lua Snacks.picker.jumps()<CR>", desc = "Jumps" },
			{ "<leader>bb", "<cmd>lua Snacks.picker.buffers()<CR>", desc = "Buffers" },
			{
				"<leader>fis",
				'<cmd>lua Snacks.picker.grep({ cwd = vim.fn.expand("%:h") })<CR>',
				desc = "Live grep dir",
			},
			{
				"<leader>fid",
				'<cmd>lua Snacks.picker.files({ cwd = vim.fn.expand("%:h") })<CR>',
				desc = "Find files in dir",
			},
			{
				"<leader>fp",
				function()
					local text = vim.fn.getreg("+")
					if not text or text == "" then
						vim.notify("No text in register", vim.log.levels.ERROR)
						return
					end
					text = text:match("([^\n]+)")
					text = text and vim.trim(text) or ""
					Snacks.picker.files({ default_text = text, hidden = true })
				end,
				desc = "Find copied file",
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					Snacks.toggle.diagnostics():map("yoe")
				end,
			})
		end,
	},
}
