#!/bin/sh

if [ ! -x def_interficies.sh ]; then
    echo Error: no hi ha les interificies configurades
    exit
fi

. ./def_interficies.sh

linies=$(cat /etc/network/interfaces | wc -l)
if [ $linies -lt 7 ]; then
    echo " " >> /etc/network/interfaces
fi

ifdown $IFISP

#Modificar el interfaces enp0s3
sed -i 's/iface enp0s3 inet dhcp/iface enp0s3 inet static/g' /etc/network/interfaces
sed -i "7i address 203.0.113.2" /etc/network/interfaces
sed -i "8i netmask 255.255.255.252" /etc/network/interfaces
sed -i "9i gateway 203.0.113.1" /etc/network/interfaces


#Modificar el interfaces enp0s8
sed -i "10i auto enp0s8" /etc/network/interfaces
sed -i "11i iface enp0s8 inet static" /etc/network/interfaces
sed -i "12i address 10.200.20.0" /etc/network/interfaces
sed -i "13i netmask 255.255.255.0" /etc/network/interfaces

ifup $IFISP
ifup enp0s8




