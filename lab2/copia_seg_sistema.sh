#! /bin/bash

# Este es el script que se llamara para ejecutar la copia de seguridad 
# Instrucciones de uso:
# 1) Este script tiene que estar ubicado en "/usr/bin/"
#    1. sudo cp copia_seg_sistema.sh /usr/bin/copia_seg_sistema.sh
#    2. sudo chmod +x /usr/bin/copia_seg_sistema.sh





# Es vol programar un servei que s'executi al aturar el sistema, aquest script 
# ha de crear un fitxer amb el path absolut dels fitxers modificats des de l’última 
# vegada que es va engegar el sistema  que estiguin sota dels directoris /usr i del /home, 
# no ha d'incloure els fitxers que comencin per . ni els que estiguin per sota de 
# directoris que comencinper .. Desprès es vol executar la comanda gpgp.sh amb el fitxer 
# creat i a continuaciófer una copia de seguretat comprimida (crear un fitxer tgz) d'aquests 
# fitxers i del fitxer resultant de l'execució del gpgp.sh i del fitxer creat inicialment.
# La còpia la deixarem sota un directori anomenat /back/dir on dir serà el any, mes i dia en 
# que s'ha fet la còpia en el format: 'aammddhhmm'. Aquesta servei el volem fer seguint el 
# format de serveis systemd.



# Crear la carpeta de las copias de seguridad

mkdir -p "/back" # -p : Crea els directoris pare necessaris, sense mostrar errors si aquests ja existeixen.
date_act=$(date '+%y%m%d%H%M')
dir_back_date="/back/$date_act"
dir_back_temp="/back/temp"
#mkdir $dir_back_date
mkdir $dir_back_temp





# Para saber la fecha actual
up_time=$(uptime -s)
udate_start=$(date -d "$up_time" +%s) # Hora UNIX de la fecha 

# Directorios que queremos guardar separados por espacio en blanco
#dir_save="/usr /home"
dir_save="/home"

for directori_busca in $dir_save; do
	for ruta in $(find $directori_busca -type d -name ".*" -prune -o -type f \! -name ".*" -print); do
		if [ -f $ruta ]; then
			date_file=$(date -r "$ruta" "+%Y-%m-%d %H:%M:%S")
			udate_file=$(date -d "$date_file" +%s) # Hora UNIX de la fecha 
			
			if [ $udate_file -gt $udate_start ]; then
				echo $ruta >> "$dir_back_temp/paths.txt"
				cp "$ruta" "$dir_back_temp"
			fi 
		fi
	done
done


#Executem el script per guardar els permisos i tal i ho redirigim a un fitxer de text
. gpgp.sh "$dir_back_temp/paths.txt" >> "$dir_back_temp/gpgp.out"

#Copiem la resta dels fitxers a la carpeta
# cp paths.txt /back/$DATE/paths.txt
# cp resultat.txt /back/$DATE/resultat.txt
#Ens movem a la zona on esta el backup
#cd /back
#comprimim en tgz
echo "tar -czvf "$dir_back_date.tar.gz" "$dir_back_temp""
tar -czvf "$dir_back_date.tar.gz" "$dir_back_temp"
#Esborrem la carpeta anterior per deixar nomes el fitxer comprimit
#rm -r $DATE
#rm -r "$dir_back_temp"


