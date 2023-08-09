#!/bin/bash

useradd -m -s /bin/bash archuser;
echo "archuser ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;
echo "root ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;

pacman -Syu --noconfirm;
pacman -Sy --noconfirm neofetch;

pacman -Sy --noconfirm man-db man-pages;
mandb -c
