#!/bin/sh

if [ -f "interfaces.bak" ]; then
    cp interfaces.bak /etc/network/interfaces
fi

if [ -f "resolv.confbak" ]; then
    cp resolv.confbak /etc/resolv.conf
fi

if [ -f "dhclient.confbak" ]; then
    cp dhclient.confbak /etc/dhcp/dhclient.conf
fi

if [ -f "hostname.bak" ]; then
    cp hostname.bak /etc/hostname
fi

if [ -f "hosts.bak" ]; then
    cp hosts.bak /etc/hosts
fi
