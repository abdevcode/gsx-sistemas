#! /bin/bash

#Autors:
#- Abderrahim Talhaoui
#- Oriol Manzanero Perez
#- Ramon Donadeu Caballero

#Data: 11/02/2020 
#Versio: 1.2

#Aquest script, crea les carpetes necesaries per als projectes, llegeix el fitxer passat per parametre i crea un grup amb les dades indicades dins el fitxer, tambe canvia els permisos de la carpeta del grup i modifiquem els permisos per defecte de la propia carpeta.


#Verificacio de les opcions i dels parametres 
if [ $# -eq 0 ]; then 
	#Treiem error per canal stderr 
	echo "Error: sin parametros." >&2
else
	mkdir -p "/usuarios"
	mkdir -p "/projectes"
	mkdir -p "/projectes/enestudi"
	mkdir -p "/projectes/encurs"
	mkdir -p "/projectes/finalitzats"

	fitxer=$1
	count=0
	mod=4
	#Validar que existeix el fitxer
	if [ -f $fitxer ]; then
		#Separador de camp (IFS) - per assignar car especials amb $''
		IFS=$'\n'
		#Obtenir les dades per cada ruta especificada en el fitxer		
		for info in $(cat $fitxer); do
			if [ $count -eq $mod ]; then
				count=0	
			fi		
			#Agafem els valors del fitxer per crear el grup
			case $count in
				0) #Agafem el nom del projecte
					nomprj=$(echo $info)
					;;
				1) #Agafem el comentari
					coment=$(echo $info)
					;;
				2) #Agafem el dni del cap del projecte
					dnicap=$(echo $info)
					;;
				3)  #Agafem els treballadors del projecte
					direccio="/projectes/enestudi"
					treb=$(echo $info)					
					cd $direccio				
					mkdir -p $nomprj
					#Creem el grup
					groupadd -f $nomprj
					echo $nomprj:"grouppassword" | chgpasswd
					#Afegim el cap del projecte al grup
					usermod -a -G $nomprj $dnicap
					#Afegim els demes membres al grup
					#Cambiar el grup del fitxer
					direccio="$direccio/$nomprj"
					chgrp $nomprj $direccio
					#Afegim tots els treballadors al grup
					IFS=","
					for usuari in $treb; do
						usermod -a -G $nomprj $usuari
					done
					#Canviem els permisos i els permisos per defecte
					chown $dnicap $direccio		
					chmod 775 $direccio
					setfacl -Rdm o::--x $direccio	
					;;
				*)				
			esac
			let count=$count+1
			IFS=$'\n'			
		done
	else 
		echo "Error: no existe el fichero especificado por parametro." >&2
	fi
fi




