#! /bin/bash

#Autors:
#- Abderrahim Talhaoui
#- Oriol Manzanero Perez
#- Ramon Donadeu Caballero

#Data: 8/03/2020 
#Versio: 1.0
#Que fa l'script bla bla bla

#Creem el fitxer si no existeix
if [ ! -f f_parats ]; then
	touch f_parats
fi

IFS=$'\n'
i=0
for proces in $(ps -eo pid,time); do
	#Em salto el primer perque posa  PID 	TIME
	if [ $i -gt 0 ]; then
		pid=$(echo $proces | awk '{print $1}')
		temps=$(echo $proces | awk '{print $2}')	
		minuts=${temps:3:2}
		if [ $minuts -gt 2 ]; then
			#Si estem aqui el procés ha durat més de 3 minuts
			resultat=$(grep -r $pid f_parats)
			if [ $resultat -eq $pid ]; then
				#Si estem aqui ja l'hem parat abans
			fi
			kill -15 $pid
		fi
	fi
	let i=$i+1

done
