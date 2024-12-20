return {
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
}
