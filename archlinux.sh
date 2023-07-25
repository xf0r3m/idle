#!/bin/bash

useradd -m -s /bin/bash archuser;
echo "archuser ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;
echo "root ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;

pacman -Syu --noconfirm;
pacman -Sy --noconfirm neofetch;

echo "/usr/bin/neofetch" >> /home/archuser/.bashrc;
