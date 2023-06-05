# If you do not want X11 to be launched at startup, comment the line below.
[ "$(tty)" = "/dev/tty1" ] && exec startx
