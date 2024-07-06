var=0

if [ ! -d /home/gero/Desktop/scripts/dir ]; 
then
    mkdir -p /home/gero/Desktop/scripts/dir;
fi

cd /home/gero/Desktop/scripts/dir

for ((x=0; x<5; x++))
do
    touch testo$var.txt
    var=$((var+1))
    touch file$var.pdf
    var=$((var+1))
    touch photo$var.png
done

if [ ! -d /home/gero/Desktop/scripts/dir/dir2 ]; 
then
    mkdir -p /home/gero/Desktop/scripts/dir/dir2;
fi

cd /home/gero/Desktop/scripts/dir/dir2

for ((x=0; x<3; x++))
do
    touch text$var.txt
    var=$((var+1))
    touch file$var.java
    var=$((var+1))
    touch photo$var.jpg
done

if [ ! -d /home/gero/Desktop/scripts/dir/dir3 ]; 
then
    mkdir -p /home/gero/Desktop/scripts/dir/dir3;
fi

cd /home/gero/Desktop/scripts/dir/dir3

for ((x=0; x<2; x++))
do
    touch text$var.txt
    var=$((var+1))
    touch image$var.jpg
done

if [ ! -d /home/gero/Desktop/scripts/dir/dir2/dir4 ]; 
then
    mkdir -p /home/gero/Desktop/scripts/dir/dir2/dir4;
fi

cd /home/gero/Desktop/scripts/dir/dir2/dir4

for ((x=0; x<2; x++))
do
    touch text$var.txt
    var=$((var+1))
    touch code$var.py
done