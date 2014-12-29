#!/bin/sh

# enable bluetooth
killall watch.js
killall -SIGINT obexftpd
killall simple-agent

rfkill block bluetooth
