#! /bin/bash

#Autors:
#- Abderrahim Talhaoui
#- Oriol Manzanero Perez
#- Ramon Donadeu Caballero

#Data: 15/02/2020 
#Versio: 1

#Que fa l'script bla bla bla

#Verificacio de les opcions i dels parametres
if [ $# -ne 5 ]; then 
	#Treiem error per canal stderr 
	echo "Error: sin 5 parametros." >&2
else
	fitxer="/etc/network/interfaces"
	#Validar que existeix el fitxer
	if [ -f $fitxer ]; then
		echo "auto $1" >> $fitxer
		echo "iface $1 inet static" >> $fitxer
		echo "        adress $2" >> $fitxer
		echo "        netmask $3" >> $fitxer
		echo "        network $4" >> $fitxer
		echo "        gateway $5" >> $fitxer
	else 
		echo "Error: no existe el fichero especificado por parametro." >&2
	fi
fi
