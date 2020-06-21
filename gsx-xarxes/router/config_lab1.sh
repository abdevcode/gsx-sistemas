#!/bin/sh

if [ ! -x def_interficies.sh ]; then
    echo Error: no hi ha les interificies configurades
    exit
fi

. ./def_interficies.sh

if [ ! -f "/etc/network/interfaces.bak" ]; then
    cp /etc/network/interfaces /etc/network/interfaces.bak
fi

if [ ! -f "/etc/resolv.conf.bak" ]; then
    cp /etc/resolv.conf /etc/resolv.conf.bak
fi

linies=$(cat /etc/network/interfaces | wc -l)
if [ $linies -lt 7 ]; then
    echo " " >> /etc/network/interfaces
fi

#Modificar el interfaces
sed -i "7i auto enp0s8" /etc/network/interfaces
sed -i "8i iface enp0s8 inet static" /etc/network/interfaces
sed -i "9i address 203.0.113.10" /etc/network/interfaces
sed -i "10i netmask 255.255.255.252" /etc/network/interfaces

ifup $IFISP
ifup $IFINSIDE
sysctl net.ipv4.ip_forward=1



