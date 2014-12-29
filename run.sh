#!/bin/sh

# stop old service
./stop.sh
sleep 1

# enable bluetooth
rfkill unblock bluetooth
sleep 1

# setup bluetooth attribute
# hciconfig hci0 name mug_`cat /etc/device_id`
hciconfig hci0 name mug_`ifconfig wlan0|grep HWaddr| sed 's/.*HWaddr\ //'`
hciconfig hci0 down
hciconfig hci0 up
hciconfig hci0 piscan

# enable simple-agent which always accept pairing request
./bluez-tools/simple-agent &

# watch dir changes
mkdir received
./watch.js ./received &

# enable obex server
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:./lib
./bin/obexftpd -c ./received -b &

sleep 2

hciconfig hci0 down 

# hack
ifconfig wlan0 down
ifconfig wlan0 up
