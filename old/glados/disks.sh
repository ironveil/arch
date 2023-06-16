#!/bin/bash

# Partitioning
echo "--> Partitioning disks..."

sgdisk --zap-all /dev/sda
sgdisk --zap-all /dev/sdb

sgdisk -n 1:1MiB:513MiB --typecode 1:ef00 /dev/sda
sgdisk -n 2:514MiB /dev/sda
sgdisk -n 1:1MiB /dev/sdb

sgdisk -c 1:EFI /dev/sda
sgdisk -c 2:ROOT /dev/sda
sgdisk -c 1:ROOT /dev/sdb

# Filesystem
echo "--> Making filesystem..."

mkfs.fat -F32 -nEFI /dev/sda1
mkfs.btrfs -fL ROOT /dev/sda2 /dev/sdb1

# Mounting
echo "--> Mounting filesystem..."

mount -o noatime,discard,ssd,space_cache=v2,commit=30,compress-force=zstd /dev/sda2 /mnt
mount -o noatime,nodev,nosuid,noexec --mkdir /dev/sda1 /mnt/boot