local status, terminal = pcall(require, "toggleterm")
if (not status) then
  print "toggleterm not installed"
  return
end

terminal.setup{
  direction = 'float',
  close_on_exit = true,
  float_opts = {
    border = 'single',
  },
}
