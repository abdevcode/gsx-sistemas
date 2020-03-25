#!/bin/sh

# Aqui falta poner comentario y cosas 


fit_paths="paths.txt"
fit_gpgp="gpgp.out"
fit_rpgp="rpgp.out"
dir_back="/back"

# Obtenemos la copia de seguridad mas reciente 
tar_back=$(ls -Art "$dir_back" | tail -n 1)

# Descomprimimos el fichero paths.txt
tar -xf "$dir_back/$tar_back" "$fit_paths" 

# Descomprimimos el fichero gpgp.out
tar -xf "$dir_back/$tar_back" "$fit_gpgp" 

# Validamos que los ficheros existen
if [ ! -f "$fit_gpgp" ]; then
	echo "Error: no existe el fichero $fit_gpgp." >&2
	exit 1
fi

if [ ! -f "$fit_paths" ]; then
	echo "Error: no existe el fichero $fit_paths." >&2
	exit 1
fi

# Primero vamos a descomprimir y ubicar todos los ficheros donde estaban
# Separador de camp (IFS) - per assignar car especials amb $''
IFS=$'\n'
# Obtenir les dades per cada ruta especificada en el fitxer		
for path in $(cat "$fit_paths"); do
	echo $path
	# Quitamos la '/' inicial
	cut_path=$(echo $path | cut -c2-)
	
	# A lo mejor hace falta validar/crear los directorios donde ira el fichero

	# Descomprimimos el fichero en el directorio
	tar -C / -xf "$dir_back/$tar_back" "$cut_path"
done

# Ejecutamos el script rpgp.sh para restaurar permisos, propietario y grupo
# No usamos el '.' porque no queremos salir de este script si se hace un exit en el script rpgp.sh
$(./rpgp.sh "$fit_gpgp" "si" >> "$fit_rpgp")

rm "$fit_paths"
rm "$fit_gpgp"




