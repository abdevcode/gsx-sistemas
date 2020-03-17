#! /bin/bash

#Autors:
#- Abderrahim Talhaoui
#- Oriol Manzanero Perez
#- Ramon Donadeu Caballero

#Data: 8/03/2020 
#Versio: 1.0

#Script que  atura els processos que han consumit més de 3 minuts de
#cpu cada hora des de les 10 del matí a les 8 de la tarda, creant un
#fitxer on anirem acumulant els PIDs dels processos aturat

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
			resultat=$(grep $pid f_parats)
			if [ ! $? -eq 0 ]; then
				#Si estem aqui no l'hem parat abans
				kill -15 $pid
				echo $pid >> f_parats
			fi
		fi
	fi
	let i=$i+1

done
