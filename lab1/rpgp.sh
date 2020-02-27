#! /bin/bash

#Autors:
#- Abderrahim Talhaoui
#- Oriol Manzanero Perez
#- Ramon Donadeu Caballero

#Data: 11/02/2020 
#Versio: 1.1

#Realitzeu   un   script   anomenat  rpgp.sh  (restaura   propietari,   grup   ipermisos) que rebi per paràmetre un fitxer amb la informació de sortidade l'exercici anterior i demani confirmació per a modificar els permisos,propietari i/o grup dels fitxers del sistema per tal que les dues cosescoincideixin. L'script ha de mostrar la informació actual i la informació delfitxer, en cas que sigui diferent, i demanarà confirmació per provocar quesigui igual. L'script informarà per pantalla si falta algun fitxer que estiguien el fitxer passat per paràmetre i ara no estigui al sistema, tambéinformarà un resum dels canvis que s'han realitzat.


read -p "Vol modificar els permisos, propietari i/o grup del fitxer? [si|no] " opcion
case $opcion in
	si ) echo "si! :)";;
	no ) echo "no! :(";;
	* ) echo "Opcio no valida! :/";;
esac

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
		for line in $(cat $fitxer); do
			num_espacios=$(echo $line | wc -w)
			ini=1
			end=$(echo "$num_espacios-3" | bc)

			ruta=$(echo $line | cut -d' ' -f $ini-$end)

			ini=$(echo "$end+1" | bc)
			end=$(echo "$end+1" | bc)
			prop=$(echo $line | cut -d' ' -f $ini-$end)

			ini=$(echo "$end+1" | bc)
			end=$(echo "$end+1" | bc)
			grup=$(echo $line | cut -d' ' -f $ini-$end)

			ini=$(echo "$end+1" | bc)
			end=$(echo "$end+1" | bc)
			perm=$(echo $line | cut -d' ' -f $ini-$end)


			#echo "$line -- $ini -- $end"

		    #echo "$ruta | $prop | $grup | $perm"
			
			# Ponemos el propietario anterior
			$(chown "$prop" "$ruta")
			# Ponemos el grupo anterior
			$(chgrp "$grup" "$ruta")
			# Ponemos los permisos anteriores
			$(chmod "$perm" "$ruta")
		done

	else 
		echo "Error: no existe el fichero especificado por parametro." >&2
	fi
fi





