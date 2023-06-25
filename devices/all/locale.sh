#!/bin/bash

# Generate locale
echo "--> Generating locale..."

CWD=/etc/locale.gen

sed -i "154s/#//" $CWD
sed -i "171s/#//" $CWD

locale-gen

# Set locale
echo "--> Setting locale..."

echo "LANG=en_GB.UTF-8" >> /etc/locale.conf
echo "KEYMAP=uk" >> /etc/vconsole.conf