#!/bin/bash

# Kill all current portals
sleep 1

killall -e xdg-desktop-portal-hyprland
killall xdg-desktop-portal

# Start the hyprland portal
/usr/lib/xdg-desktop-portal-hyprland &

sleep 2

/usr/lib/xdg-desktop-portal &