#!/usr/bin/env bash

OPTIONS="Lock\nLogout\nReboot\nPoweroff\nSuspend\nHibernate"

LAUNCHER="rofi -dmenu -i -p power -theme-str 'listview {lines: 6;} window {width: 300px;}' -dpi 0"

option=`echo -e $OPTIONS | eval "$LAUNCHER" | awk '{print $1}' | tr -d '\r\n'`
if [ ${#option} -gt 0 ]; then
    case $option in
      Lock)
        xflock4
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
        systemctl suspend
        ;;
      Hibernate)
        systemctl hibernate
        ;;
      *)
        ;;
    esac
fi
