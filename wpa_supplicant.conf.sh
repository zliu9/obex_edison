#!/bin/sh

cp -f $* /etc/wpa_supplicant/wpa_supplicant.conf
sync
systemctl restart wpa_supplicant
