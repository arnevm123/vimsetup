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
	-- {
	-- 	"cbochs/grapple.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim" },
	-- 	--stylua: ignore
	-- 	keys = {
	-- 		{ "<leader>a", function() require("grapple").tag() end, desc = "grapple add file" },
	-- 		{ "<leader>A", function() require("grapple").tag() end, desc = "grapple add file" },
	-- 		{ "<leader>-", function() require("grapple").popup_tags() end, desc = "grapple quick menu" },
	-- 		{ "<leader>_", function() require("grapple").popup_tags() end, desc = "grapple quick menu" },
	-- 		{ "<C-h>", function() require("grapple").select({ key = "1" }) end, desc = "grapple file 1" },
	-- 		{ "<C-j>", function() require("grapple").select({ key = "2" }) end, desc = "grapple file 1" },
	-- 		{ "<C-k>", function() require("grapple").select({ key = "3" }) end, desc = "grapple file 1" },
	-- 		{ "<C-l>", function() require("grapple").select({ key = "4" }) end, desc = "grapple file 1" },
	-- 		{ "<C-;>", function() require("grapple").select({ key = "5" }) end, desc = "grapple file 1" },
	-- 	},
	-- },
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
		event = "BufEnter",
		--stylua: ignore
		keys = {
			{ "<leader>a", function() require("harpoon.mark").add_file() end, desc = "harpoon add file" },
			{ "<leader>-", function() require("harpoon.ui").toggle_quick_menu() end, desc = "harpoon quick menu" },
			{ "<leader>_", function() require('telescope').extensions.harpoon.marks() end, desc = "harpoon quick menu" },
			{ "<C-h>", function() require("harpoon.ui").nav_file(1) end, desc = "harpoon file 1" },
			{ "<C-j>", function() require("harpoon.ui").nav_file(2) end, desc = "harpoon file 2" },
			{ "<C-k>", function() require("harpoon.ui").nav_file(3) end, desc = "harpoon file 3" },
			{ "<C-l>", function() require("harpoon.ui").nav_file(4) end, desc = "harpoon file 4" },
			{ "<C-;>", function() require("harpoon.ui").nav_file(5) end, desc = "harpoon file 5" },
		},
	},
}
