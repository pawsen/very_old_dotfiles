#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

# Tuilf�jet for at starte dbus(bruges fx til forward search med emacs)
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# tilføjet for at få automount til at virke
# D-Bus
 if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
        eval "$(dbus-launch --sh-syntax --exit-with-session)"
 fi

# tilføjet fordi jeg ikke bruger DE. xrdb indlæser bl.a font-indstillinger. -merge sikre at tidligere læste indstillinger ikke slettes når en ny fil indlæses

xrdb -merge ~/.Xresources         # update x resources db
xmodmap ~/.Xmodmaprc              # load change in keyboard layout

# xfsettingsd & # køres fra rc.lua
numlockx & # boot up with numlock

exec ck-launch-session awesome
# exec ck-launch-session  gnome-session --session=awesome
#exec ck-launch-session startxfce4
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
