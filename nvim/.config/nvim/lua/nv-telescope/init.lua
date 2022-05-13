require('telescope').setup{}
require('telescope').load_extension "file_browser"

vim.api.nvim_set_keymap(
  "n",
  "<leader>fb",
  ":Telescope file_browser<cr>",
  { noremap = true }
  )

CMD [[
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>df <cmd>lua require('nv-telescope.custom').search_dotfiles()<cr>
]]
