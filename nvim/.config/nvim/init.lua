-- Basics
require 'global'
require 'settings'
require 'keybinds'
require 'plugins'

-- Theme
require 'nv-theme'

-- Autopairs
require 'nv-autopairs'

-- Lualine
require 'nv-lualine'

-- Compe
require 'nv-compe'

-- LSP
require 'nv-lspconfig'

-- Snippets
require 'nv-vsnip'

-- Telescope
require 'nv-telescope'

-- Harpoon
require 'nv-harpoon'

-- Treesitter
require 'nv-treesitter'

-- jdtls ugliness
CMD [[
augroup jdtls
autocmd!
autocmd FileType java lua require'nv-jdtls'
augroup end
]]
