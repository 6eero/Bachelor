# Si scriva uno script home.sh della shell che stampi a video il
# numero di sottodirectory visibili di primo livello (quindi non si
# deve scendere ricorsivamente nell’albero del filesystem) della 
# directory /home.

count=0

for f in /home/*
do
    if test -d $f
    then
        count=$[$count+1]
    fi
done

echo $count

exit 0