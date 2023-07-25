#!/bin/bash
useradd -m -s /bin/bash rhuser
echo "rhuser ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;
echo "root ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;
sudo dnf update
sudo dnf install 'dnf-command(config-manager)' -y
dnf config-manager --set-enabled crb
sudo dnf update
dnf install epel-release -y
dnf install epel-release -y
sudo crb enable
sudo dnf update
sudo dnf install --nogpgcheck https://dl.fedoraproject.org/pub/epel/epel-release-latest-$(rpm -E %rhel).noarch.rpm -y
sudo dnf install --nogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-$(rpm -E %rhel).noarch.rpm https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-$(rpm -E %rhel).noarch.rpm -y
sudo dnf update
sudo dnf install neofetch -y
echo "/usr/bin/neofetch" >> /home/rhuser/.bashrc;
