#!/bin/bash

# Pacstrap
echo "--> Installing packages..."

pacstrap /mnt base base-devel linux-zen linux-zen-headers linux-firmware btrfs-progs networkmanager wpa_supplicant dhcpcd neovim nvidia-dkms intel-ucode go git curl wget gdm gnome-backgrounds gnome-color-manager gnome-console gnome-control-center gnome-disk-utility gnome-keyring libgnome-keyring gnome-menus gnome-session gnome-settings-daemon gnome-shell gnome-system-monitor grilo-plugins gvfs gvfs-goa gvfs-gphoto2 gvfs-mtp gvfs-smb samba nautilus sushi tracker3-miners xdg-desktop-portal-gnome xdg-user-dirs-gtk flatpak nodejs npm zsh pipewire pipewire-jack pipewire-alsa pipewire-pulse wireplumber pigz pbzip2 grub efibootmgr

# Fstab
genfstab -U /mnt >> /mnt/etc/fstab