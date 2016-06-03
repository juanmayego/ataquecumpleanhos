#!/bin/bash
# SCRIPT : binarysearch.sh
# USAGE  : binarysearch.sh
# PURPOSE: Searches given number in a sorted list.
#                         \\\\ ////
#                         \\ - - //
#                            @ @
#                    ---oOOo-( )-oOOo---
#
#####################################################################
#                      Define Functions Here                        #
#####################################################################

printnumbers()
{
  echo ${ARRAY[*]}
}

sortnumbers()                               # Using insertion sort
{
for((i=1;i<count;i++))
do
   Temp=${ARRAY[i]}
   j=$((i-1))
   while [ $Temp -lt ${ARRAY[j]} ]
   do
      ARRAY[j+1]=${ARRAY[j]}
      let j--
      if [ $j == -1 ]
      then
         break
      fi
done
   ARRAY[j+1]=$Temp
done
}

binarysearch()
{
    status=-1
    i=1
    array=($(echo "$@"))
    LowIndex=0
    HeighIndex=$((${#array[@]}-1))

    while [ $LowIndex -le $HeighIndex ]
    do

        MidIndex=$(($LowIndex+($HeighIndex-$LowIndex)/2))
        MidElement=${array[$MidIndex]}



      if [ $MidElement -eq $SearchedItem ]
        then
            status=0
            searches=$i
            return
        elif [ $SearchedItem -lt $MidElement ]
        then
            HeighIndex=$(($MidIndex-1))
        else
            LowIndex=$(($MidIndex+1))
        fi

        let i++

    done
}

#####################################################################
#                       Variable Declaration                       #
#####################################################################

clear

echo "Enter Array Elements : "

read -a ARRAY

count=${#ARRAY[@]}

search=y

#####################################################################
#                       Main Script Starts Here                     #
#####################################################################

# sort the loaded array, must for binary search.
# You can apply any sorting algorithm. I applied insertion sort.

sortnumbers

echo "Array Elements After Sort: "

printnumbers

while [ "$search" == "y" -o "$search" == "Y" ]
do

     echo -n "Enter Element to be searched : "
     read SearchedItem
     binarysearch "${ARRAY[@]}"

     if [ $status -eq 0 ]
     then
         echo "$SearchedItem found after $searches searches"
     else
         echo "$SearchedItem not found in the list"


    fi

     echo -n "Do you want another search (y/n): "
     read search

done















