#!/bin/sh

ins=$(dpkg -s squid | grep "Status: install ok installed" | wc -l)
if [ $ins -ne 1 ]; then
    apt install squid
    # Hacemos una copia de seguridad 
    cp /etc/squid/squid.conf /etc/squid/squid.conf.bak	
fi

# Recuperamos el fichero de backup
cp /etc/squid/squid.conf.bak /etc/squid/squid.conf

sed -i 's/http_port 3128/http_port 10.200.36.1:3128/g' /etc/squid/squid.conf
sed -i 's/http_access deny all/ /g' /etc/squid/squid.conf
# Afegim al final del fitxer la nostra configuracio
echo "
acl intranet src 10.200.36.0/24
http_access allow intranet
http_access deny all
cache_dir ufs /var/spool/squid 100 16 256
maximum_object_size 4 MB
" >> /etc/squid/squid.conf


# Para cargar la nueva configuracion (hacerla efectiva)
squid -k reconfigure

# Iniciamos el servicio
systemctl start squid
systemctl enable squid


