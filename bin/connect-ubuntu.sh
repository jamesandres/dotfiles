#!/bin/bash
MOUNTPATH=/Volumes/ubuntu-sshfs
UBUNTUIP=$(ping -q -c 1 ubuntu.local | head -n 1 | awk '{ print $3 }' | sed 's/[\(\):]//g')

if [[ ! -d "$MOUNTPATH" ]]; then
	mkdir $MOUNTPATH
fi

sshfs james@$UBUNTUIP:/home/james $MOUNTPATH -oauto_cache,reconnect,volname="James (ubuntu)"
