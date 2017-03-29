a="one,two,three,four"
echo $IFS
OLD_IFS="$IFS"
IFS="," 
arr=($a) 
IFS="$OLD_IFS"
for s in ${arr[@]} 
do 
    echo "$s" 
done