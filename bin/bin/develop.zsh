#!/bin/zsh
i3-msg "workspace 2 dev"
sleep 0.1
i3-msg "exec kitty --directory '~/dev/associationof1a3s-web' --listen-on unix:/tmp/develop"
sleep 0.1
i3-msg "split horizontal"
sleep 0.1
i3-msg "workspace 4 serv"
sleep 0.1
i3-msg "exec kitty --directory '~/dev/associationof1a3s-web' --listen-on unix:/tmp/emulators"
sleep 0.1
i3-msg "split vertical"
sleep 0.1
i3-msg "exec kitty --directory '~/dev/associationof1a3s-web' --listen-on unix:/tmp/devserv"
sleep 0.1
i3-msg "workspace 2 dev"
sleep 0.1
i3-msg "exec chromium"
sleep 3
kitty @ --to unix:/tmp/develop send-text nvim$'\r'
kitty @ --to unix:/tmp/emulators send-text npm run emulators$'\r'
kitty @ --to unix:/tmp/devserv send-text npm run start$'\r'
sleep 6
i3-msg "focus left"
kitty @ --to unix:/tmp/develop send-text " ff"
