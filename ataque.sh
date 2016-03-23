
<<comment
Ataque de cumpleaños

comment



textoHash=$(echo -n "Your-String-Here" | sha1sum) # crea el hash del texto
echo "\nvalor hash"
echo $textoHash 

echo "\nvalor binario"
binario=$(echo $textoHash | perl -lpe '$_=unpack"B*"') # pasa a binario el hash creado
echo $binario

echo "\ncantidad de bits"
#prueba="12345678901234567890"
echo ${#binario} # contador de bits del binario
echo $numero