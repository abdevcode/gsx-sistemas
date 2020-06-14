#!/bin/sh

echo "Per realitzar aquesta part primer has de fer la configuració DNS del Bastió"
echo "Realitza la configuració DNS (si no ho has fet) i prem ENTER..."
read dummy
sed -i 's/#prepend domain-name-servers 127.0.0.1;/prepend domain-name-servers 203.0.113.9;/g' /etc/dhcp/dhclient.conf

systemctl restart networking
