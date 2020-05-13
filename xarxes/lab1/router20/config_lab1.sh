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

#Modificar el interfaces
sed -i "7i auto enp0s8" /etc/network/interfaces
sed -i "8i iface enp0s8 inet static" /etc/network/interfaces
sed -i "9i address 203.0.113.1" /etc/network/interfaces
sed -i "10i netmask 255.255.255.252" /etc/network/interfaces

ifup $IFINSIDE
sysctl net.ipv4.ip_forward=1



