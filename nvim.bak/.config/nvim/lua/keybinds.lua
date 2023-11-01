local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = {}

-- Disable 'Space' key
map('n', '<Space>', '', opt)

map('n', 'GG', "<cmd>lua require('utils.term').git_commit_toggle()<CR>", opt)

-- Set 'Space' as leader
G.mapleader = ' '
