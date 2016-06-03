# Busca la coincidencia de los elementos de un vector
# con los elementos de otro vector con busqueda binaria.




#!/bin/bash
imprimirNros()
{
  
  echo ${quicksort_ret[*]}

}

# quicksorts positional arguments
# return is in array quicksort_ret

#Quicksort iterativo:

quicksortIterativo() {
   (($#==0)) && return 0
   local stack=( 0 $(($#-1)) ) beg end i pivot smaller larger
   quicksort_ret=("$@")
   while ((${#stack[@]})); do
      beg=${stack[0]}
      end=${stack[1]}
      stack=( "${stack[@]:2}" )
      smaller=() larger=()
      pivot=${quicksort_ret[beg]}
      for ((i=beg+1;i<=end;++i)); do
         if [[ ${quicksort_ret[i]} -lt $pivot ]]; then
            smaller+=( "${quicksort_ret[i]}" )
         else
            larger+=( "${quicksort_ret[i]}" )
         fi
      done
	  valor=2
      quicksort_ret=( "${quicksort_ret[@]:0:beg}" "${smaller[@]}" "$pivot" "${larger[@]}" "${quicksort_ret[@]:end+1}" )
      if ((${#smaller[@]} >= $valor)); then stack+=( "$beg" "$((beg+${#smaller[@]}-1))" ); fi
      if ((${#larger[@]} >= $valor)); then stack+=( "$((end-${#larger[@]}+1))" "$end" ); fi
   done
}


#Quicksort recursivo:
quicksort() {
   local pivot i smaller=() larger=()
   quicksort_ret=()
   (($#==0)) && return 0
   pivot=$1
   shift
   for i; do
      if [[ $i -lt $pivot ]]; then
         smaller+=( "$i" )
      else
         larger+=( "$i" )
      fi
   done
   quicksort "${smaller[@]}"
   smaller=( "${qsort_ret[@]}" )
   quicksort "${larger[@]}"
   larger=( "${qsort_ret[@]}" )
   quicksort_ret+=( "${smaller[@]}" "$pivot" "${larger[@]}" )
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
		
		if [ $MidElement -eq $temp ]
        then
            status=0
            searches=$i
            return
        elif [ $temp -lt $MidElement ]
        then
            HeighIndex=$(($MidIndex-1))
        else
            LowIndex=$(($MidIndex+1))
        fi

        let i++

    done
}

#####################################################################
#                      Inicia el script                             #
#####################################################################

clear

start_time=$(date +%s)
echo -e "\nVector 1 :\n "
declare -a ARRAY
i=0
while read linea1 
do
		i=$(($i+1))
		ARRAY[i]=${linea1}
		

	    
done < vector1.txt
let i++
ARRAY[i]=${linea1}    
echo "${ARRAY[@]}"
count=${#ARRAY[@]}

echo -e "\nVector 1 ordenado con quicksort:\n "
quicksortIterativo "${ARRAY[@]}"
imprimirNros
ARRAY1=("${quicksort_ret[@]}")


echo -e "\nVector 2 : \n"		
i=0
while read linea2 
do
		i=$(($i+1))
		ARRAY[i]=${linea2}
		


done < vector2.txt
let i++
ARRAY[i]=${linea2}
echo "${ARRAY[@]}"
count=${#ARRAY[@]}

echo -e "\nVector 2 ordenado con quicksort:\n "
quicksortIterativo "${ARRAY[@]}"
imprimirNros
ARRAY2=("${quicksort_ret[@]}")




#Buscando elementos

cont=${#ARRAY1[@]}
coincidencias=0
echo -e "\n Iniciando busqueda...\n"

for((inicio=0;inicio<cont;inicio++))

do
     
     temp=${ARRAY1[inicio]}
	          
	 binarysearch

     if [ $status -eq 0 ]
     then
	     let coincidencias++
		 echo -e "\n Elemento \"$temp\" encontrado.\n"
     fi

done
echo -e " Se encontro/aron $coincidencias coincidencia/s.\n"
echo " Busqueda finalizada."
finish_time=$(date +%s)
echo -e "\nTiempo de ejecucion: $((finish_time - start_time)) segundos."