#!/bin/bash

if [[ "$(id -u)" -ne 0 ]] && [[ "$(git branch --show-current)" -ne "dev" ]]; then echo "Please run as root." >&2; exit 1; fi

echo ' /-------------------- WELCOME --------------------\'
echo ' |                                                 |'
echo ' |==> 1: wheatley                                  |'
echo ' |==> 2: glados                                    |'
echo ' |                                                 |'
echo ' |==> 3: quit                                      |'
echo ' |                                                 |'
echo ' \_________________________________________________/'

read option

if [ $option -eq 1 ]; then
    device="wheatley"

elif [ $option -eq 2 ]; then
    device="glados"
fi

sh "$device/disks.sh"
sh "$device/pacstrap.sh"

cp $device/install.sh /mnt/
arch-chroot /mnt /install.sh
rm -f /mnt/install.sh

reboot