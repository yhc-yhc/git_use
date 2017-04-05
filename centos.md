#centos7 use

###centos7 install nodejs

	yum install epel-release 设置安装源
	yum install nodejs

### centos install zsh & oh-my-zsh
	yum install zsh
	curl方式
		curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
		
	wget方式
		wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh
	
	zsh alias help
		cat ~/.oh-my-zsh/plugins/git/git.plugin.zsh >> zsh_help.txt
### centos7 install  bzip2

	yum install bzip2    # tar 使用压缩支持 .tar.bz2

	tar命令
	tar [-cxtzjvfpPN] 文件与目录 ....
	参数：
	-c ：建立一个压缩文件的参数指令(create 的意思)；
	-x ：解开一个压缩文件的参数指令！
	-t ：查看 tarfile 里面的文件！
	特别注意，在参数的下达中， c/x/t 仅能存在一个！不可同时存在！
	因为不可能同时压缩与解压缩。
	-z ：是否同时具有 gzip 的属性？亦即是否需要用 gzip 压缩？
	-j ：是否同时具有 bzip2 的属性？亦即是否需要用 bzip2 压缩？
	-v ：压缩的过程中显示文件！这个常用，但不建议用在背景执行过程！
	-f ：使用档名，请留意，在 f 之后要立即接档名喔！不要再加参数！
	　　　例如使用『 tar -zcvfP tfile sfile』就是错误的写法，要写成
	　　　『 tar -zcvPf tfile sfile』才对喔！
	-p ：使用原文件的原来属性（属性不会依据使用者而变）
	-P ：可以使用绝对路径来压缩！
	-N ：比后面接的日期(yyyy/mm/dd)还要新的才会被打包进新建的文件中！
	--exclude FILE：在压缩的过程中，不要将 FILE 打包！


### 免 sudo 使用 docker

	sudo groupadd docker 如果还没有 docker group 就添加一个：
	sudo gpasswd -a ${USER} docker  将用户加入该 group 内。然后退出并重新登录就生效啦。
	sudo service docker restart   重启 docker 服务
	newgrp - docker || pkill X  切换当前会话到新 group 或者重启 X 会话

### 升级 docker 
	docker -v   # if the version lt 1.8, cannot use daocloud
	sudo service stop docker
	sudo wget https://get.docker.com/builds/Linux/x86_64/docker-1.9.1
	mv /usr/bin/docker /usr/bin/docker_bak
	mv docker-1.9.1 /usr/bin/docker
	chmod +x /usr/bin/docker
	/etc/init.d/docker start
	service docker start
	docker -v

### docker 加速器
	curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://0c19a7ee.m.daocloud.io


### docker 维护
	docker ps -a | grep "Exited" | awk '{print $1 }'|xargs docker stop
	docker ps -a | grep "Exited" | awk '{print $1 }'|xargs docker rm
	docker images -a | grep none | awk '{print $3 }'|xargs docker rmi

	#stop all container
	docker ps | grep "Up" | awk '{print $1 }' | xargs docker stop | xargs docker rm
	
打开和关闭防火墙
	systemctl stop/start firewalld.service
	firewall-cmd --zone=public --add-port=8080/tcp --permanent
	firewall-cmd --zone=public --add-service=http --permanent
	firewall-cmd --reload
	firewall-cmd --list-all
