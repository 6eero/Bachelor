# imposta i separatori interni alla stringa vuota in modo da
# preservare i newline nelle command substitution

lista_file=$(find $1)           # lista_file conterra ‘ tante righe quante sono quelle prodotte dal find
l=$(echo $lista_file | wc -l)   # calcola il numero di elementi (righe) di lista_file
i=1
 
while test $i -le $l;
do
    f=$(echo $lista_file | cut -d/ -f1)
    echo -n $f $(-->)

    if test -f $(find $1 | cut -d/ -f2)    
    then
        echo -r file
    fi

    if test -d $(find $1 | cut -d/ -f2)
    then
        echo -r dir
    fi  

    i=$[$i+1]
done