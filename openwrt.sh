#!/bin/sh

opkg update
opkg install bash
opkg install shadow-useradd

useradd -m -s /bin/bash openwrt
echo "openwrt ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;
echo "root ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;
