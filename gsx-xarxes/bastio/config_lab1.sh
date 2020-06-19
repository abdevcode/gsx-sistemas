#!/bin/sh


# Realitzem les copies de seguretat abans  
if [ -f /etc/network/interfaces ] [ ! -f /etc/network/interfaces.bak ]; then
    cp /etc/network/interfaces /etc/network/interfaces.bak
fi



linies=$(cat /etc/network/interfaces | wc -l)
if [ $linies -lt 7 ]; then
    echo " " >> /etc/network/interfaces
fi

ifdown enp0s3

#Modificar el interfaces enp0s3
sed -i 's/iface enp0s3 inet dhcp/iface enp0s3 inet static/g' /etc/network/interfaces
sed -i "7i address 203.0.113.9" /etc/network/interfaces
sed -i "8i netmask 255.255.255.252" /etc/network/interfaces
sed -i "9i gateway 203.0.113.10" /etc/network/interfaces


#Modificar el interfaces enp0s8
sed -i "10i auto enp0s8" /etc/network/interfaces
sed -i "11i iface enp0s8 inet static" /etc/network/interfaces
sed -i "12i address 10.200.36.1" /etc/network/interfaces
sed -i "13i netmask 255.255.255.0" /etc/network/interfaces

ifup enp0s3
ifup enp0s8




