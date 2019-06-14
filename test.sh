
NAMES=$( ls /uafs/textmining/big | shuf -n 2 )

for n in $NAMES
do
D=$( find /uafs/textmining/big -name $n)
echo $D
done
