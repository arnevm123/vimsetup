return {
	"nvim-lua/plenary.nvim",
	require("base.lsp"),
	require("base.telescope"),
	require("base.colorscheme"),
	require("base.treesitter"),
	require("arne.bufferline"),
	require("arne.lualine"),
	require("arne.debug"),
	require("arne.chatgpt"),
	require("arne.gitsigns"),
	require("arne.neogit"),
	require("arne.go"),
	require("arne.dial"),
	require("arne.neoclip"),
	require("arne.tpope"),
	require("arne.folke"),
	require("arne.theprimeagen"),
	require("arne.random"),
}

-- unused:
-- "ibhagwan/fzf-lua",
-- "nvim-telescope/telescope-smart-history.nvim",
-- "nvim-telescope/telescope-frecency.nvim",
-- -- cmp plugins
--  "hrsh7th/nvim-cmp", -- The completion plugin
--  "hrsh7th/cmp-buffer", -- buffer completions
--  "hrsh7th/cmp-path", -- path completions
--  "saadparwaiz1/cmp_luasnip", -- snippet completions
--  "hrsh7th/cmp-nvim-lsp",
--  "hrsh7th/cmp-nvim-lua",
-- --  "fatih/vim-go",
-- --  "lvimuser/lsp-inlayhints.nvim"
--
-- -- snippets
--  "L3MON4D3/LuaSnip", --snippet engine

-- LSP
--  "neovim/nvim-lspconfig", -- enable LSP
--  "williamboman/nvim-lsp-installer", -- simple to use language server installer

--"lewis6991/impatient.nvim", -- Make nvim load faster
-- "MunifTanjim/prettier.nvim",
-- "ThePrimeagen/git-worktree.nvim",
-- "nvim-treesitter/playground",
--  "leoluz/nvim-dap-go"
-- -- LSP
-- {
--     "VonHeikemen/lsp-zero.nvim",
--     dependencies = {
--         -- LSP Support
--         { "neovim/nvim-lspconfig" },
--         { "williamboman/mason.nvim" },
--         { "williamboman/mason-lspconfig.nvim" },
--
--         -- Autocompletion
--         { "hrsh7th/nvim-cmp" },
--         { "hrsh7th/cmp-buffer" },
--         { "hrsh7th/cmp-path" },
--         { "saadparwaiz1/cmp_luasnip" },
--         { "hrsh7th/cmp-nvim-lsp" },
--         { "hrsh7th/cmp-nvim-lua" },
--
--         -- Snippets
--         { "L3MON4D3/LuaSnip" },
--         { "rafamadriz/friendly-snippets" },
--
--         -- for formatters and linters
--         { "jose-elias-alvarez/null-ls.nvim" },
--    },
--     config = function() require("base.lspZero") end,
--     lazy = false,
-- },

-- {
-- 	"RRethy/vim-illuminate",
-- 	config = function()
-- 		require("arne.illuminate")
-- 	end,
-- },
