#!/bin/sh

# change bluetooth name
echo "Name = mug_`cat /etc/device_id`" >> /etc/bluetooth/main.conf

# add -compat to bluetoothd
#sed -i '/ExecStart/s/bluetoothd/bluetoothd\ --compat\ /g'  /etc/systemd/system/bluetooth.target.wants/bluetooth.service
# sed -i '/ExecStart/s/bluetoothd/bluetoothd\ --compat\ /g'  /lib/systemd/system/bluetooth.service

# copy obex libraries
cp -av ./lib/* /usr/lib

# copy obexftp binary
cp -f ./bin/* /usr/bin

systemctl restart bluetooth

echo "cd `pwd`" >> /home/root/init.sh
echo "./run.sh &> /dev/null &" >> /home/root/init.sh
echo "cd -" >> /home/root/init.sh

