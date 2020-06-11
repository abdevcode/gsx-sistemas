#!/bin/sh

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
	file \"db.inside36.gsx\"; 
};

zone \"privat36.gsx\" {
	type master; 
	file \"db.inside36.gsx\"; 	
};

zone \"113.0.203.in-addr.arpa\" {
	type master;
	file \"db.203.0.113\";
};

zone \"36.200.10.in-addr.arpa\" {
	type master;
	file \"db.10.200.36\";
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
    IN  MX 10   mail.inside36.gsx.
ns	IN	A	203.0.113.2

correu  IN  A   203.0.113.3
smtp    CNAME   correu 
pop3    CNAME   correu
router	IN	A	203.0.113.1
" > /var/lib/bind/db.inside36.gsx

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
ns	IN	A	10.200.36.1

;Altres maquines
noc     IN	A	10.200.36.2
PC129	IN	A	10.200.36.129
PC130	IN	A	10.200.36.130
correu	IN	A	10.200.36.11
pop3	CNAME		correu
smpt	CNAME		correu
"  > /var/lib/bind/db.privat36.gsx

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
2	IN	PTR	ns.inside36.gsx.
1	IN	PTR	router.inside36.gsx.
3   IN  PTR correu.inside36.gsx.
3   IN  PTR smtp.inside36.gsx.
3   IN  PTR pop3.inside36.gsx.
"  > /var/lib/bind/db.203.0.113

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
1	IN	PTR	ns.privat36.gsx.

;Altres maquines
2	IN	PTR	noc.private36.gsx.
129	IN	PTR	PC129.privat36.gsx.
130	IN	PTR	PC130.privat36.gsx.
11	IN	PTR	correu.privat36.gsx.				
"  > /var/lib/bind/db.10.200.36

echo "
options {
    directory \"/var/cache/bind\";
    forwarders{
        8.8.8.8;
        8.8.4.4;
    };
    dnssec-validation false;
    allow-recursion{10.200.36.0/24;};
};
" > /etc/bind/named.conf.options