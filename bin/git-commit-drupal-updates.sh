#!/bin/bash

if [[ $# -eq 0 ]]; then
  echo "Usage: git-commit-drupal-updates.sh DIR1 DIR2 DIR3.."
  exit 0
fi

for i in $@; do

  if [[ -f "$i/$i.info" ]]; then
    cd $i;
    git add .;
    git-rm-deleted .;
    VER=$(cat $i.info | grep 'version = ' | egrep -o '[0-9]+.x-[^"]+');
    git commit -m "Upgrading to $i-$VER.";
    cd ..;
  else
    echo "NOT UPDATING $i, cannot find $i/$i.info"
  fi

done