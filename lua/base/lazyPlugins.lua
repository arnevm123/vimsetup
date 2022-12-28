return {
    -- Useful lua functions used by lots of plugins
    "nvim-lua/plenary.nvim",
    -- Nerd font helper
    "kyazdani42/nvim-web-devicons",
    {
        "akinsho/bufferline.nvim",
        config = function() require("arne.bufferline") end,
        lazy = false,
    },
    {
        "nvim-lualine/lualine.nvim",
        config = function() require("arne.lualine") end,
        lazy = false,
    },
    {
        -- Show help for keycombos
        "folke/which-key.nvim",
        config = function() require("arne.whichkey") end,
        lazy = false,
    },

    -- Colorschemes
    {
        "mcchrish/zenbones.nvim",
        dependencies = { "rktjmp/lush.nvim" },
    },
    -- LSP
    {
        "VonHeikemen/lsp-zero.nvim",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },

            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },

            -- for formatters and linters
            { "jose-elias-alvarez/null-ls.nvim" },
        },
        config = function() require("base.lspZero") end,
        lazy = false,
    },
    -- Function signature when typing
    {
        -- stuff that tells function parameters
        "ray-x/lsp_signature.nvim",
        config = function() require("arne.lspSignature") end,
        lazy = false,
    },


    -- Be fast
    "ThePrimeagen/refactoring.nvim",
    {
        "ThePrimeagen/harpoon",
        config = function() require("arne.harpoon") end,
    },

    -- Debugger
    "mfussenegger/nvim-dap",
    {
        "rcarriga/nvim-dap-ui",
        dependencies = "mfussenegger/nvim-dap",
    },

    "nvim-telescope/telescope-dap.nvim",
    "theHamsta/nvim-dap-virtual-text",

    -- Telescope
    "kkharji/sqlite.lua",
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope.nvim",
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },

    -- Treesitter
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter-context",
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        keys = { "v", "d", "y" },
    },
    -- Git
    {
        "lewis6991/gitsigns.nvim",
        config = function() require("arne.gitsigns") end,
        lazy = false
    },
    {
        "TimUntersberger/neogit",
        cmd = "Neogit",
        config = function() require("arne.neogit") end,
        dependencies = "sindrets/diffview.nvim"
    },

    -- Golang
    {
        "ray-x/go.nvim",
        dependencies = {
            "ray-x/guihua.lua",
        },
        ft = "go",
        config = function() require("arne.go") end,
    },
    -- Various
    {
        "numToStr/Comment.nvim",
        config = function() require("arne.comment") end,
        keys = { "gc", "gb" },
    },
    {
        "monaqa/dial.nvim",
        keys = { "<C-a>", "<C-x>" },
        config = function() require("arne.dial") end,
    },
    {
        "tommcdo/vim-exchange",
        keys = { { "S", mode = "v" }, "cx" },
    },
    {
        "RRethy/vim-illuminate",
        config = function() require("arne.illuminate") end,
        lazy = false,
    },
    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
    },
    {
        "Wansmer/treesj",
        dependencies = "nvim-treesitter/nvim-treesitter",
        cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
        config = function() require("treesj").setup({ use_default_keymaps = false }) end,
    },

    -- Database
    {
        "tpope/vim-dadbod",
        dependencies = {
            "kristijanhusak/vim-dadbod-ui",
            "kristijanhusak/vim-dadbod-completion",
        },
        cmd = { "DBUIToggle", "DBUI", "DBUIAddConnection", "DBUIFindBuffer", "DBUIRenameBuffer", "DBUILastQueryInfo" },
    },

    -- General functionality
    "Everduin94/nvim-quick-switcher",
    {
        "AckslD/nvim-neoclip.lua",
        dependencies = { { "kkharji/sqlite.lua" } },
        lazy = false,
        config = function() require("arne.neoclip") end,
    },
    {
        "danymat/neogen",
        config = function()
            require("neogen").setup({})
        end,
        dependencies = "nvim-treesitter/nvim-treesitter",
    },
    {
        "kylechui/nvim-surround",
        config = true,
        keys = { "ds", "cs", "ys", { "S", mode = "v" }, { "gS", mode = "v" } },
    },
    {
        "tpope/vim-unimpaired",
        keys = { "[", "]", "yo" },
    },
    {
        "chrisbra/csv.vim",
        ft = "csv",
    },
    {
        "jackMort/ChatGPT.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        config = function() require("arne.chatgpt") end,
        cmd = { "ChatGPT", "ChatGPTActAs", "ChatGPTEditWithInstructions", "ChatGPTRun" },
    },
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
