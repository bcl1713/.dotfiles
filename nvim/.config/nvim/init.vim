call plug#begin(stdpath('data') . '/plugged')

  "Gruvbox is pretty 
  Plug 'gruvbox-community/gruvbox'
  
  "LSP Plugins
  Plug 'mfussenegger/nvim-jdtls'
  Plug 'hrsh7th/nvim-compe'
  Plug 'onsails/lspkind-nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'tami5/lspsaga.nvim'
  
  "Gitgutter
  Plug 'airblade/vim-gitgutter'
  
  "Pandoc Previewer
  Plug 'davidgranstrom/nvim-markdown-preview'

  "Lualine
  Plug 'hoob3rt/lualine.nvim'
  Plug 'ryanoasis/vim-devicons'
  Plug 'kyazdani42/nvim-web-devicons'

  "Treesitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  "Telescope
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  
  "Discord Presence
  Plug 'andweeb/presence.nvim'

  "Fugitive for Git
  Plug 'tpope/vim-fugitive'

call plug#end()

lua require'mylualine'.setup()

set guicursor=
set number relativenumber
set nohlsearch incsearch
set colorcolumn=80
set splitright
set splitbelow
set expandtab
set autoindent
set cindent
set tabstop=2 softtabstop=2 shiftwidth=2
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set termguicolors
set scrolloff=8
set signcolumn=yes
set cmdheight=1
set updatetime=50

nnoremap <SPACE> <Nop>
let mapleader=" "

augroup jdtls_lsp
    autocmd!
    autocmd FileType java lua require'java'.setup()
augroup end

"set background=dark
colorscheme gruvbox

nnoremap <silent>gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>
nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
nnoremap <silent><leader>k <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
nnoremap <silent>gs :Lspsaga signature_help<CR>
nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
nnoremap <leader>fb <cmd>Telescope buffers<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<CR>
nnoremap <leader>df <cmd> Telescope find_files hidden=true search_dirs=~/.dotfiles<CR>
