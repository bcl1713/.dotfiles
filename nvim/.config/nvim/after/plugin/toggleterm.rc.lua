local status, terminal = pcall(require, "toggleterm.terminal")
if (not status) then
  print "toggleterm not installed"
  return
end

