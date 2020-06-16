#!/bin/sh

echo "Per realitzar aquesta part primer has de fer la configuració DNS del Bastió"
echo "Realitza la configuració DNS (si no ho has fet) i prem ENTER..."
read dummy

sed -i 's/#supersede domain-name "fugue.com home.vix.com";/supersede domain-name "inside36.gsx";/g' /etc/dhcp/dhclient.conf
sed -i 's/#prepend domain-name-servers 127.0.0.1;/prepend domain-name-servers 203.0.113.9;/g' /etc/dhcp/dhclient.conf

hostname Router20
echo "
Router20
" > /etc/hostname

sed -i 's/GSX/Router20/g' /etc/hosts
systemctl restart networking
