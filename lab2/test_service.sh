#! /bin/bash

#DATE=`date '+%Y-%m-%d %H:%M:%S'`
DATE=`date '+%y%m%d%H%M'`
data_inici=$((stat -c  %y /etc/resolv.conf) | awk '{print $1}')
any_i=${data_inici:0:4}
mes_i=${data_inici:5:2}
dia_i=${data_inici:8:2}
temps_i=$((stat -c  %y /etc/resolv.conf) | awk '{print $2}') 
hora_i=${temps_i:0:2}
minut_i=${temps_i:3:2}

#amb stat -c  %y podem saber la modificació del fitxer
#resolv.conf es el que miro per saber si s'ha canviat el fitxer

if [ ! -d "/back" ]; then

	(mkdir "/back")
fi
(mkdir "/back/$DATE")
echo "S'esta buscant els fitxers que han sigut modificats..."

#For al directori /usr
for ruta in $(find /home/milax/GSX/lab2 \! -name ".*");do
	
	#echo "\"$ruta\"" 
	if [ -f $ruta ]; then
		data=$((stat -c  %y $ruta) | awk '{print $1}') 
		any=${data:0:4}
		mes=${data:5:2}
		dia=${data:8:2}
		temps=$((stat -c  %y $ruta) | awk '{print $2}') 
		hora=${temps:0:2}
		minut=${temps:3:2}
		#mirem si el fitxer del path ha sigut modificat
		if [ $any -gt $any_i ]; then
			echo $ruta >> paths.txt
		elif [ $any -eq $any_i ]; then
			if [ $mes -gt $mes_i ]; then
				echo $ruta >> paths.txt
			elif [ $mes -eq $mes_i ]; then
				if [ $dia -gt $dia_i ]; then
					echo $ruta >> paths.txt
				elif [ $dia -eq $dia_i ]; then
					if [ $hora -gt $hora_i ]; then
						echo $ruta >> paths.txt
					elif [ $hora -eq $hora_i ]; then
						if [ $minut -gt $minut_i ]; then
							echo $ruta >> paths.txt
							nom=$(basename $ruta)
							echo "$nom"
							(cp $ruta /back/$DATE/$nom)
						fi
					fi 
				fi
			fi
		fi
	fi
done

#Executem el script per guardar els permisos i tal i ho redirigim a un fitxer de text
. gpgp.sh paths >> resultat.txt

#fer un for ==> 
#fer un for ==> find /home




echo "Example service started at ${DATE}" | systemd-cat -p info
<< ////
while :
do
echo "Looping...";
sleep 30;
done
////
