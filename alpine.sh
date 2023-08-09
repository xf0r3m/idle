#!/bin/sh

apk add bash;
adduser -s /bin/bash -D alpuser;
apk add sudo;
echo "alpuser ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;
apk add neofetch;
apk add man-db man-pages;
mandb -c
