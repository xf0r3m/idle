#!/bin/bash

useradd -m -s /bin/bash gentoouser;
echo "gentoouser ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;
echo "root ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;

ego sync;
emerge neofetch;

echo "/usr/bin/neofetch" >> /home/gentoouser/.bashrc;
