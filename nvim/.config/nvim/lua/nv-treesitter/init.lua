local ts_config = require('nvim-treesitter.configs')

ts_config.setup {
  ensure_installed = {
    'lua',
    'cpp',
    'c',
    'java'
  },
  highlight = {
    enable = true,
    use_languagetree = true
  }
}
