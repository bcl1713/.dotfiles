local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  --Packer
  use 'wbthomason/packer.nvim'

  --Pencil
  use 'preservim/vim-pencil'

  --Markdown Preview
  use ({
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
    })

  --Gruvbox
  use 'gruvbox-community/gruvbox'

  --Nord
  use 'arcticicestudio/nord-vim'

  --LSP Stuffs
  use 'MunifTanjim/prettier.nvim' -- Prettier plugin for Neovim's built-in LSP client
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'mfussenegger/nvim-jdtls'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'rafamadriz/friendly-snippets'
  use 'onsails/lspkind-nvim'
  use 'neovim/nvim-lspconfig'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'jose-elias-alvarez/nvim-lsp-ts-utils'
  use 'tami5/lspsaga.nvim'

  --Trouble
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
  }

  --Git stuffs
  use 'airblade/vim-gitgutter'
  use 'tpope/vim-fugitive'

  --Bracket completion
  use 'jiangmiao/auto-pairs'
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'


  --Lualine
  use 'hoob3rt/lualine.nvim'
  use 'ryanoasis/vim-devicons'
  use 'kyazdani42/nvim-web-devicons'

  --Bufferline
  use 'akinsho/nvim-bufferline.lua'


  --Treesitter
  use {'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'}

  --Telescope
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'

  --Harpoon
  use 'ThePrimeagen/harpoon'

  --Plyglot
  use 'sheerun/vim-polyglot'

  --CloseTags
  --use 'alvan/vim-closetag'

  --Discord
  use 'andweeb/presence.nvim'

end)
