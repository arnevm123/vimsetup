return {
	"olexsmir/gopher.nvim",
	ft = { "go", "gomod" },
	dev = true,
	opts = {
		gotests = {
			template = "testify",
		},
	},
	keys = {
		{ "<leader>ee", ":GoIfErr<cr>" },
	},
}

-- "ray-x/go.nvim",
-- dependencies = { -- optional packages
-- 	"ray-x/guihua.lua",
-- 	"neovim/nvim-lspconfig",
-- 	"nvim-treesitter/nvim-treesitter",
-- },
-- config = function()
-- 	require("go").setup({
-- 		-- maybe set all to false
-- 		disable_defaults = false, -- true|false when true set false to all boolean settings and replace all table
-- 		dap_debug_keymap = false, -- true: use keymap for debugger defined in go/dap.lua
-- 		gotests_template = "testify",
-- 		-- false: do not use keymap in go/dap.lua.  you must define your own.
-- 		-- windows: use visual studio keymap
-- 		dap_debug_gui = false, -- set to true to enable dap gui, highly recommend
-- 		dap_debug_vt = false, -- set to false to enable dap virtual text
-- 		icons = false,
-- 		lsp_cfg = false, -- true: use non-default gopls setup specified in go/lsp.lua
-- 		lsp_gofumpt = false, -- true: set default gofmt in gopls format to gofumpt
-- 		lsp_on_attach = nil, -- nil: use on_attach function defined in go/lsp.lua,
-- 		lsp_keymaps = false, -- set to false to disable gopls/lsp keymap
-- 		lsp_codelens = false, -- set to false to disable codelens, true by default, you can use a function
-- 		textobjects = false,
-- 		luasnip = false, -- enable included luasnip snippets. you can also disable while add lua/snips folder to luasnip load
-- 		-- test_runner = "richgo", -- one of {`go`, `richgo`, `dlv`, `ginkgo`, `gotestsum`}
-- 		-- run_in_floaterm = true, -- set to true to run in float window. :GoTermClose closes the floatterm
-- 		lsp_inlay_hints = {
-- 			enable = true,
-- 		},
-- 	})
-- end,
-- -- event = { "CmdlineEnter" },
-- ft = { "go", "gomod" },
-- keys = {
-- 	{ "<leader>eb", ":GoDebug -t<cr>" },
-- 	{ "<leader>ee", ":GoIfErr<cr>" },
-- 	{ "<leader>er", ":GoGenReturn<cr>" },
-- 	{ "<leader>ot", ":GoAlt<CR>" },
-- },
-- build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
