local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

-- load lazy
require("lazy").setup("base.lazyPlugins", {
	defaults = { lazy = true },
	ui = {
		icons = {
			cmd = "⌘",
			config = "",
			event = "",
			ft = "",
			init = "",
			keys = "",
			plugin = "",
			runtime = "",
			source = "",
			start = "",
			task = "",
			lazy = " ",
		},
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	debug = false,
})
