#! /bin/bash

#Verificacio de les opcions i dels parametres 
if [ $# -eq 0 ]; then 
	#Treiem error per canal stderr 
	echo "Error: sin parametros." >&2
else
	direccio=$(find /projectes -type d -name $1)
	if [ -z $direccio ]; then
		echo "Error: no existe el grupo especificado por parametro." >&2
	else 
		cd $direccio
		time newgrp $1
	fi
fi




