#(6 punti) Si scriva uno script della shell del_files.sh che prenda come argomento
# sulla linea di comando una stringa ed un percorso, controlli che quest’ultimo
# corrisponda ad una directory e attraversi ricorsivamente il file system a partire
# da essa, cancellando tutti i file incontrati che abbiano come estensione la stringa
# fornita come primo argomento. Durante la cancellazione deve stampare a video il
# percorso dei file cancellati e, alla fine, deve stampare il numero totale di file
# rimossi.

# Esempio:
# ./del_files.sh bak .
# ./a.bak
# ./b/c.bak

# Numero di file cancellati: 2

str=txt                                     # input stringa (txt)
path=/home/gero/Desktop/scripts             # input percorso (/home/gero/Desktop/scripts)
num_deleted=0

if test -d $path                            # controllo che path sia una directory
then                                        # path e' una direcotry
    files=$(find $path -name "*.$str")
    
    for f in $files
    do
        if test -f $f
        then
            echo deleting:$f
            rm -f $f
            num_deleted=$[$num_deleted+1]
        fi
    done
    echo deleted files: $num_deleted
else
    echo $path is not a directory
fi                                          # path non e' un percorso

exit 0