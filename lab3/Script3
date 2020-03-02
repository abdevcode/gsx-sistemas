#! /bin/bash

#Autors:
#- Abderrahim Talhaoui
#- Oriol Manzanero Perez
#- Ramon Donadeu Caballero

#Data: 2/03/2020 
#Versio: 1.2
#Que fa l'script bla bla bla
echo "Els processos creats entre les 13.00 i les 15.00 son:"
echo " COMANDA -- USUARI"

h_inici=12
h_fi=15

#Obtinc els processos que 
IFS=$'\n'
i=0
for proces in $(ps aux | awk '{print $2, $9, $1, $11}'); do
	#M'he de saltar el primer perque es la guia
	if [ $i -gt 0 ]; then
		inici=$(echo $proces | awk '{print $2}')
		hora=${inici:0:2}
		minut=${inici:3:5}
		if [ $hora -gt $h_inici ]; then 
			if [ $hora -lt $h_fi ]; then 
				#Si hem entrat aqui el proces s'ha creat al marge especificat
				usuari=$(echo $proces | awk '{print $3}')
				comanda=$(echo $proces | awk '{print $4}')
				echo "$comanda -- $usuari"
			fi
		fi
	fi
	let i=$i+1
done

