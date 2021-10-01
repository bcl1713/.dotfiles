call plug#begin(stdpath('data') . '/plugged')

	Plug 'gruvbox-community/gruvbox'
	Plug 'mfussenegger/nvim-jdtls'
        Plug 'hrsh7th/nvim-compe'
        Plug 'onsails/lspkind-nvim'
        Plug 'neovim/nvim-lspconfig'
        Plug 'tami5/lspsaga.nvim'
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
        Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
        Plug 'nvim-lua/plenary.nvim'
        Plug 'nvim-telescope/telescope.nvim'
        Plug 'andweeb/presence.nvim'

call plug#end()

set number relativenumber
set nohlsearch incsearch
set colorcolumn=80
set splitright
set splitbelow
set expandtab
set autoindent
set cindent
set softtabstop=2 shiftwidth=2

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
