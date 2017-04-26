

i=0
date1=`date +%s`
while [[ $i -lt 5 ]]; do
	i=`expr $i + 1`;
	echo $i copy finished ;
	sleep 0.2
done
date2=`date +%s`
let time=($date2 - $date1)
echo $date1 $date2 $time
