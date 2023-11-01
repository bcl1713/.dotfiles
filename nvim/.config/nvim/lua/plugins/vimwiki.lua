return {
  "vimwiki/vimwiki",
  keys = {
    { "<leader>ww", "<cmd>VimwikiIndex<cr>", desc = "Vimwiki Index" },
    { "<C-Space>", "<cmd>VimwikiToggleListItem<cr>", desc = "Toggle TODO" },
  },
  init = function()
    vim.g.vimwiki_list = { { path = "/home/brian/Documents/wiki", syntax = "markdown", ext = ".md" } }
  end,
}
