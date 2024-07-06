# si scriva uno script somma.sh della shell che calcoli e stampi a video
# la somma di tutti gli User ID contenuti nel file /etc/passwd (si
# ricorda che le linee del file sono organizzate in campi separati dai
# due punti ’:’ e che il campo relativo allo User ID è il terzo).
# Ogni linea del suddetto file è simile alla seguente (lo User ID è il
# terzo valore, ovvero, 124, nel caso della linea riportata):

# lightdm:x:124:116:Light Display Manager:/var/lib/lightdm:/bin/false

files=$(cat /etc/passwd | cut -d: -f3)
sum=0

for f in $files
do
    sum=$[$sum+$f]
done

echo $sum
exit 0