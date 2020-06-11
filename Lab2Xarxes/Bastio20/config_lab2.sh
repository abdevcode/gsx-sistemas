#!/bin/sh

if [ ! -x def_interficies.sh ]; then
    echo Error: no hi ha les interificies configurades
    exit
fi

. ./def_interficies.sh

dpkg-query --show isc-dhcp-server >/dev/null 2>$1
cd /var/cache/apt
rm -fr archives
ln -s /home/milax/archives
if [ $? -ne 0 ]; then
    apt install isc-dhcp-server
fi

echo "
subnet 10.200.36.0 netmask 255.255.255.0 {
    range 10.200.36.128 10.200.36.192;
    option broadcast-address 10.200.36.255;
    option routers 10.200.36.1;
}

host Intern20 {
    hardware ethernet $MacIfINT;
    fixed-address 10.200.36.2;
}" > /etc/dhcp/dhcpd.conf

sed -i 's/INTERFACESv4=""/INTERFACESv4="enp0s8"/g' /etc/default/isc-dhcp-server
systemctl restart isc-dhcp-server