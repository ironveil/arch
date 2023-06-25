#!/bin/bash

# Partitioning
echo "--> Partitioning disks..."

sgdisk --zap-all /dev/nvme0n1

sgdisk -n 1:1MiB:513MiB --typecode ef00 -c 1:EFI /dev/nvme0n1
sgdisk -n 2:514MiB -c 2:ROOT /dev/nvme0n1

# Encryption
echo "--> Encrypting..."

echo $CRYPT_PASS | cryptsetup -q luksFormat /dev/nvme0n1p2
echo $CRYPT_PASS | cryptsetup luksOpen /dev/nvme0n1p2 cryptdisk

# LVM
echo "--> Making LVM..."

pvcreate /dev/mapper/cryptdisk
vgcreate wheatley /dev/mapper/cryptdisk
lvcreate -L 8G wheatley -N swap
lvcreate -l 100%FREE wheatley -N root

# Formatting
echo "--> Formatting partitions..."

mkfs.fat -F32 -nEFI /dev/nvme0n1p1
mkswap -L SWAP /dev/mapper/wheatley-swap
mkfs.btrfs -fL DISK /dev/mapper/wheatley-root

# Mounting
echo "--> Mounting partitions..."

mount -o compress-force=zstd,ssd,space_cache=v2,discard,noatime /dev/mapper/wheatley-root /mnt
mount --mkdir -o nodev,noexec,nosuid,noatime,commit=60 /dev/nvme0n1p1 /mnt/efi
swapon /dev/mapper/wheatley-swap