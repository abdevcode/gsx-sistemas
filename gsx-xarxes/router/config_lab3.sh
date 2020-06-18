#!/bin/sh

. ./def_interficies.sh


sed -i 's/#supersede domain-name "fugue.com home.vix.com";/supersede domain-name "inside36.gsx";/g' /etc/dhcp/dhclient.conf
sed -i 's/#prepend domain-name-servers 127.0.0.1;/prepend domain-name-servers 203.0.113.9;/g' /etc/dhcp/dhclient.conf

hostname Router20
echo "
Router20
" > /etc/hostname

sed -i 's/GSX/Router20/g' /etc/hosts
systemctl restart networking

ifup $IFISP
