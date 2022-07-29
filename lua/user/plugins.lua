local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
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
  augroup end
]])

-- Use a protected call so we don't error out on first use
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
	use({ "numToStr/Comment.nvim"})
	--use({ "JoosepAlviste/nvim-ts-context-commentstring"})
	use({ "kyazdani42/nvim-web-devicons"})
	use({ "kyazdani42/nvim-tree.lua"})
	use({ "akinsho/bufferline.nvim"})
	use({ "moll/vim-bbye"})
	use({ "nvim-lualine/lualine.nvim"})
	use({ "lewis6991/impatient.nvim"})
	use({ "lukas-reineke/indent-blankline.nvim"})
	use({ "goolord/alpha-nvim"})
	use("folke/which-key.nvim")

	-- Colorschemes
    use({"gruvbox-community/gruvbox"})
    use({"rktjmp/lush.nvim"})
    use({"mcchrish/zenbones.nvim"})
	use("lunarvim/darkplus.nvim")

	-- cmp plugins
	use({ "hrsh7th/nvim-cmp"}) -- The completion plugin
	use({ "hrsh7th/cmp-buffer"}) -- buffer completions
	use({ "hrsh7th/cmp-path"}) -- path completions
	use({ "saadparwaiz1/cmp_luasnip"}) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp"})
	use({ "hrsh7th/cmp-nvim-lua"})
	use({ "fatih/vim-go"})
 	use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}

	-- snippets
	use({ "L3MON4D3/LuaSnip"}) --snippet engine

	-- LSP
	use({ "neovim/nvim-lspconfig"}) -- enable LSP
	use({ "williamboman/nvim-lsp-installer"}) -- simple to use language server installer
	use({ "jose-elias-alvarez/null-ls.nvim"}) -- for formatters and linters
	use({ "ThePrimeagen/refactoring.nvim" }) -- for formatters and linters
    use({ "https://git.sr.ht/~whynothugo/lsp_lines.nvim" })
	-- Telescope
	use({ "nvim-telescope/telescope.nvim"})
    use { "nvim-telescope/telescope-file-browser.nvim" }
	-- Treesitter
    use({ "nvim-treesitter/nvim-treesitter", run=":TSInstall" })

	-- Git
	use({ "lewis6991/gitsigns.nvim"})
    use({ "sindrets/diffview.nvim"})
    use { 'TimUntersberger/neogit', requires ='sindrets/diffview.nvim', 'nvim-lua/plenary.nvim' }
    --comment out stuff
    use { 'numToStr/Comment.nvim' }
    use 'mg979/vim-visual-multi'

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
