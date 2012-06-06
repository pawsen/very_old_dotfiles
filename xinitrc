#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

# Tuilføjet for at starte dbus(bruges fx til forward search med emacs)
# if [ -d /etc/X11/xinit/xinitrc.d ]; then
#   for f in /etc/X11/xinit/xinitrc.d/*; do
#     [ -x "$f" ] && . "$f"
#   done
#   unset f
# fi

# tilføjet for at få automount til at virke
# D-Bus
 # if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
 #        eval "$(dbus-launch --sh-syntax --exit-with-session)"
 # fi

# tilføjet fordi jeg ikke bruger DE. xrdb indlæser bl.a font-indstillinger. -merge sikre at tidligere læste indstillinger ikke slettes når en ny fil indlæses
xrdb -merge ~/.Xresources         # update x resources db
xmodmap ~/.Xmodmaprc              # load change in keyboard layou

# Autostart settings
# Start the GNU Emacs daemon
[[ ! -r "/tmp/emacs${UID}/server" ]] && emacs --daemon &
xbindkeys &
numlockx & # boot up with numlock
# xfsettingsd & # køres fra rc.lua


if [[ $1 == "awesome" ]]
then
    wmname LG3D
    exec ck-launch-session dbus-launch awesome
elif [[ $1 == "xfce" ]]
then
    exec ck-launch-session startxfce4
else
    echo "Choose a window manager"
fi

#exec ck-launch-session dbus-launch gnome-session --session=awesome
#exec ck-launch-session dbus-launch gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice

