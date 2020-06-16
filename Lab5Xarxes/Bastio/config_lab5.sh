#!/bin/sh

ins=$(dpkg -s squid | grep "Status: install ok installed" | wc -l)
if [ $ins -ne 1 ]; then
    apt install squid
fi

cp /etc/squid/squid.conf /etc/squid/squid.confbak

echo "
http_port 10.200.36.1:3128
acl intranet src 10.200.36.128-10.200.36.191
http_acces allow intranet
cache_dir ufs /var/spool/squid 100 16 256
maximum_object_size 4 MB
" > /etc/squid/squid.conf

squid -k parse
