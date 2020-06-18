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

# LAB 2
echo "config_lab2: "
sh config_lab2.sh

# LAB 3
echo "config_lab3: "
sh config_lab3.sh

# LAB 4
echo "AVIS! --> Cal configurar el lab4 del router abans de continuar"
read dummy
echo "config_lab4: "
sh config_lab4.sh

# LAB 5
echo "Actualitzem el repositori"
apt update

echo "config_lab5: "
sh config_lab5.sh


echo "END: Fi de la configuracio"











