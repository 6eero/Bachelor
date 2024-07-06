# Si scriva uno script della shell check_file_tree_size.sh che prenda
# come argomento sulla linea di comando un percorso, controlli che
# corrisponda ad una directory e attraversi ricorsivamente il file
# system a partire da essa, stampando alla fine il numero dei soli
# file incontrati e del totale di byte occupati da essi.

# Esempio:
# ./check_file_tree_size.sh .
# Numero di file: 7
# Numero di byte: 52493

path=/home/gero/Desktop/scripts/dir
num_files=0
num_bytes=0

if test ! -d $path
then
    echo $path is not a directory!
else
    file=$(find $path -print 2>/dev/null)

    for f in $file
    do
        if test -f $f
        then
            num_files=$[$num_files+1]
            dim=$(cat $f | wc -c)
            num_bytes=$[$num_bytes+$dim]
        fi
    done
fi

echo Number of files: $num_files
echo Number of bytes: $num_bytes

exit 0