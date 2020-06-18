#!/bin/bash

# Validem que l'execucio es fa amb permisos de sudo
if [ "$EUID" -ne 0 ]; then
    echo "Calen permisos de root per fer la configuracio"
    exit
fi

echo "START: Comencem la configuracio"

# LAB 2
echo "AVIS! --> Primer s'ha d'executar el lab2 del bastio"
echo "Realitza la configuració DHCP i prem ENTER..."
read dummy
echo "config_lab2: "
sh config_lab2.sh

# LAB 3
echo "AVIS! --> Primer s'ha d'executar el lab3 del bastio"
echo "Realitza la configuració DNS i prem ENTER..."
read dummy
echo "config_lab3: "
sh config_lab3.sh

# LAB 5
echo "AVIS! --> Cal configurar el lab5 del bastio abans de continuar"
read dummy
echo "config_lab5: Configuracio del links"
bash config_lab5.sh


echo "END: Fi de la configuracio"
