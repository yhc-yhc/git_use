image='';
name='';
p=();
v=();
l=();
link_str="";
v_str="";
port_str="";
command="docker run -d --restart=always --privileged=true"
command="${command} -v /etc/localtime:/etc/localtime "

confirm(){
	echo 'confirm'
	read -p 'plase write the image name you want to run:' image
	name=$image
}

fomat_params(){
	for item in $@
	do
	    IFS="="
	    item=($item)
	    case ${item[0]} in
	    	name)
				name=${item[1]}
			;;
			image)
				image=${item[1]}
			;;
			p)
				len=${#p[@]}
				p[len]=${item[1]}
			;;
			v)
				len=${#v[@]}
				v[len]=${item[1]}
			;;
			l)
				len=${#l[@]}
				l[len]=${item[1]}
			;;
	    esac
	done
	
}

if [ $# = 0 ]
then
	echo "no param"
	confirm
else
	fomat_params $@
fi

if [ -z $image ]
then
	read -p 'plase write the image name you want to run:' image
fi

if [ -z $name ]
then
	name=$image
fi
echo image: $image;
echo name: $name;
echo port: ${p[@]};
echo v: ${v[@]};
echo link: ${l[@]};

for port in ${p[@]}
do
	port_str="${port_str}-p ${port}:${port} "
done


for vl in ${v[@]}
do
	v_str="${v_str}-v ${vl} "
done


for cl in ${l[@]}
do
	link_str="${link_str}--link ${cl} "
done
command="${command}${v_str}${link_str}${port_str}--name $name ${image}"

echo "${command}"

docker stop ${name}
docker rm ${name}
eval $command