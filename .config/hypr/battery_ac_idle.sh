#!/usr/bin/env bash

# Timeouts (seconds)
BATTERY_LOCK=120
BATTERY_HIBERNATE=300
AC_LOCK=300
AC_HIBERNATE=600

# Detect AC power
AC=$(cat /sys/class/power_supply/AC/online 2>/dev/null || echo 0)

action="$1"

if [ "$AC" -eq 1 ]; then
    # On AC
    case "$action" in
        lock) 
            echo "AC: Locking screen with hyprlock"
            pidof hyprlock >/dev/null || hyprlock &
            ;;
        hibernate) 
            echo "AC: Hibernating system"
            systemctl hibernate
            ;;
    esac
else
    # On Battery
    case "$action" in
        lock) 
            echo "Battery: Locking screen with hyprlock"
            pidof hyprlock >/dev/null || hyprlock &
            ;;
        hibernate) 
            echo "Battery: Hibernating system"
            systemctl hibernate
            ;;
    esac
fi
