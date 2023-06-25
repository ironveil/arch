#!/bin/bash

# Switch to user
su ironveil

# Get files & build yay
cd /tmp
git clone https://aur.archlinux.org/yay.git

cd yay
makepkg -si --noconfirm

# Install packages
yay -S --sudoloop --noconfirm visual-studio-code-bin waybar-hyprland-git firefox-nightly-bin linux-enable-ir-emitter howdy drawio-desktop-bin android-studio ttf-ms-fonts