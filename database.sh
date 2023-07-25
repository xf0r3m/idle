#!/bin/bash

export DATABASE="/usr/share/idle/database.csv";

function idle-db-update-containers-desc() {
  list=$(cut -d ";" -f 1 $DATABASE |\
   sed -e 's/images://g' -e 's@/amd64@@g' |\
   awk '{printf $1" "}');
  lxc image list images: -f csv > /tmp/idle_images_list.csv;
  for contName in $list; do
    contDesc=$(grep "${contName}\ " /tmp/idle_images_list.csv | grep 'amd64' | grep 'CONTAINER' | cut -d "," -f 4);
    dbLine=$(grep "^images:${contName}" $DATABASE); 
    echo "${dbLine};${contDesc}";
  done
}
