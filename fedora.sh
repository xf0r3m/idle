#!/bin/bash
useradd -m -s /bin/bash rhuser
echo "rhuser ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;
echo "root ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;
sudo dnf update
sudo dnf install -y --nogpgcheck https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-rawhide.noarch.rpm
sudo dnf install -y --nogpgcheck https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-rawhide.noarch.rpm
sudo dnf update
sudo dnf install neofetch -y
echo "/usr/bin/neofetch" >> /home/rhuser/.bashrc;
