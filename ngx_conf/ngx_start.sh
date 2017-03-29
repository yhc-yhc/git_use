
echo 'stop nginx container'
docker stop nginx > /dev/null 2>&1
echo 'remove nginx container'
docker rm nginx > /dev/null 2>&1
echo 'start nginx container'

runcontainer(){
	command="docker run -d --restart=always --privileged=true"
	command="${command} -v /etc/localtime:/etc/localtime"
	confirm(){
		echo 'confirm'
		read -p 'plase write the image name you want to run:' image
		name=$image
		command="${command} ${v_str} ${link_str} ${port_str} --name $name ${image}"
	}
	fomat_params(){
		name='';
		image='';
		p=();
		v=();
		l=()
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
		port_str=""
		for port in ${p[@]}
		do
			port_str="${port_str} -p ${port}:${port}"
		done

		v_str=""
		for vl in ${v[@]}
		do
			v_str="${v_str} -v ${vl}"
		done

		link_str=""
		for cl in ${l[@]}
		do
			link_str="${link_str} --link ${cl}"
		done
		command="${command} ${v_str} ${link_str} ${port_str} --name $name ${image}"
	}

	if [ $# = 0 ]
	then
		echo no params , confirm?
		# confirm
	else
		echo fomat_params
		fomat_params $@
	fi

	echo "${command}"

	docker stop ${name}
	docker rm ${name}
	command
}
runcontainer p=80 v=~/logs/nginx:/var/log/nginx image=nginx v=`pwd`/local:/www v=~/conf/ngx_conf:/etc/nginx/conf.d l=localhost:demo
# echo docker run -v /etc/localtime:/etc/localtime -v ~/logs/nginx:/var/log/nginx -v `pwd`/local:/www -v ~/conf/ngx_conf:/etc/nginx/conf.d -p 80:80 -d --name nginx --restart=always --privileged=true nginx