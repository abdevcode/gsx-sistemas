#! /bin/bash

#Autors:
#- Abderrahim Talhaoui
#- Oriol Manzanero Perez
#- Ramon Donadeu Caballero

#Data: 11/02/2020 
#Versio: 1.1

#Realitzeu   un   script   anomenat  rpgp.sh  (restaura   propietari,   grup   ipermisos) que rebi per paràmetre un fitxer amb la informació de sortidade l'exercici anterior i demani confirmació per a modificar els permisos,propietari i/o grup dels fitxers del sistema per tal que les dues cosescoincideixin. L'script ha de mostrar la informació actual i la informació del fitxer, en cas que sigui diferent, i demanarà confirmació per provocar quesigui igual. L'script informarà per pantalla si falta algun fitxer que estiguien el fitxer passat per paràmetre i ara no estigui al sistema, tambéinformarà un resum dels canvis que s'han realitzat.

# rpgp.sh <fitchero entrada> [<opcion defecto>]
# <fitchero entrada>: Fichero salida que genera el script gpgp.sh
# <opcion defecto>: Opcion por defecto para modificar de manera automatica los ficheros, si no se pasa el argumento se preguntara antes de realizar cualquier accion

# Funcion para pedir la confirmacion al usuario antes de realizar un cambio en el fichero
ask_user_change_file() {
	#local result='-'
	result='-'
	while true; do
		read -p "Vol modificar els permisos, propietari i/o grup del fitxer? [si|s|no|n] " opcion
		case $opcion in
			si | s ) 
				return 1;;
			no | n) 
				return 0;;
			* ) 
				echo "Opcio no valida! :/";;
		esac
	done
}


# Verificacio de les opcions i dels parametres 
if [ $# -eq 0 ]; then 
	#Treiem error per canal stderr 
	echo "Error: sin parametros." >&2
	exit 1
fi

fitxer=$1
opcion_param=$2

# Permitir establecer una opcion por defecto para el script
if [ ! -z "$opcion_param" ]; then
    case "$opcion_param" in
		si | s ) 
			mod_file=1;;
		no | n) 
			# Si no vamos a realizar ningun cambio, salimos
			exit 0;;
		* ) # Si la opcion no es valida, salimos!
			echo "Opcio no valida! :/">&2
			exit 1
			;;
	esac
fi

#Validar que existeix el fitxer
if [ -f $fitxer ]; then
	#Separador de camp (IFS) - per assignar car especials amb $''
	IFS=$'\n'
	for line in $(cat $fitxer); do
		num_espacios=$(echo $line | wc -w)
		let ini=1
		let end=$(echo "$num_espacios-3" | wc -w)

		ruta=$(echo $line | cut -d' ' -f $ini-$end)

		let ini=$end+1
		let end=$end+1
		prop_ant=$(echo $line | cut -d' ' -f $ini-$end)

		let ini=$end+1
		let end=$end+1
		grup_ant=$(echo $line | cut -d' ' -f $ini-$end)

		let ini=$end+1
		let end=$end+1
		perm_ant=$(echo $line | cut -d' ' -f $ini-$end)

		if [ -e $ruta ]; then
			prop_act=$(stat "$ruta" --printf=%U)
			grup_act=$(stat "$ruta" --printf=%G)
			perm_act=$(stat "$ruta" --printf=%a)

			if [ "$prop_act" != "$prop_ant" ] || [ "$grup_act" != "$grup_ant" ] || [ "$perm_act" != "$perm_ant" ]; then
				echo "=================================="
				echo "ruta: $ruta"
				echo -e "Anterior: \t $prop_ant \t $grup_ant \t $perm_ant"
				echo -e "Actual:   \t $prop_act \t $grup_act \t $perm_act"

				# En caso de no tener el segundo parametro, le preguntamos al usuario que quiere hacer
				if [ -z "$opcion_param" ]; then
					# Llamada a la funcion para preguntar al usuario
					ask_user_change_file
					mod_file=$?
				fi

				if [ $mod_file -eq 1 ]; then
					echo "Modifiquem els fitxers"

					# Modificamos el propietario, el grupo y los permisos
					$(chown "$prop_ant" "$ruta") # Ponemos el propietario anterior
					$(chgrp "$grup_ant" "$ruta") # Ponemos el grupo anterior
					$(chmod "$perm_ant" "$ruta") # Ponemos los permisos anteriores
				fi
			fi
		else
			#echo "Error: No existe dir/fit de la path: $ruta" >&2 
			echo "=================================="
			echo "Error: No existe dir/fit de la path: $ruta"
		fi
	done
else 
	echo "Error: no existe el fichero especificado por parametro." >&2
fi

