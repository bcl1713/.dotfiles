local M = {}

function M.setup()
  require'lualine'.setup {
    options = {
      icons_enabled = true,
      theme = 'gruvbox'
    }
  }
end

return M
