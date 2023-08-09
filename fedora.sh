#!/bin/bash
useradd -m -s /bin/bash rhuser
echo "rhuser ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;
echo "root ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;
dnf update -y
ln -s /usr/bin/dnf5 /usr/bin/dnf;
dnf install -y --nogpgcheck https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-rawhide.noarch.rpm
dnf install -y --nogpgcheck https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-rawhide.noarch.rpm
dnf update -y
dnf install neofetch -y
dnf install man-db man-pages -y
mandb -c
