return {
	{
		"maskudo/devdocs.nvim",
		event = "VeryLazy",
		dependencies = { "folke/snacks.nvim" },
		opts = {
			ensure_installed = {
				"go",
				"docker",
				"gnu_make",
				"python~3.13",
				"html",
				"lua~5.1",
			},
		},
		config = function(opts)
			require("devdocs").setup(opts)

			vim.api.nvim_create_user_command("DDocs", function()
				local devdocs = require("devdocs")
				local installedDocs = devdocs.GetInstalledDocs()

				vim.ui.select(installedDocs, {}, function(selected)
					if not selected then
						return
					end
					local docDir = devdocs.GetDocDir(selected)
					Snacks.picker.files({ cwd = docDir })
				end)

			end, { nargs = "*", desc = "Search using rg" })

		end,
	},
	{
		"fredrikaverpil/godoc.nvim",
		dependencies = {
			{ "folke/snacks.nvim" },
			{ "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = { "go" } } },
		},
		build = "go install github.com/lotusirous/gostdsym/stdsym@latest",
		cmd = { "GoDoc" }, -- optional
		opts = { picker = { type = "snacks" } },
	},
}
