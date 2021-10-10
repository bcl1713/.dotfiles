require("harpoon").setup{}

CMD [[
nnoremap <leader>ha <cmd>lua require('harpoon.mark').add_file()<cr>
nnoremap <leader>hf <cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>
]]
