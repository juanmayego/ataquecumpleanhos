
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


textoHash=$(echo -n "Estimado" | sha1sum) # crea el hash del texto
echo "\nvalor hash"
echo $textoHash 

textoHashotro=$(echo -n "Querido" | sha1sum)
echo $textoHashotro
binarioOtro=$(echo $textoHashotro | perl -lpe '$_=unpack"B*"')


stringToArray "$textoHash"
quicksort "${array[@]}" # ordena el vector
echo "${quicksort_ret[@]}"
stringToArray "$textoHashotro"
quicksort "${array[@]}" # ordena el vector
echo "${quicksort_ret[@]}"



diff=$(diff <(printf "%s\n" "${arr1[@]}") <(printf "%s\n" "${arr2[@]}"))

if [[ -z "$diff" ]]; then
    echo "TRUE"
else
    echo "FALSE"
fi



echo "\nvalor binario"
binario=$(echo $textoHash | perl -lpe '$_=unpack"B*"') # pasa a binario el hash creado
#echo $binario

echo "\ncantidad de bits"
#echo ${#binario} # contador de bits del binario
#echo $numero

echo true > salida.txt
echo "texto 1" >> salida.txt
echo $binario >> salida.txt
echo "\ntexto2" >> salida.txt
echo $binarioOtro >> salida.txt
