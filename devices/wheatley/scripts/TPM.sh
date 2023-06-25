#!/bin/bash

# Remove current TPM2 device
systemd-cryptenroll --wipe-slot=tpm2 /dev/nvme0n1p2

# Enable TPM2
systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+2+4+7 --tpm2-with-pin=yes /dev/nvme0n1p2
