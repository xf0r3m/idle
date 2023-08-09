#!/bin/bash

useradd -m -s /bin/bash gentoouser;
echo "gentoouser ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;
echo "root ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;

emerge neofetch;

emerge man-db man-pages;
mandb -c;
