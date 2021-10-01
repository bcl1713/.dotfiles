local M = {}

function M.setup()
  require'lualine'.setup {
    options = {
      icons_enabled = false,
      theme = 'gruvbox'
    }
  }
end

return M
