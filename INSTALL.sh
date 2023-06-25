#!/bin/bash

# Ensure root
if [[ "$(id -u)" -ne 0 ]]; then echo "Please run as root." >&2; exit 1; fi

# Import ENV
source "./ENV.sh"

# Pick device
echo ' /-------------------- WELCOME --------------------\'
echo ' |                                                 |'
echo ' |==> 1: wheatley                                  |'
echo ' |==> 2: glados                                    |'
echo ' |                                                 |'
echo ' |==> 3: quit                                      |'
echo ' |                                                 |'
echo ' \_________________________________________________/'

read option

if [[ $option -eq 1 ]]; then
    device="wheatley"
elif [[ $option -eq 2 ]]; then
    device="glados"
fi

# Remove the fucking pcspkr
if [[ $device -eq "wheatley" ]]; then rmmod pcspkr; fi

# Disk setup
source "./devices/$device/disk.sh"

# Install packages
echo "--> Installing packages..."

source "./devices/$device/pacstrap.sh"

# Generate fstab
echo "--> Generating fstab..."

genfstab -U /mnt >> /mnt/etc/fstab

# Create scripts directory
SCRIPTS="/SCRIPTS"
SCRIPTS_LOCAL="/mnt$SCRIPTS"
mkdir -p $SCRIPTS_LOCAL

# Copy env variables across
cp "./ENV.sh" "$SCRIPTS_LOCAL"

# Environmental variables
source "./devices/$device/env.sh"

# Locale
cp "./devices/all/locale.sh" $SCRIPTS_LOCAL
arch-chroot /mnt "$SCRIPTS/locale.sh"

# Hostname
echo "--> Setting hostname..."
echo $device >> /mnt/etc/hostname

# Program configs
cp "./devices/all/programs.sh" $SCRIPTS_LOCAL
arch-chroot /mnt "$SCRIPTS/programs.sh"

# User
cp "./devices/all/user.sh" $SCRIPTS_LOCAL
arch-chroot /mnt "$SCRIPTS/user.sh"

# Bootloader
cp "./devices/$device/bootloader.sh" $SCRIPTS_LOCAL
arch-chroot /mnt "$SCRIPS/bootloader.sh"

# Setup DNS
cp "./devices/all/DNS.sh" $SCRIPTS_LOCAL
arch-chroot /mnt "$SCRIPTS/DNS.sh"

# Setup AUR
cp "./devices/$device/yay.sh" $SCRIPTS_LOCAL
arch-chroot /mnt "$SCRIPTS/yay.sh"

# systemctl
cp "./devices/$device/systemctl.sh" $SCRIPTS_LOCAL
arch-chroot /mnt "$SCRIPTS/systemctl.sh"