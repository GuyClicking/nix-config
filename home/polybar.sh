#!/bin/bash

# Terminate already running bar instences
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar
polybar -rq wm_left &
polybar -rq wm_right &
polybar -rq time &
