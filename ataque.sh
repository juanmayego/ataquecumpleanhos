
<<comment
Ataque de cumpleaños

comment



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



stringToArray() {
	str=$1
	len=${#str} # halla la longitud de la cadena

	for ((i=0; i<len; i++));
	do
	   array[i]=${str:i:1} # saca cada caracter y coloca en una posicon del vector
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


echo "Lee el archivo palabrasOrig.txt"
true > origOrd.txt
while read line1
do
	palabraOrig=$line1 # extrae la palabra original
	palabraOrigHash=$(echo -n $palabraOrig | sha1sum) # crea el hash de la palabra
	stringToArray "$palabraOrigHash" # copia el string a un array para poder ordenar
	quicksort "${array[@]}" # ordena el array
	palabra=""
	arrayToString "${quicksort_ret[@]}" # crea un string de vuelta
	#echo '\n' > origOrd.txt
	echo $palabra >> origOrd.txt
	#echo  > origOrd.txt
	
done < palabrasOrig.txt
echo "Crea los hashes de cada palabra"
echo "Ordena los hashes"
echo "Escribe los hashes ordenados en el archivo origOrd.txt"

echo "Lee el archivo palabrasModif.txt"
true > modifOrd.txt
while read line2
do
	palabraModif=$line2 # extrae la palabra original
	palabraModifHash=$(echo -n $palabraModif | sha1sum) # crea el hash de la palabra
	stringToArray "$palabraModifHash" # copia el string a un array para poder ordenar
	quicksort "${array[@]}" # ordena el array
	palabra=""
	arrayToString "${quicksort_ret[@]}" # crea un string de vuelta
	#echo '\n' > origOrd.txt
	echo $palabra >> modifOrd.txt
	#echo  > origOrd.txt
	
done < palabrasModif.txt
echo "Crea los hashes de cada palabra"
echo "Ordena los hashes"
echo "Escribe los hashes ordenados en el archivo modifOrd.txt"


