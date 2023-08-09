#!/bin/bash

useradd -m -s /bin/bash voiduser
echo "voiduser ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;
echo "root ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;

xbps-install -Su -y;
xbps-install -y neofetch;

xbps-install -y man-db;
mandb -c
