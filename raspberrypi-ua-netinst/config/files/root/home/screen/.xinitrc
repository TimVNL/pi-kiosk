#!/bin/sh
while true; do
  xset s off         # don't activate screensaver
  xset -dpms         # disable DPMS (Energy Star) features.
  xset s noblank     # don't blank the video device
  # Allow quitting the X server with CTRL-ATL-Backspace
  setxkbmap -option terminate:ctrl_alt_bksp
  # Reset the framebuffer's colour-depth
  fbset -depth $( cat /sys/module/*fb*/parameters/fbdepth );
  # Hide the cursor (move it to the bottom-right, comment out if you want mouse interaction)
  xwit -root -warp $( cat /sys/module/*fb*/parameters/fbwidth ) $( cat /sys/module/*fb*/parameters/fbheight )
  # Start the window manager (remove "-use_cursor no" if you actually want mouse interaction)
  matchbox-window-manager -use_titlebar no -use_cursor no &
  # Start PiKiosk with offline check
  sed -i 's/"exited_cleanly": false/"exited_cleanly": true/' ~/.config/chromium/Default/Preferences
  chromium-browser --noerrdialogs --disable-tab-switcher --disable-session-crashed-bubble --app=https://google.com 
done
