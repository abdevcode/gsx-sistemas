#! /bin/bash

#Autors:
#- Abderrahim Talhaoui
#- Oriol Manzanero Perez
#- Ramon Donadeu Caballero

#Data: 15/02/2020 
#Versio: 1

#Que fa l'script bla bla bla

#Verificacio de les opcions i dels parametres 
if [ $# -eq 0 ]; then 
	#Treiem error per canal stderr 
	echo "Error: sin parametros." >&2
else
	fitxer=$1
	#Validar que existeix el fitxer
	if [ -f $fitxer ]; then
		(cat /dev/null > $fitxer)
	else 
		echo "Error: no existe el fichero especificado por parametro." >&2
	fi
fi
