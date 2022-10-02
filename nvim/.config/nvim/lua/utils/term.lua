local M = {}

local Terminal = require("toggleterm.terminal").Terminal

local git_cz = "cit cz"


local git_commit = Terminal:new {
  cmd = git_cz,
  dir = "git_dir",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "double",
  },
}

function M.git_commit_toggle()
  git_commit:toggle()
end

return M
