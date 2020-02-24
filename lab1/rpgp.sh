#! /bin/bash

#Autors:
#- Abderrahim Talhaoui
#- Oriol Manzanero Perez
#- Ramon Donadeu Caballero

#Data: 11/02/2020 
#Versio: 1.1

#Que fa l'script bla bla bla



#Verificacio de les opcions i dels parametres 
if [ $# -eq 0 ]; then 
	#Treiem error per canal stderr 
	echo "Error: sin parametros." >&2
else
	fitxer=$1
	
	#Validar que existeix el fitxer
	if [ -f $fitxer ]; then
		#Separador de camp (IFS) - per assignar car especials amb $''

		#Obtenir les dades per cada ruta especificada en el fitxer
		while IFS=" ", read -r ruta prop grup perm; do
		    ## Do something with $a, $b and $c
		    echo "$ruta -- $prop -- $grup -- $perm"
			
			# Ponemos el propietario anterior
			$(chown "$prop" "$ruta")
			# Ponemos el grupo anterior
			$(chgrp "$grup" "$ruta")
			# Ponemos los permisos anteriores
			$(chmod "$perm" "$ruta")
		done < $fitxer
	else 
		echo "Error: no existe el fichero especificado por parametro." >&2
	fi
fi
