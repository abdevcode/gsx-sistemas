#!/bin/sh

if [ -f "/etc/network/interfaces.bak" ]; then
    cp /etc/network/interfaces.bak /etc/network/interfaces
fi

if [ -f "/etc/resolv.conf.bak" ]; then
    cp /etc/resolv.conf.bak /etc/resolv.conf
fi

if [ -f "/etc/dhcp/dhclient.conf.bak" ]; then
    cp /etc/dhcp/dhclient.conf.bak /etc/dhcp/dhclient.conf
fi

if [ -f "/etc/hostname.bak" ]; then
    cp /etc/hostname.bak /etc/hostname
fi

if [ -f "/etc/hosts.bak" ]; then
    cp /etc/hosts.bak /etc/hosts
fi
