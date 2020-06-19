#!/bin/sh

# lab 1
if [ -f /etc/network/interfaces.bak ]; then
	cp /etc/network/interfaces.bak /etc/network/interfaces
fi

# lab 2
if [ -f /etc/dhcp/dhcpd.conf.bak ]; then
	cp /etc/dhcp/dhcpd.conf.bak /etc/dhcp/dhcpd.conf
fi 

if [ -f /etc/default/isc-dhcp-server.bak ]; then
	cp /etc/default/isc-dhcp-server.bak /etc/default/isc-dhcp-server
fi

# lab 3
if [ -f /etc/bind/named.conf.local.bak ]; then
	cp /etc/bind/named.conf.local.bak /etc/bind/named.conf.local
fi

if [ -f /etc/bind/named.conf.options.bak ]; then
	cp /etc/bind/named.conf.options.bak /etc/bind/named.conf.options
fi

if [ -f /etc/resolv.conf.bak ]; then
	cp /etc/resolv.conf.bak /etc/resolv.conf
fi

if [ -f /etc/hostname.bak ]; then
	cp /etc/hostname.bak /etc/hostname
fi

if [ -f /etc/hosts.bak ]; then
	cp /etc/hosts.bak /etc/hosts
fi

# lab 5
if [ -f /etc/squid/squid.conf.bak ]; then
	cp /etc/squid/squid.conf.bak /etc/squid/squid.conf
fi