#!/bin/bash

# Config files
CONFIG_FILES="$HOME/.config/waybar/config $HOME/.config/waybar/style.css"

# Restart if changes
while true; do
    waybar &
    inotifywait -e create,modify $CONFIG_FILES
    killall waybar
done