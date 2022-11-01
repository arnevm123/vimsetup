local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
-- Automatically install packe
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end ]]) -- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use({ "wbthomason/packer.nvim"}) -- Have packer manage itself
    use({ "nvim-lua/plenary.nvim"}) -- Useful lua functions used by lots of plugins
    use({ "lewis6991/impatient.nvim" }) -- Make nvim load faster
    use({ "kyazdani42/nvim-web-devicons"}) -- Nerd font helper
    use({ "kyazdani42/nvim-tree.lua"}) -- File tree
    -- use({ "akinsho/bufferline.nvim"}) -- Show buffer names at top
    use({ "nvim-lualine/lualine.nvim"}) -- Line at bottom with info
    -- use({ "lukas-reineke/indent-blankline.nvim"}) --show function lines & context
    -- use({ "goolord/alpha-nvim"}) -- Start screen
    use("folke/which-key.nvim") -- Show help for keycombos
    use("ellisonleao/glow.nvim") -- Markdown file viewer

    -- Colorschemes
    --
    use("xiyaowong/nvim-transparent") -- remove background
    use { "mcchrish/zenbones.nvim", requires = "rktjmp/lush.nvim" }
use({ "atelierbram/Base2Tone-nvim" })

    -- cmp plugins
    use({ "hrsh7th/nvim-cmp"}) -- The completion plugin
    use({ "hrsh7th/cmp-buffer"}) -- buffer completions
    use({ "hrsh7th/cmp-path"}) -- path completions
    use({ "saadparwaiz1/cmp_luasnip"}) -- snippet completions
    use({ "hrsh7th/cmp-nvim-lsp"})
    use({ "hrsh7th/cmp-nvim-lua"})
    -- use({ "fatih/vim-go"})
    use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}

    -- snippets
    use({ "L3MON4D3/LuaSnip"}) --snippet engine

    -- LSP
    use({ "neovim/nvim-lspconfig"}) -- enable LSP
    use({ "williamboman/nvim-lsp-installer"}) -- simple to use language server installer
    use({ "jose-elias-alvarez/null-ls.nvim"}) -- for formatters and linters
    use({ "ThePrimeagen/refactoring.nvim" }) -- for formatters and linters
    use({ "ThePrimeagen/harpoon" }) -- for formatters and linters
    use({ "ThePrimeagen/git-worktree.nvim" }) -- for formatters and linters
    use({'ray-x/go.nvim'})
    use({'ray-x/guihua.lua'})
    -- Telescope
    use { "kkharji/sqlite.lua" }
    use { "nvim-telescope/telescope-file-browser.nvim" }
    use { "nvim-telescope/telescope.nvim"}
    use { "nvim-telescope/telescope-smart-history.nvim" }
    use "nvim-telescope/telescope-frecency.nvim"
    -- Treesitter
    use("nvim-treesitter/nvim-treesitter", {
        run = ":TSUpdate"
    })
    use({ "nvim-treesitter/nvim-treesitter-context" })
    use({ "nvim-treesitter/nvim-treesitter-textobjects" })
    use({ "nvim-treesitter/playground" })
    -- Git
    use({ "lewis6991/gitsigns.nvim"})
    use({ "sindrets/diffview.nvim"})
    use { 'TimUntersberger/neogit', requires ='sindrets/diffview.nvim'}


    -- Various
    use { 'numToStr/Comment.nvim' }
    use({ "monaqa/dial.nvim" })
    use({ "machakann/vim-swap" })
    use({ "tommcdo/vim-exchange" })
    use({ "RRethy/vim-illuminate",
        config = function()
            require('illuminate').configure({
                providers = { 'lsp', 'treesitter', 'regex', },
                delay = 0,
                filetype_overrides = {},
                filetypes_denylist = { 'dirvish', 'fugitive' },
                filetypes_allowlist = {},
                modes_denylist = {},
                modes_allowlist = {},
                providers_regex_syntax_denylist = {},
                providers_regex_syntax_allowlist = {},
                under_cursor = true,
                max_file_lines = nil,
            })
        end
    })

    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })

    -- Not using these right now, might figure these out later.
    use 'mfussenegger/nvim-dap'
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
    -- use 'leoluz/nvim-dap-go'
    use 'theHamsta/nvim-dap-virtual-text'

    -- Database
    use {
        "tpope/vim-dadbod",
        opt = true,
        requires = {
            "kristijanhusak/vim-dadbod-ui",
            "kristijanhusak/vim-dadbod-completion",
        },
        config = function()
            require("config.dadbod").setup()
        end,
        cmd = { "DBUIToggle", "DBUI", "DBUIAddConnection", "DBUIFindBuffer", "DBUIRenameBuffer", "DBUILastQueryInfo" },
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
