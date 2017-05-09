
cd ./synctest
host=a
cd $host > /dev/null 2>&1 || { mkdir $host; cd $host; }
i=0
date1=`date +%s`
while [[ $i -lt 500 ]]; do
	i=`expr $i + 1`;
	# echo $i;
	{ cp ../../x128.JPG ${host}${i}_x128.jpg; }&
	{ cp ../../x512.JPG ${host}${i}_x512.jpg; }&
	{ cp ../../x1024.JPG ${host}${i}_x1024.jpg; }&
	{ cp ../../pre.JPG ${host}${i}_pre.jpg; }&
	wait;
	echo $i copy finished ;
	# sleep 1;
done

date2=`date +%s`
let time=($date2 - $date1)
echo $date1 $date2 $time
