#!/usr/bin/env bash

OPTIONS="Lock\nLogout\nReboot\nPoweroff\nSuspend\nHibernate"

LAUNCHER="rofi -width 15 -lines 6 -dmenu -i -p power"
LOCKER="i3lock-fancy-rapid 5 3"

option=`echo -e $OPTIONS | $LAUNCHER | awk '{print $1}' | tr -d '\r\n'`
if [ ${#option} -gt 0 ]; then
    case $option in
      Lock)
        $LOCKER
        ;;
      Logout)
        loginctl terminate-session ${XDG_SESSION_ID-}
        ;;
      Reboot)
        systemctl reboot
        ;;
      Poweroff)
        systemctl poweroff
        ;;
      Suspend)
        $LOCKER && systemctl suspend
        ;;
      Hibernate)
        $LOCKER && systemctl hibernate
        ;;
      *)
        ;;
    esac
fi
