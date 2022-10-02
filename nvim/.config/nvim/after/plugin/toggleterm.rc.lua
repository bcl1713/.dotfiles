local status, terminal = pcall(require, "toggleterm")
if (not status) then
  print "toggleterm not installed"
  return
end

terminal.setup{}

