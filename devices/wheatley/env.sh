#!/bin/bash

CWD=/mnt/etc/environment

# Set editor
echo "EDITOR=nvim" >> $CWD

# Enable Firefox wayland
echo "MOZ_ENABLE_WAYLAND=1" >> $CWD

# Set GTK theme
echo "GTK_THEME=Catppuccin-Mocha-Standard-Mauve-Dark" >> $CWD

# Set SSH & GPG settings
echo 'SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gcr/ssh' >> $CWD
echo 'GPG_TTY=$(tty)' >> $CWD

# Disable OpenCV warnings
echo "OPENCV_LOG_LEVEL=ERROR" >> $CWD