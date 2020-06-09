#!/bin/sh

echo "Per realitzar aquesta part primer has de fer la configuració DHCP del Bastió"
echo "Realitza la configuració DHCP (si no ho has fet) i prem ENTER..."
read dummy

ifdown enp0s3
ifup enp0s3