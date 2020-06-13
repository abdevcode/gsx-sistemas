#!/bin/sh

sed -i 's/#prepend domain-name-servers 127.0.0.1;/prepend domain-name-servers 203.0.113.9;/g' /etc/dhcp/dhclient.conf

systemctl restart networking
