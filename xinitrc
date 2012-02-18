#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

# Always start X11 with a clean log file
if (cp /dev/null "${errorlog}"); then
  chmod 600 "${errorlog}"
  exec >"${errorlog}" 2>&1
  break
fi

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# tiløjet for at få automount til at virke
# D-Bus
if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
       eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi

# Resource and keymap settings
# tilføjet fordi jeg ikke bruger DE. xrdb indlæser bl.a font-indstillinger. -merge sikre at tidligere læste indstillinger ikke slettes når en ny fil indlæses
xrdb -merge ${HOME}/.Xresources         # update x resources db
xmodmap ${HOME}/.Xmodmaprc              # load change in keyboard layout

# Autostart settings
# Start the GNU Emacs daemon
[[ ! -r "/tmp/emacs${UID}/server" ]] && emacs --daemon &
xbindkeys &

#exec gnome-session
exec ck-launch-session gnome-session
#exec ck-launch-session dbus-launch gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
