return {

    "nvim-lua/plenary.nvim", -- Useful lua functions used by lots of plugins
    --"lewis6991/impatient.nvim", -- Make nvim load faster
    "kyazdani42/nvim-web-devicons", -- Nerd font helper
    "akinsho/bufferline.nvim", -- Show buffer names at top
    "nvim-lualine/lualine.nvim", -- Line at bottom with info
    "folke/which-key.nvim", -- Show help for keycombos

    -- Colorschemes
    --
    { "mcchrish/zenbones.nvim", dependencies = { "rktjmp/lush.nvim" } },
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
        }
    },
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

    "jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
    "MunifTanjim/prettier.nvim",
    "ThePrimeagen/refactoring.nvim",
    "ThePrimeagen/harpoon",
    "ThePrimeagen/git-worktree.nvim",
    "ray-x/go.nvim",
    "ray-x/lsp_signature.nvim",
    "ray-x/guihua.lua",
    -- Debugger
    "mfussenegger/nvim-dap",
    { "rcarriga/nvim-dap-ui", dependencies = "mfussenegger/nvim-dap" },
    --  "leoluz/nvim-dap-go"
    "theHamsta/nvim-dap-virtual-text",
    -- Telescope
    "kkharji/sqlite.lua",
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-smart-history.nvim",
    "nvim-telescope/telescope-frecency.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-dap.nvim",

    -- Treesitter
    { "nvim-treesitter/nvim-treesitter" },
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/playground",
    -- Git
    "lewis6991/gitsigns.nvim",
    "sindrets/diffview.nvim",
    { "TimUntersberger/neogit", dependencies = "sindrets/diffview.nvim" },


    -- Various
    "numToStr/Comment.nvim",
    "monaqa/dial.nvim",
    "machakann/vim-swap",
    "tommcdo/vim-exchange",
    "RRethy/vim-illuminate",
    "mbbill/undotree",
    {
        "danymat/neogen",
        config = function()
            require("neogen").setup({})
        end,
        dependencies = "nvim-treesitter/nvim-treesitter",
        -- Uncomment next line if you want to follow only stable versions
        -- tag = "*"
    },

    "kylechui/nvim-surround",

    {
        "Wansmer/treesj",
        dependencies = { "nvim-treesitter" },
    },

    { "AckslD/nvim-neoclip.lua", dependencies = { { "kkharji/sqlite.lua" } } },

    -- Database
    {
        "tpope/vim-dadbod",
        dependencies = {
            "kristijanhusak/vim-dadbod-ui",
            "kristijanhusak/vim-dadbod-completion",
        },
        cmd = { "DBUIToggle", "DBUI", "DBUIAddConnection", "DBUIFindBuffer", "DBUIRenameBuffer", "DBUILastQueryInfo" },
    },

    "Everduin94/nvim-quick-switcher",
    "chrisbra/csv.vim",
    -- "ibhagwan/fzf-lua",

    {
        "jackMort/ChatGPT.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        }
    },
}
