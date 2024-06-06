uid=$(cat /etc/passwd | cut -d: -f3)
sum=0

for f in $uid
do
    sum=$[$sum+$f]
done

echo $sum