#!/bin/bash

ping -q -c 1 wp.pl -w 1 >> /dev/null 2>&1;
if [ $? -eq 0 ]; then 
  useradd -m -s /bin/bash suseuser
  echo "suseuser ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;
  echo "root ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;

  zypper update -y;
  zypper install -y neofetch;

  zypper install -y man man-pages
  mandb -c
fi
