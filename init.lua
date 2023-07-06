require("base.options")
require("base.lazy").setup({
	require("base.lsp"),
	require("base.telescope"),
	require("base.fzf"),
	require("base.colorscheme"),
	require("base.treesitter"),
	require("arne.lualine"),
	require("arne.go"),
	require("arne.debug"),
	require("arne.gitsigns"),
	require("arne.neogit"),
	require("arne.dial"),
	require("arne.neoclip"),
	require("arne.testing"),
	require("arne.dbee"),
	require("arne.oil"),
	require("arne.illuminate"),
	require("arne.random"),
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

require("base.setupColorscheme").Setup()
