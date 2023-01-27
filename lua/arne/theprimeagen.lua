return {
	{
		"ThePrimeagen/refactoring.nvim",
		opts = {
			-- overriding printf statement for cpp
			print_var_statements = {
				-- add a custom print var statement for cpp
				ts = {
					"console.log(%s)",
				},
				js = {
					"console.log(%s)",
				},
			},
		},
		--stylua: ignore
		keys = {
			{ "<leader>ek", function() require('refactoring').debug.printf({below = true})end, desc="Refactoring printf" },
			{ "<leader>ev", function() require('refactoring').debug.print_var({ normal = true })end, desc="Refactoring print var" },
			{ "<leader>ev", function() require('refactoring').debug.print_var({})end, desc="Refactoring print var" },
			{ "<leader>ec", function() require('refactoring').debug.cleanup({})end, desc="Refactoring cleanup" },
			{ "<leader>lg", ":lua require('telescope').extensions.refactoring.refactors()<CR>", desc = "lsp refactoring" },
		},
	},
	{
		"ThePrimeagen/harpoon",
		config = {
			save_on_toggle = false,
			save_on_change = true,
			enter_on_sendcmd = true,
			tmux_autoclose_windows = false,
			excluded_filetypes = { "harpoon" },
			mark_branch = true,
		},
		lazy = false,
		--stylua: ignore
		keys = {
			{ "<leader>a", function() require("harpoon.mark").add_file() end, desc = "harpoon add file" },
			{ "<leader>-", function() require("harpoon.ui").toggle_quick_menu() end, desc = "harpoon quick menu" },
			{ "<C-h>", function() require("harpoon.ui").nav_file(1) end, desc = "harpoon file 1" },
			{ "<C-j>", function() require("harpoon.ui").nav_file(2) end, desc = "harpoon file 2" },
			{ "<C-k>", function() require("harpoon.ui").nav_file(3) end, desc = "harpoon file 3" },
			{ "<C-l>", function() require("harpoon.ui").nav_file(4) end, desc = "harpoon file 4" },
			{ "<C-;>", function() require("harpoon.ui").nav_file(5) end, desc = "harpoon file 5" },
		},
	},
}
