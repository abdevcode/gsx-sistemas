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
		for usuari in $(sed 1d $fitxer); do

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
			if [ ! -d /usuarios/$dep ];then
				mkdir -p "/usuarios/$dep"	
			fi
			useradd -m $dni -d /usuarios/$dep/$dni -c "$nom, $tlf" -k /etc/skel
		done
	else 
		echo "Error: no existe el fichero especificado por parametro." >&2
	fi
fi




