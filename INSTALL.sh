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

# Setup DNS
sh "./misc/DNS.sh"
