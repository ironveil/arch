#!/bin/bash

# Import env
source "./ENV.sh"

# Create user
useradd -mG wheel,video ironveil

# Set passwords
echo ironveil:$PASSWORD | chpasswd