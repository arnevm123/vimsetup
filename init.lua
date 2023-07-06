require("base.options")
require("base.lazy").setup({
	require("base.treesitter"),
	require("base.lsp"),
	require("base.telescope"),
	require("base.fzf"),
	require("base.colorscheme"),
	require("arne.dbee"),
	require("arne.debug"),
	require("arne.dial"),
	require("arne.git"),
	require("arne.go"),
	require("arne.lualine"),
	require("arne.oil"),
	require("arne.plugins"),
}, {
	defaults = { lazy = true },
	performance = { rtp = { disabled_plugins = { "gzip", "matchit", "tarPlugin", "tohtml", "tutor", "zipPlugin" } } },
	ui = { border = "rounded", title = "Lazy" },
})

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		require("base.keymaps")
		require("base.autocommand")
	end,
})

require("base.setupColorscheme").Setup("mellifluous")
