#!/bin/bash

useradd -m -s /bin/bash altuser;
echo "altuser ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;
echo "root ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;

apt-get update;
apt-get install neofetch -y;

echo "/usr/bin/neofetch" >> /home/altuser/.bashrc;
