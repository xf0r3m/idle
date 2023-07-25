#!/bin/bash

export DATABASE=/usr/share/idle/database.csv;
RED="\e[31m";
GREEN="\e[32m";
ENDCOLOR="\e[0m";

function idle-size() {
	total=0;
	size_suffix="MB";
	for remote in $(cut -d ";" -f 1 $DATABASE | awk '{printf $1" "}'); do
		image_size=$(/usr/bin/lxc image info $remote | grep '^Size' | awk '{printf $2" "}')
		float_size=$(echo $image_size | grep -o '^[0-9*\.]*');
		total=$(echo "$total + $float_size" | bc -l);	
		echo "$remote = $image_size";
	done
	csize_total=$(echo "$(cut -d ";" -f 2 $DATABASE | grep -o '^[0-9\.]*' | awk '{printf $1" "}' | sed -s 's/ /+/g')0" | bc -l);
	if [ $(echo $total | cut -d "." -f 1) -gt 1024 ]; then
		total=$(echo "$total / 1024" | bc -l | cut -c 1-4);
		csize_total=$(echo "$csize_total / 1024" | bc -l | cut -c 1-4);
		size_suffix="GB";
	fi
	echo "Total: ${total}${size_suffix}";
	echo "Aprox. containers size: ${csize_total}${size_suffix}";
}

function idle-install-lxd() {
  sudo apt-get install -y snap snapd bridge-utils iptables;
  sudo snap install lxd;
  
  sudo ln -s /snap/bin/lxd /usr/bin/lxd;
  sudo ln -s /snap/bin/lxc /usr/bin/lxc;

  sudo usermod -aG lxd $USER;
  echo "Now you need to re-login to your user account";
}

function idle-lxd-init() {
  cat $HOME/idle/idle_preseed.yaml | sudo lxd init --preseed;
}

function idle-list-containers() {
  if ! lxc profile show default | grep -q 'idle'; then
    echo -e "${RED}LXD isn't initialized. You must run 'idle-lxd-init' firs${ENDCOLOR}";
    exit 1;
  else
    for container in $(cut -d ";" -f 3 $DATABASE | awk '{printf $1" "}'); do
      if lxc info $container >> /dev/null 2>&1; then
        installed="\e[32m\u2714\e[0m";
      else
        installed="\e[31m\u2716\e[0m";
      fi
      desc=$(grep "$container" $DATABASE | cut -d ";" -f 5);
      echo -e "${container}: $desc $installed"; 
    done
  fi
}

function idle-fetch-containers() {

  rpmGrepOpts='-E rpm.sh|fedora.sh|opensuse.sh|alt.sh';
  debGrepOpts='deb.sh';
  otherGrepOpts='-v -E rpm.sh|fedora.sh|opensuse.sh|alt.sh|deb.sh';

  function create-container() {
    containerName=$1;
    if [ "$containerName"="alpine-edge" ] || [ "$containerName"="openwrt" ]; then
      containerShell="/bin/sh";
    else
      containerShell="/bin/bash";
    fi
    if grep -q $containerName $DATABASE; then 
      containerImagePath=$(grep $containerName $DATABASE | cut -d ";" -f 1);
      startupScript=$(grep $containerName $DATABASE | cut -d ";" -f 4);
      /usr/bin/lxc launch $containerImagePath $containerName;
      sec=1;
      while [ $sec -le 5 ]; do
        echo "Waiting $((5 - (sec - 1))) sec to get container full up";
        sleep 1;
        sec=$((sec + 1));
      done 
      /usr/bin/lxc file push ${HOME}/idle/$startupScript ${containerName}/root/${startupScript}
      /usr/bin/lxc exec $containerName $conatinerShell /root/${startupScript}
      echo "Container is ready for work.";
    else
      echo "Given container name doesn't exist in project database";
    fi
  }
  
  function list-containers() {
    containerNameList=$(grep $@ $DATABASE | cut -d ";" -f 3 | awk '{printf $1" "}');
    for contName in $containerNameList; do
      echo -e "    $contName";
    done
  }

  function mass-create-container() {
    if echo $1 | grep -q '\,'; then
      containerNameList=$(echo $1 | sed 's/,/ /g');
    else
      containerNameList=$(grep $@ $DATABASE | cut -d ";" -f 3 | awk '{printf $1" "}');
    fi
    for contName in $containerNameList; do
      create-container $contName;
    done 
  }

  if [ "$1" ]; then
    if [ "$1" = "--all" ]; then
      containerNameList=$(cut -d ";" -f 3 $DATABASE | awk '{printf $1" "}');
      for contName in $containerNameList; do
       create-container $contName; 
      done
    elif [ "$1" = "--deb" ]; then
      mass-create-container $debGrepOpts;
    elif [ "$1" = "--rpm" ]; then
      mass-create-container $rpmGrepOpts;
    elif [ "$1" = "--other" ]; then
      mass-create-container $otherGrepOpts;
    elif echo $1 | grep -q '\,'; then
      mass-create-container $1;
    else
      contName=$1;
      create-container $contName;
    fi 
  else
    echo "idle-fetch-containers - fetch IDLE containers";
    echo "IDLE Project @ 2023 morketsmerke.org";
    echo;
    echo "Usage: ";
    echo "$ idle-fetch-containers <--all/container_name/group_containers>";
    echo;
    echo "Containers name:";
    for contName in $(cut -d ";" -f 3 $DATABASE | awk '{printf $1" "}'); do
      echo -e "  ${contName}";
    done
    echo;
    echo "Groups:";
    echo -e "  --deb - based on APT package manager";
    list-containers $debGrepOpts;
    echo -e "  --rpm - based on RPM package manager";
    list-containers $rpmGrepOpts;
    echo -e "  --other - other containers not fit to above groups:";
    list-containers $otherGrepOpts;
    return 1;
  fi
}
