#!/bin/bash

# Validem que l'execucio es fa amb permisos de sudo
if [ "$EUID" -ne 0 ]; then
    echo "Calen permisos de root per fer la configuracio"
    exit
fi


echo "START: Comencem la configuracio"

# LAB 1
echo "config_lab1: "
sh config_lab1.sh

# LAB 3
echo "AVIS! --> Primer s'ha d'executar el lab3 del bastio"
echo "Realitza la configuració DNS i prem ENTER..."
read dummy
echo "config_lab3: "
sh config_lab3.sh

# LAB 4
echo "config_lab4: "
sh config_lab4.sh


echo "END: Fi de la configuracio"
