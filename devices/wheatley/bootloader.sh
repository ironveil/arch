#!/bin/bash

# Install systemd-boot
echo "--> Installing systemd-boot..."

bootctl install

mkdir -p "/etc/pacman.d/hooks"
echo "[Trigger]\nType = Package\nOperation = Upgrade\nTarget = systemd\n\n[Action]\nDescription = Updating systemd-boot...\nWhen = PostTransaction\nExec = /usr/bin/bootctl update" >> /etc/pacman.d/hooks/95-systemd-hook.hook

# Setup secure boot
echo "--> Setting up secure boot..."

echo "rd.luks.name=$(blkid -s UUID -o value /dev/nvme0n1p2)=cryptdisk rd.luks.options=$(blkid -s UUID -o value /dev/nvme0n1p2)=tpm2-device=auto resume=/dev/mapper/wheatley-swap root=/dev/mapper/wheatley-root rw quiet splash loglevel=3 systemd.show_status=auto vga=current amd_pstate=active" >> /etc/kernel/cmdline
sbctl bundle -s -f /boot/initramfs-linux.img -k /boot/vmlinuz-linux /efi/EFI/Linux/linux.efi

sbctl create-keys
sbctl enroll-keys --force
sbctl sign -s /efi/EFI/BOOT/BOOTX64.EFI
sbctl sign -s /efi/EFI/Linux/linux.efi
sbctl sign -s /efi/EFI/systemd/systemd-bootx64.efi