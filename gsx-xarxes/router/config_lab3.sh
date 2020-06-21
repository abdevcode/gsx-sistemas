#!/bin/sh

. ./def_interficies.sh

if [ ! -f "/etc/dhcp/dhclient.conf.bak" ]; then
    cp /etc/dhcp/dhclient.conf /etc/dhcp/dhclient.conf.bak
fi

if [ ! -f "/etc/hostname.bak" ]; then
    cp /etc/hostname /etc/hostname.bak
fi

if [ ! -f "/etc/hosts.bak" ]; then
    cp /etc/hosts /etc/hosts.bak
fi
sed -i 's/#supersede domain-name "fugue.com home.vix.com";/supersede domain-name "inside36.gsx";/g' /etc/dhcp/dhclient.conf
sed -i 's/#prepend domain-name-servers 127.0.0.1;/prepend domain-name-servers 203.0.113.9;/g' /etc/dhcp/dhclient.conf


hostname Router20
echo "
Router20
" > /etc/hostname

sed -i 's/GSX/Router20/g' /etc/hosts
systemctl restart networking

ifup $IFISP
