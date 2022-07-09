#!/bin/bash

# Desktop Setting
xinput --set-prop 'pointer:''Razer Razer Atheris - Mobile Gaming Mouse' 'libinput Accel Profile Enabled' 0, 1
xinput --set-prop 'pointer:''Razer Razer Atheris - Mobile Gaming Mouse' 'libinput Accel Speed' -0.88
xrandr --output DVI-D-1 --left-of HDMI-1

# Change rate speed
xset r rate 300 60

# Network Off on boot
nmcli networking off

exec xmonad

