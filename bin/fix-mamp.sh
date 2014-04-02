#!/bin/bash
# Remove process ID files
sudo rm -f /Applications/MAMP/tmp/mysql/mysql.pid
sudo rm -f /Applications/MAMP/Library/logs/httpd.pid

# Kill any running daemons
sudo killall mysqld
sudo killall httpd
