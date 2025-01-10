return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	event = "VeryLazy",
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()
		harpoon:extend({
			UI_CREATE = function(cx)
				vim.keymap.set("n", "<esc>", "", { buffer = cx.bufnr })
				vim.keymap.set("n", "<C-c>", function()
					require("harpoon").ui:toggle_quick_menu()
				end, { buffer = cx.bufnr })

				vim.keymap.set("n", "<C-v>", function()
					harpoon.ui:select_menu_item({ vsplit = true })
				end, { buffer = cx.bufnr })

				vim.keymap.set("n", "<C-x>", function()
					harpoon.ui:select_menu_item({ split = true })
				end, { buffer = cx.bufnr })
				vim.keymap.set("n", "<C-t>", function()
					harpoon.ui:select_menu_item({ tabedit = true })
				end, { buffer = cx.bufnr })
			end,
		})
	end,
	keys = {
		{
			"<leader>hp",
			function()
				require("harpoon").ui:toggle_quick_menu(require("harpoon"):list(), { title = "" })
			end,
			desc = "harpoon quick menu",
		},
		{
			"<leader>ha",
			function()
				require("harpoon"):list():add()
			end,
			desc = "harpoon add file",
		},
		{
			"<F6>",
			function()
				require("harpoon"):list():select(1)
			end,
			desc = "harpoon file 1",
		},
		{
			"<F7>",
			function()
				require("harpoon"):list():select(2)
			end,
			desc = "harpoon file 2",
		},
		{
			"<F8>",
			function()
				require("harpoon"):list():select(3)
			end,
			desc = "harpoon file 3",
		},
		{
			"<F9>",
			function()
				require("harpoon"):list():select(4)
			end,
			desc = "harpoon file 4",
		},
		{
			"<F10>",
			function()
				require("harpoon"):list():select(5)
			end,
			desc = "harpoon file 5",
		},
	},
}
