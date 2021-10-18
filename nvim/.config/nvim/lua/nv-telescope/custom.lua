local M = {}
M.search_dotfiles = function()
  require("telescope.builtin").find_files({
    prompt_title = "DOTFILES",
    cwd = "/home/brian/.dotfiles/",
    hidden = true,
  })
end

return M
