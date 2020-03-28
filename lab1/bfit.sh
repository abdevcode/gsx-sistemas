#! /bin/bash

#Autors:
#- Abderrahim Talhaoui
#- Oriol Manzanero Perez
#- Ramon Donadeu Caballero

#Data: 15/02/2020 
#Versio: 1

#Script que rep per paràmetre un fitxer. En aquest fitxer hi haurà el
#path absolut de fitxers. L'script mostrarà per pantalla el path absolut del fitxer, seguit del
#propietari, grup i permisos que té actualment aquest fitxer.


#Verificacio de les opcions i dels parametres 
if [ $# -eq 1 ]; then 
	fitxer=$1
	#Validar que existeix el fitxer
	if [ -f $fitxer ]; then
		cat /dev/null > $fitxer
	else 
		echo "Error: no existe el fichero especificado por parametro o es un directorio" >&2
	fi
else
	
	#Treiem error per canal stderr 
	echo "Error: se accepta solo un parametro" >&2
fi
