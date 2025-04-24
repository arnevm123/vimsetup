return {
	{
		"kevinhwang91/nvim-bqf",
		dependencies = { "junegunn/fzf" },
		ft = "qf",
		opts = {
			preview = {
				auto_preview = false,
				border = "single",
				show_title = false,
				show_scroll_bar = false,
				winblend = 0,
				win_height = 100,
			},
			filter = {
				fzf = { extra_opts = { "--bind", "ctrl-y:toggle-all" } },
			},
		},
	},
	{
		"stevearc/quicker.nvim",
		event = "FileType qf",
		---@module "quicker"
		---@type quicker.SetupOptions
		opts = {
			type_icons = {
				E = "󰅚 ",
				W = "󰀪 ",
				I = " ",
				N = " ",
				H = " ",
			},
			-- Border characters
			borders = {
				vert = "┃",
				-- Strong headers separate results from different files
				strong_header = "━",
				strong_cross = "╋",
				strong_end = "┫",
				-- Soft headers separate results within the same file
				soft_header = "╌",
				soft_cross = "╂",
				soft_end = "┨",
			},
		},
	},
}
