#! /bin/bash

#Autors:
#- Abderrahim Talhaoui
#- Oriol Manzanero Perez
#- Ramon Donadeu Caballero

# Data 04/04/2020
# Versio 1.0

#Aquest script substitueix la comanda lp, i en cas d'utilitzar la impresora virtualImpre te un funcionament diferent.

if [ $# -eq 0 ];then
	echo "No hi ha cap parametre"
else
	boolea=0
	for parametre in $@; do
		param_ant=$param
		param=$parametre
		# Si trobem -d virtualImpre
		if [ $param = "virtualImpre" ] && [ $param_ant = "-d" ]; then
			boolea=1
			if [ ! -f /usr/local/secret ];then
				echo "El fitxer /usr/local/secret no existeix, el crearem i afegirem el usuari $USER amb contrasenya 'password'"
				touch /usr/local/secret
				password=$(openssl passwd -crypt -salt "pepino" "password")
				echo "$USER $password" > /usr/local/secret
			fi		
			# Si trobem l'usuari a secret	
			if grep -q $USER /usr/local/secret; then
				echo "Introdueix la paraula clau:"
				stty -echo #Amagem el input
				read clau	
				stty echo #Tornem a fer el input visible
				# Si la contrasenya es correcte
				if [ $(openssl passwd -crypt -salt "pepino" $clau) = $(grep $USER /usr/local/secret | cut -d ' ' -f 2) ];then	
					#Executem la comanda amb els valors introduits per l'usuari
					lp $*
				else
					echo "Contrasenya incorrecte"
				fi
			else
				echo "Aquest usuari no pot utilitzar aquesta impresora"
			fi
		fi
	done
	#Si la impresora no era virtualImpre executem lp amb la comanda que ha introduit l'usuari
	if [ $boolea -eq 0 ];then
		lp $*
	fi
fi	
