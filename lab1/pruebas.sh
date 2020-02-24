#! /bin/bash

carpeta_test="./test/"
n_dir=2
n_files_dir=1

if [ -d $carpeta_test ]; then
    #echo "Borrar carpeta $carpeta_test"
    $(rm -r "$carpeta_test")
fi

#echo "Crear carpeta $carpeta_test"
$(mkdir "$carpeta_test")

for (( i=1; i<=$n_dir; i++ )); do  
    dir="dird$i/"
    usuario=$(( RANDOM % 8 ))
    grupo=$(( RANDOM % 8 ))
    otro=$(( RANDOM % 8 ))

    $(mkdir "$carpeta_test$dir")
    $(chmod $usuario$grupo$otro "$carpeta_test$dir")

    #echo "$usuario$grupo$otro $carpeta_test$dir"
    #echo \"$(realpath "$carpeta_test$dir")\"
	dirpath=$(realpath "$carpeta_test$dir")
	echo $dirpath

    for (( j=1; j<=$n_files_dir; j++ )); do  
        file="fitf$j.txt"
        file_usuario=$(( RANDOM % 8 ))
        file_grupo=$(( RANDOM % 8 ))
        file_otro=$(( RANDOM % 8 ))

        $(touch "$carpeta_test$dir$file")
        $(chmod $file_usuario$file_grupo$file_otro "$carpeta_test$dir$file")

        #echo "$file_usuario$file_grupo$file_otro $carpeta_test$dir$file"
        #echo \"$(realpath "$carpeta_test$dir$file")\"
		fitpath=$(realpath "$carpeta_test$dir$file")
		echo $fitpath
    done
done


