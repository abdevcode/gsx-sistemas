#! /bin/bash

#Autors:
#- Abderrahim Talhaoui
#- Oriol Manzanero Perez
#- Ramon Donadeu Caballero

#Data: 11/02/2020 
#Versio: 1.2

#Script que rep per paràmetre un fitxer. En aquest fitxer hi haurà el
#path absolut de fitxers. L'script mostrarà per pantalla el path absolut del fitxer, seguit del
#propietari, grup i permisos que té actualment aquest fitxer.



#Verificacio de les opcions i dels parametres 
if [ $# -eq 0 ]; then 
	#Treiem error per canal stderr 
	echo "Error: sin parametros." >&2
else
	fitxer=$1
	#Validar que existeix el fitxer
	if [ -f $fitxer ]; then
		#Separador de camp (IFS) - per assignar car especials amb $''
		IFS=$'\n'
		#Obtenir les dades per cada ruta especificada en el fitxer		
		for path in $(cat $fitxer); do
		#for read path; do
			
			#echo "path: $path"
			if [ -e $path ]; then
				propietari=$(stat "$path" --printf=%U)
				grup=$(stat "$path" --printf=%G)
				perm=$(stat "$path" --printf=%a)

				echo "$path $propietari $grup $perm"
			else
				echo "Error: No existe dir/fit de la path: $path" >&2 
			fi
		done
	else 
		echo "Error: no existe el fichero especificado por parametro." >&2
	fi
fi
