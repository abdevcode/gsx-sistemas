#! /bin/bash

#Autors:
#- Abderrahim Talhaoui
#- Oriol Manzanero Perez
#- Ramon Donadeu Caballero

#Data: 2/03/2020 
#Versio: 1.2
#Volem saber el nom de la comanda i el nom de l’usuari que han
#generats els processos que han estat engegats entre les 13:00 i les
#14:5

echo "Els processos creats entre les 13.00 i les 15.00 son:"
echo " COMANDA -- USUARI"
h_inici=12
h_fi=15

data_actual=$(date)
dia_actual=$(echo $data_actual | awk '{print $3}')
mes_actual=$(echo $data_actual | awk '{print $2}')
mes_actual=$(echo -n ${mes_actual:0:1} | tr '[:lower:]' '[:upper:]' ; echo ${mes_actual:1} | tr '[:lower:]' '[:lower:]')
#Obtinc els processos que 
IFS=$'\n'
i=0
service acct stop
for proces in $(lastcomm); do
	
	#Conto quantes paraules te la resposta
	paraules=$(echo $proces | wc -w )
	#Depenent de les paraules que tingui haure d'agafar de diferents posicions
	inici=$(echo $proces | awk -v final="$paraules" '{print $final}')
	let paraules=$paraules-1
	dia=$(echo $proces | awk -v final="$paraules" '{print $final}')
	let paraules=$paraules-1
	mes=$(echo $proces | awk -v final="$paraules" '{print $final}')
	let paraules=$paraules-5
	usuari=$(echo $proces | awk -v pos_usu="$paraules" '{print $pos_usu}')	
	#M'he de saltar el primer perque es la guia
	
	if [ $i -gt 0 ]; then
		if [ $dia -eq $dia_actual ]; then
			if [ "$mes" = "$mes_actual" ]; then
				hora=${inici:0:2}
				minut=${inici:3:5}
				if [ $hora -gt $h_inici ]; then 
					if [ $hora -lt $h_fi ]; then 
						#Si hem entrat aqui el proces s'ha creat al marge especificat
						comanda=$(echo $proces | awk '{print $1}')
						echo "$comanda -- $usuari"
					fi
				fi
			fi
		fi
	fi
	let i=$i+1
done
service acct start

