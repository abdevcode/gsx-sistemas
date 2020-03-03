#! /bin/bash

#Verificacio de les opcions i dels parametres 
if [ $# -eq 0 ]; then 
	#Treiem error per canal stderr 
	echo "Error: sin parametros." >&2
else
	mkdir -p "/usuarios"

	fitxer=$1
	#Validar que existeix el fitxer
	if [ -f $fitxer ]; then
		#Separador de camp (IFS) - per assignar car especials amb $''
		IFS=$'\n'
		#Obtenir les dades per cada ruta especificada en el fitxer		
		for usuari in $(cat $fitxer); do


			if [ $i -gt 0 ]; then # ESTO NO GUACHO


				let ini=1
				let end=1

				dni=$(echo $usuari | cut -d':' -f $ini-$end)

				let ini=$end+1
				let end=$end+1
				nom=$(echo $usuari | cut -d':' -f $ini-$end)

				let ini=$end+1
				let end=$end+1
				tlf=$(echo $usuari | cut -d':' -f $ini-$end)

				let ini=$end+1
				let end=$end+1
				dep=$(echo $usuari | cut -d':' -f $ini-$end)

				echo "$dni - $nom - $tlf - $dep"

				mkdir -p "/usuarios/$dep"
				sudo useradd -b /usuarios/disseny -d 39456754D -c "hoy se sale" -u 95682344 -m user44

			fi # ESTO NO GUACHO ECSTREMO
			let i=$i+1 # ESTO NO GUACHO


		done
	else 
		echo "Error: no existe el fichero especificado por parametro." >&2
	fi
fi




