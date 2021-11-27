return require('packer').startup(function(use)

  --Packer
  use 'wbthomason/packer.nvim'

  --Gruvbox
  use 'gruvbox-community/gruvbox'

  --LSP Stuffs
  use 'mfussenegger/nvim-jdtls'
  use 'hrsh7th/nvim-compe'
  use 'hrsh7th/vim-vsnip'
  use 'onsails/lspkind-nvim'
  use 'neovim/nvim-lspconfig'
  use 'tami5/lspsaga.nvim'

  --Git stuffs
  use 'airblade/vim-gitgutter'
  use 'tpope/vim-fugitive'

  --Bracket completion
  use 'jiangmiao/auto-pairs'
  use 'windwp/nvim-autopairs'

  --Pandoc Previewer
  use {'iamcco/markdown-preview.nvim',
        run = 'cd app && yarn install'}

  --Lualine
  use 'hoob3rt/lualine.nvim'
  use 'ryanoasis/vim-devicons'
  use 'kyazdani42/nvim-web-devicons'

  --Treesitter
  use {'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'}

  --Telescope
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-telescope/telescope.nvim'

  --Harpoon
  use 'ThePrimeagen/harpoon'

  --Discord
  use 'andweeb/presence.nvim'

  --Autosource
  use {'jenterkin/vim-autosource',
        config ='require(nv-autosource)'}


end)
