#!/bin/sh

if [ -f "interfaces.confbak" ]; then
    cp interfaces.bak ~/etc/networks/interfaces
fi

if [ -f "dhclienthostname.bak" ]; then
    cp dhclienthostname.bak ~/etc/dhcp/dhclient-exit-hooks.d/hostname
fi

if [-f "hosts.bak" ]; then
    cp hosts.bak ~/etc/hosts
fi
