#!/bin/bash

dhclient;
apt update;
apt install neofetch -y;
apt install man-db -y;
mandb -c

if ! grep -q '^ID=ubuntu' /etc/os-release; then
  useradd -m -s /bin/bash debuser;
  echo "debuser ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;
  echo "root ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;
  if grep -q '^ID=kali' /etc/os-release; then
    hostnamectl set-hostname kalilinux;
    echo "127.0.1.1 kalilinux" >> /etc/hosts;
  elif grep -q '^ID=debian' /etc/os-release; then
    hostnamectl set-hostname debian;
  elif grep -q '^ID=linuxmint' /etc/os-release; then
    hostnamectl set-hostname linuxmint;
  fi
fi
