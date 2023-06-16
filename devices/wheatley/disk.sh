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
lvcreate -L 8G whealey -N swap
lvcreate -l 100%FREE whealey -N root

# Formatting
echo "--> Formatting partitions..."

