#! /bin/bash

#Verificacio de les opcions i dels parametres 
if [ $# -eq 0 ]; then 
	#Treiem error per canal stderr 
	echo "Error: sin parametros." >&2
else
	direccio=$(find /projectes -type d -name $1)
	echo $direccio
	if [ -z $direccio ]; then
		echo "Error: no existe el grupo especificado por parametro." >&2
	else 
		cd "$direccio"
		touch proba.txt
		echo $USER $(id -g milax)
		save=$(id -g milax)
		echo $save
		newgrp - $1 $milax
		echo $USER $(id -g milax)
		
	fi
fi




