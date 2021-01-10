#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
# while pgrep -u $UID -x polybar >/dev/null  sleep 1 end

# Launch Polybar, using default config location ~/.config/polybar/config
polybar i3wm
