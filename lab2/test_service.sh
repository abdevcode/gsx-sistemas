#! /bin/bash

# Crear la carpeta de las copias de seguridad
mkdir -p "/back" # -p : Crea els directoris pare necessaris, sense mostrar errors si aquests ja existeixen.
date_act=$(date '+%y%m%d%H%M')
dir_back="/back/$date_act"
mkdir $dir_back





# Para saber la fecha actual
up_time=$(uptime -s)
udate_start=$(date -d "$up_time" +%s) # Hora UNIX de la fecha 

# Directorios que queremos guardar separados por espacio en blanco
dir_save="/usr /home"

for directori_busca in $dir_save; do
	for ruta in $(find $directori_busca -type d -name ".*" -prune -o -type f \! -name ".*" -print); do
		if [ -f $ruta ]; then
			date_file=$(date -r "$ruta" "+%Y-%m-%d %H:%M:%S")
			udate_file=$(date -d "$date_file" +%s) # Hora UNIX de la fecha 
			
			if [ $udate_file -gt $udate_start ]; then
				echo $ruta
			fi 
		fi
	done
done


#Executem el script per guardar els permisos i tal i ho redirigim a un fitxer de text
. gpgp.sh paths.txt >> resultat.txt
#Copiem la resta dels fitxers a la carpeta
cp paths.txt /back/$DATE/paths.txt
cp resultat.txt /back/$DATE/resultat.txt
#Ens movem a la zona on esta el backup
cd /back
#comprimim en tgz
sudo tar -czvf $DATE.tar.gz $DATE
#Esborrem la carpeta anterior per deixar nomes el fitxer comprimit
sudo rm -r $DATE



exit
exit 
exit

#DATE=`date '+%Y-%m-%d %H:%M:%S'`
#DATE=`date '+%y%m%d%H%M'`
#data_inici=$((stat -c  %y /etc/resolv.conf) | awk '{print $1}')
#any_i=${data_inici:0:4}
#mes_i=${data_inici:5:2}
#dia_i=${data_inici:8:2}
#temps_i=$((stat -c  %y /etc/resolv.conf) | awk '{print $2}') 
#hora_i=${temps_i:0:2}
#minut_i=${temps_i:3:2}

#amb stat -c  %y podem saber la modificació del fitxer
#resolv.conf es el que miro per saber si s'ha canviat el fitxer



#Busquem als directoris

directori_busca="/usr"
contador=1
echo "S'esta buscant els fitxers que han sigut modificats..."

while [ $contador -lt 2 ]; do
	for ruta in $(find $directori_busca -type d -name ".*" -prune -o -type f \! -name ".*" -print);do
		 
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
								cp $ruta /back/$DATE/$nom
							fi
						fi 
					fi
				fi
			fi
		fi
	done
	directori_busca="/home"
	let contador=$contador+1
done

#Executem el script per guardar els permisos i tal i ho redirigim a un fitxer de text
. gpgp.sh paths.txt >> resultat.txt
#Copiem la resta dels fitxers a la carpeta
cp paths.txt /back/$DATE/paths.txt
cp resultat.txt /back/$DATE/resultat.txt
#Ens movem a la zona on esta el backup
cd /back
#comprimim en tgz
sudo tar -czvf $DATE.tar.gz $DATE
#Esborrem la carpeta anterior per deixar nomes el fitxer comprimit
sudo rm -r $DATE



