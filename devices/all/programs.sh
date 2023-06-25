#!/bin/bash

# Pacman config
echo "--> Setting up pacman..."

CWD=/etc/pacman.conf

sed -i '33s/#//' $CWD
sed -i '36s/#//' $CWD
sed -i '37s/#ParallelDownloads = 5/ParallelDownloads = 6/' $CWD
sed -i '38i ILoveCandy' $CWD
sed -i '91s/#//' $CWD
sed -i '92s/#//' $CWD

# Make config
echo "--> Setting up make..."

CWD=/etc/makepkg.conf

sed -i '41s/x86-64 -mtune=generic/native/' $CWD
sed -i 's/#RUSTFLAGS="-C opt-level=2"/RUSTFLAGS="-C opt-level=2 -C target-cpu=native"/' $CWD
sed -i '49s/#MAKEFLAGS="-j2"/MAKEFLAGS="-j8"/' $CWD
sed -i '137s/gzip/pigz/' $CWD
sed -i '138s/bzip2/pbzip2/' $CWD
sed -i '139s/-z -/-z --threads=0 -/' $CWD
sed -i '140s/-q -/-q --threads=0 -/' $CWD
sed -i '151s/.zst//' $CWD

# Sudo
echo "--> Setting up sudo..."

echo '%wheel ALL=(ALL:ALL) ALL' | EDITOR='tee -a' visudo
echo 'Defaults pwfeedback' | EDITOR='tee -a' visudo
echo 'Defaults insults' | EDITOR='tee -a' visudo