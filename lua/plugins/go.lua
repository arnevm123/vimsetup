return {
	"olexsmir/gopher.nvim",
	ft = { "go", "gomod" },
	branch = "develop",
	config = function()
		local opts = {
			gotests = {
				template = "testify",
			},
			commands = {
				iferr = "ierr -message 'test'",
			},
		}
		require("gopher").setup(opts)
	end,
	keys = {
		{ "<leader>ee", ":GoIfErr<CR>", desc = "Go if err" },
		{
			"<leader>en",
			function()
				local var = vim.fn.expand("<cword>")
				vim.api.nvim_input("o" .. "_ = " .. var .. "<esc>^")
			end,
			desc = "Go empty assign",
		},
	},
}
