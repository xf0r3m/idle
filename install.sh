#!/bin/bash

set -e

if [ ! -d /usr/share/idle ]; then
	sudo mkdir /usr/share/idle;
	sudo cp database.csv /usr/share/idle;
fi

sudo cp idle.sh /usr/local/bin/idle
sudo chmod +x /usr/local/bin/idle
sudo cp database.sh /usr/local/bin/database
sudo chmod +x /usr/local/bin/database
sudo cp idle-clis /usr/local/bin/idle-clis

echo "source /usr/local/bin/idle" >> /home/${USER}/.bashrc;
echo "source /usr/local/bin/database" >> /home/${USER}/.bashrc;
