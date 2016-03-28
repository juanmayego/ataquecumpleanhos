
#Ataque de cumpleaños
#Funcionamiento:
#1-Lee palabras de un archivo de palabras originales.
#2-A cada palabra le crea un hash, ordena estos hashes, los coloca en un array y los guarda en un archivo.
#3-Lee palabras de un archivo de palabras fraudulentas.
#4-A cada palabra le crea un hash, los ordena, los coloca en un array y los guarda en un archivo.
#5-Busca una coincidencia entre los hashes de las palabras originales y las fraudulentas.
#6-Retorna el tiempo que duro la ejecucion

#####################################################################
#                       Definicion de funciones                     #
#####################################################################

imprimirArray()
{
  
  echo ${ARRAY[*]}

}

quicksort() {
    # sorts the positional elements wrt alphanumerical sort
    # return is in array quicksort_ret
    if (($#==0)); then
        quicksort_ret=()
        return
    fi
    local pivot=$1 greater=() lower=() i
    shift
    for i; do
        if [[ "$i" < "$pivot" ]]; then
            lower+=( "$i" )
        else
            greater+=( "$i" )
        fi
    done
    quicksort "${greater[@]}"
    greater=( "${quicksort_ret[@]}" )
    quicksort "${lower[@]}"
    quicksort_ret+=( "$pivot" "${greater[@]}" )
}


quicksortIterativo() {
   (($#==0)) && return 0
   local stack=( 0 $(($#-1)) ) beg end i pivot smaller larger
   quicksort_ret1=("$@")
   
   while ((${#stack[@]})); do
      beg=${stack[0]}
      end=${stack[1]}
      stack=( "${stack[@]:2}" )
      smaller=() larger=()
      pivot=${quicksort_ret1[beg]}
      for ((i=beg+1;i<=end;++i)); do
         if [[ "${quicksort_ret1[i]}" < "$pivot" ]]; then
            smaller+=( "${quicksort_ret1[i]}" )
         else
            larger+=( "${quicksort_ret1[i]}" )
         fi
      done
	  valor=2
      quicksort_ret1=( "${quicksort_ret1[@]:0:beg}" "${smaller[@]}" "$pivot" "${larger[@]}" "${quicksort_ret1[@]:end+1}" )
      if ((${#smaller[@]} >= $valor)); then stack+=( "$beg" "$((beg+${#smaller[@]}-1))" ); fi
      if ((${#larger[@]} >= $valor)); then stack+=( "$((end-${#larger[@]}+1))" "$end" ); fi
   done
}



binarysearch()
{
	
	
	
    status=-1
    i=0
	LowIndex=0
    HeighIndex=$((${#ARRAY2[@]}-1))
		
    while [ $LowIndex -le $HeighIndex ]
    do

        MidIndex=$(($LowIndex+($HeighIndex-$LowIndex)/2))
        MidElement=${ARRAY2[$MidIndex]}
		if [[ $MidElement = "$temp" ]]
        then
            status=0
            searches=$i
            return
        elif [[ ${temp}<$MidElement ]]
        then
            HeighIndex=$(($MidIndex-1))
        else
            LowIndex=$(($MidIndex+1))
        fi

        let i++

    done
}

stringToArray() {
	str=$1
	len=${#str} # halla la longitud de la cadena

	for ((i=0; i<len; i++));
	do
	   array[i]=${str:i:1} # saca cada caracter y coloca en una posicion del vector
	done

}



arrayToString() {
	#vec=$1
	len=${#quicksort_ret[@]}
	#echo $len

	for ((i=0; i<len; i++));
	do
	   var="${quicksort_ret[i]}"
	   palabra=$palabra$var # concatena cada caracter del vector
	done

}
arrayToString1() {
	#vec=$1
	len=${#quicksort_ret1[@]}
	#echo $len

	for ((i=0; i<len; i++));
	do
	   var="${quicksort_ret1[i]}"
	   palabra=$palabra$var # concatena cada caracter del vector
	done

}
#####################################################################
#                       El script se ejecuta desde aqui             #
#####################################################################

clear

start_time=$(date +%s)

echo "-Lee el archivo palabrasOrig.txt"
true > origOrd.txt
cont=0

while read line1
do
	let cont=cont+1
	palabraOrig=$line1 # extrae la palabra original
	palabraOrigHash=$(echo -n $palabraOrig | sha1sum) # crea el hash de la palabra
	stringToArray "$palabraOrigHash" # copia el string a un array para poder ordenar
	quicksort "${array[@]}" # ordena el array
	vectorHashesOrig=("${quicksort_ret[@]}")
	palabra=""
	arrayToString "${quicksort_ret[@]}" # crea un string de vuelta
	echo $palabra >> origOrd.txt
	
done < palabrasOrig.txt

echo "-Crea los hashes de cada palabra"
echo "-Ordena los hashes"
echo "-Escribe los hashes ordenados en el archivo origOrd.txt"
echo $cont
echo 

#3-Lee palabras de un archivo de palabras fraudulentas.

echo "-Lee el archivo palabrasModif.txt"
true > modifOrd.txt

#4-A cada palabra le crea un hash, los ordena, los coloca en un array y los guarda en un archivo.

cont=0

while read line2
do
	let cont=cont+1
	palabraModif=$line2 # extrae la palabra original
	palabraModifHash=$(echo -n $palabraModif | sha1sum) # crea el hash de la palabra
	stringToArray "$palabraModifHash" # copia el string a un array para poder ordenar
	quicksort "${array[@]}" # ordena el array
	vectorHashesMod=("${quicksort_ret[@]}")
	palabra=""
	arrayToString "${quicksort_ret[@]}" # crea un string de vuelta
	echo $palabra >> modifOrd.txt
done < palabrasModif.txt

echo "-Crea los hashes de cada palabra"
echo "-Ordena los hashes"
echo "-Escribe los hashes ordenados en el archivo modifOrd.txt"
echo "-Hashes creados: $cont"



declare -a ARRAY

i=0
while read linea1 
do
		i=$(($i+1))
		ARRAY[i]=${linea1}
		

	    
done < origOrd.txt
		
let i++
ARRAY[i]=${linea1}    


quicksortIterativo "${ARRAY[@]}"

ARRAY1=("${quicksort_ret1[@]}")

for (( ini=1; ini<${#ARRAY1[@]}; ini++ ))
do
   echo ${ARRAY1[ini]}>>origOrd1.txt
done


i=0
while read linea2 
do
		i=$(($i+1))
		ARRAY[i]=${linea2}
		


done < modifOrd.txt

let i++
ARRAY[i]=${linea2}
quicksortIterativo "${ARRAY[@]}"

ARRAY2=("${quicksort_ret1[@]}")

for (( ini=1; ini<${#ARRAY2[@]}; ini++ ))
do
   echo ${ARRAY2[ini]}>>modifOrd1.txt
done



#Buscando elementos


coincidencias=0
echo -e "-Iniciando busqueda...\n"

for((inicio=1;inicio<cont;inicio++))

do
     
     temp=${ARRAY1[inicio]}
	 binarysearch

     if [ $status -eq 0 ]
     then
	     let coincidencias++
		 echo -e "-Elemento \"$temp\" encontrado.\n"
     fi

done
echo -e "Se encontro/aron $coincidencias coincidencia/s.\n"
echo "Busqueda finalizada."
finish_time=$(date +%s)
echo -e "\nTiempo de ejecucion: $((finish_time - start_time)) segundos."