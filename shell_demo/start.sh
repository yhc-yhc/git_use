echo_tip workdir `pwd` "env: ${env}"
if [ 'product' = "${env}" ] 
then
	echo_primary "his is ${env}, git original url will set 172.16.60.9"
	if [ -e db_model/.git ]
	then
		echo_info 'submodule db_model exists'
		cd db_model
		git pull origin master
		cd ../ 
		echo_success 'success update the db_model submodule'
	else
		echo_info 'submodule db_model not init, will replace to the product url'
		rm -rf db_model
		rm -f .gitmodules
		git rm db_model
		git submodule add git@211.95.27.34:josh/db_model.git
		echo_success 'success re-set the product db_model submodule'
	fi

	echo_success 'clear no use docker images, please wait a moment ...........'
	docker images -a | xargs docker rmi > /dev/null 2>&1

	docker stop cmr | xargs docker rm
	docker run -d --name cmr --restart=always -w /src -v /etc/localtime:/etc/localtime -v ~/logs:/root/logs -v `pwd`:/src --privileged=true node:6.9 /bin/sh -c "./shell/init.sh ${env}; npm run hk_cmr"
	
	docker stop ma | xargs docker rm
	docker run -d --name ma --restart=always -w /src -v /etc/localtime:/etc/localtime -v ~/logs:/root/logs -v `pwd`:/src --privileged=true node:6.9 /bin/sh -c "./shell/init.sh ${env}; npm run hk_ma"
	
	docker stop sap | xargs docker rm
	docker run -d --name sap --restart=always -w /src -v /etc/localtime:/etc/localtime -v ~/logs:/root/logs -v `pwd`:/src --privileged=true node:6.9 /bin/sh -c "./shell/init.sh ${env}; npm run hk_sap"
	
	# ACTION=true npm run {command} #可以马上生成昨天的报表，用于故障补发
	# docker run -it --rm -w /src -v /etc/localtime:/etc/localtime -v ~/logs:/root/logs -v `pwd`:/src --privileged=true node:6.9 /bin/bash
elif [ 'test' = "${env}" ]
then
	echo_info "his is ${env}, git original url will set 172.16.60.9"
	if [ -e db_model/.git ] 
	then
		echo_info 'submodule db_model exists'
		cd db_model
		git pull origin master
		cd ../
		echo_success 'success update the db_model submodule'
	else
		echo_info 'submodule db_model not init'
		git submodule update --init --recursive
		echo_success 'success init the db_model submodule'
	fi

	echo_info 'clear no use docker images, please wait a moment ...........'
	docker images -a | xargs docker rmi > /dev/null 2>&1

	docker stop cmr | xargs docker rm
	docker run -d --name cmr --restart=always -w /src -v /etc/localtime:/etc/localtime -v ~/logs:/root/logs -v `pwd`:/src --privileged=true node:6.9 /bin/sh -c "./shell/init.sh ${env}; npm run hk_cmr"
	
	docker stop ma | xargs docker rm
	docker run -d --name ma --restart=always -w /src -v /etc/localtime:/etc/localtime -v ~/logs:/root/logs -v `pwd`:/src --privileged=true node:6.9 /bin/sh -c "./shell/init.sh ${env}; npm run hk_ma"
	
	docker stop sap | xargs docker rm
	docker run -d --name sap --restart=always -w /src -v /etc/localtime:/etc/localtime -v ~/logs:/root/logs -v `pwd`:/src --privileged=true node:6.9 /bin/sh -c "./shell/init.sh ${env}; npm run hk_sap"
	
	# ACTION=true npm run {command} #可以马上生成昨天的报表，用于故障补发
	# docker run -it --rm -w /src -v /etc/localtime:/etc/localtime -v ~/logs:/root/logs -v `pwd`:/src --privileged=true node:6.9 /bin/bash
else
	echo_primary "this is ${env}, git original url will set 172.16.60.9"
	if [ -e db_model/.git ] 
	then
		echo_info 'submodule db_model exists'
		cd db_model
		git pull origin master
		cd ../
		echo_success 'success update the db_model submodule'
	else
		echo_info 'submodule db_model not init'
		git submodule update --init --recursive
		echo_success 'success init the db_model submodule'
	fi
	. shell/init.sh ${env}
fi


