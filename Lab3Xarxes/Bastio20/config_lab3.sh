#!/bin/sh

if [ ! -x def_interficies.sh ]; then
    echo Error: no hi ha les interificies configurades
    exit
fi

. ./def_interficies.sh

dpkg-query --show bind9 >/dev/null 2>$1
if [ $? -ne 0 ]; then
    apt install bind9
fi
dpkg-query --show bind9-doc >/dev/null 2>$1
if [ $? -ne 0 ]; then
    apt install bind9-doc
fi
dpkg-query --show dnsutils >/dev/null 2>$1
if [ $? -ne 0 ]; then
    apt install dnsutils
fi


echo "
zone \"inside36.gsx\" {
	type master; 
	file \"/etc/bind/db.inside36.gsx\"; 
};

zone \"privat36.gsx\" {
	type master; 
	file \"/etc/bind/db.privat36.gsx\"; 	
};

zone \"113.0.203.in-addr.arpa\" {
	type master;
	file \"/etc/bind/db.203.0.113\";
};

zone \"10.in-addr.arpa\" {
	type master;
	file \"/etc/bind/db.10.200.36\";
};
" > /etc/bind/named.conf.local

echo "
\$TTL 604800
@	IN	SOA	ns.inside36.gsx.	root.ns.inside36.gsx	(
            1               ;Serial
            604800			;Refresh
            86400			;Retry
            2419200			;Expire
            604800)			;Negaive Cache TTL
;
@	IN	NS  ns
    IN  MX  10  correu.inside36.gsx.
ns	IN	A	203.0.113.9

correu  IN  A   203.0.113.11
smtp    CNAME   correu 
pop3    CNAME   correu
router	IN	A	203.0.113.10
bastio  CNAME   ns 
" > /etc/bind/db.inside36.gsx

echo "
\$TTL 604800
@	IN	SOA	ns.privat36.gsx.	root.ns.privat36.gsx	(
            1			    ;Serial
            604800			;Refresh
            86400			;Retry
            2419200			;Expire
            604800)			;Negaive Cache TTL
;
@	IN	NS	ns
    IN  MX  10  correu.privat36.gsx.
ns	IN	A	10.200.36.1

;Altres maquines
noc     IN	A	10.200.36.2
PC129	IN	A	10.200.36.129
PC130	IN	A	10.200.36.130
correu	IN	A	10.200.36.11
pop3	CNAME		correu
smpt	CNAME		correu
dhcp    CNAME   ns
bastio  CNAME   ns   
"  > /etc/bind/db.privat36.gsx

echo "
\$TTL 604800
@	IN	SOA	ns.inside36.gsx.	root.ns.inside36.gsx	(
            2			    ;Serial
            604800			;Refresh
            86400			;Retry
            2419200			;Expire
            604800)			;Negaive Cache TTL
;
@	IN	NS	ns.inside36.gsx.
9	IN	PTR	ns.inside36.gsx.
10	IN	PTR	router.inside36.gsx.
11  IN  PTR correu.inside36.gsx.
"  > /etc/bind/db.203.0.113

echo "
\$TTL 604800
@	IN	SOA	ns.privat36.gsx.	root.ns.privat36.gsx	(
            2			    ;Serial
            604800			;Refresh
            86400			;Retry
            2419200			;Expire
            604800)			;Negaive Cache TTL
;
@	IN	NS	ns.privat36.gsx.
1.36.200	IN	PTR	ns.privat36.gsx.

;Altres maquines
2.36.200	IN	PTR	noc.privat36.gsx.
129.36.200	IN	PTR	PC129.privat36.gsx.
130.36.200	IN	PTR	PC130.privat36.gsx.
11.36.200	IN	PTR	correu.privat36.gsx.				
"  > /etc/bind/db.10.200.36

echo "
options {
    directory \"/var/cache/bind\";
    forwarders{
        192.168.1.1;
    };
    dnssec-validation false;
    allow-recursion{10.200.36.0/24;};
};
" > /etc/bind/named.conf.options

echo "
subnet 10.200.36.0 netmask 255.255.255.0 {
    range 10.200.36.128 10.200.36.192;
    option broadcast-address 10.200.36.255;
    option domain-name-servers 10.200.36.1;
    option domain-name \"privat36.gsx\";
    option routers 10.200.36.1;
    default-lease-time 7200;
    max-lease-time 7200;
    deny unknown-clients; 
}

host Intern20 {
    hardware ethernet $MacIfINT;
    fixed-address 10.200.36.2;
    default-lease-time -1;
}
" > /etc/dhcp/dhcpd.conf

echo "
nameserver 127.0.0.1
search privat36.gsx inside36.gsx
domain inside36.gsx
domain privat36.gsx
" > /etc/resolv.conf

systemctl restart isc-dhcp-server
systemctl restart bind9