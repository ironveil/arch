#!/bin/bash

# Locale
echo "--> Generating locale..."

ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc

sed -i 's/#en_GB.UTF-8/en_GB.UTF-8/' /etc/locale.gen
sed -i 's/#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen

locale-gen

echo "LANG=en_GB.UTF-8" > /etc/locale.conf
echo "KEYMAP=uk" > /etc/vconsole.conf

# System info
echo "--> Generating system info..."

echo "glados" > /etc/hostname

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Arch
grub-mkconfig -o /boot/grub/grub.cfg

# Program config
echo "--> Setting program configs..."

sed -i 's/#Color/Color/' /etc/pacman.conf
sed -i 's/#VerbosePkgLists/VerbosePkgLists/' /etc/pacman.conf
sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 6/' /etc/pacman.conf
sed -i '38i ILoveCandy' /etc/pacman.conf
sed -i 's/#[multilib]/[multilib]/' /etc/pacman.conf
sed -i '92s/#//' /etc/pacman.conf

sed -i '49s/#MAKEFLAGS="-j2"/MAKEFLAGS="-j8"/' /etc/makepkg.conf
sed -i 's/#RUSTFLAGS="-C opt-level=2"/RUSTFLAGS="-C opt-level=2 -C target-cpu=native"/' /etc/makepkg.conf
sed -i '41s/x86-64 -mtune=generic/native/' /etc/makepkg.conf
sed -i '137s/gzip/pigz/' /etc/makepkg.conf
sed -i '138s/bzip2/pbzip2/' /etc/makepkg.conf
sed -i '139s/-z -/-z --threads=0 -/' /etc/makepkg.conf
sed -i '140s/-q -/-q --threads=0 -/' /etc/makepkg.conf

# User info
echo "--> Setting up user info..."

useradd -mG wheel ironveil

echo '%wheel ALL=(ALL:ALL) ALL' | EDITOR='tee -a' visudo
echo 'Defaults pwfeedback' | EDITOR='tee -a' visudo
echo 'Defaults insults' | EDITOR='tee -a' visudo

echo 'EDITOR=nvim' >> /etc/environment

systemctl enable NetworkManager dhcpcd wpa_supplicant gdm