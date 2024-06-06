path=/home/gero/Desktop/scripts/file.txt
lines=$(cat $path)
pointer=1

for f in $lines
do
    add1=$(cat $path | sed -z 's/\n/,/g' | cut -d, -f$pointer)
    pointer=$[$pointer+1]
    add2=$(cat $path | sed -z 's/\n/,/g' | cut -d, -f$pointer)
    pointer=$[$pointer+1]
    
    echo $[$add1+$add2]
done
exit 0