#!/bin/sh

# enable bluetooth
rfkill unblock bluetooth
sleep 1
hciconfig hci0 up
hciconfig hci0 piscan
killall simple-agent
./bluez-tools/simple-agent &

mkdir received

killall watch.js
./watch.js ./received &

./bin/obexftpd -c ./received -b 


