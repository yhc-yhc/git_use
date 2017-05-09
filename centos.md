#centos7 use

	修改 root用户密码
	1,开机按 e
	2,修改 linux16行的 ro 为 rw init=sysroot/bin/sh
	3,contrl + x  ; 以单用户模式登录
	4,chroot /sysroot
	5,passwd root
	6,touch /.autorelabel
	7,exit
	8,init 6

###user manage
	1, useradd username    添加用户
	2, passwd username		设置用户密码
	3, userdel -rf username  	删除用户
	4 ls -l /home	查看用户
	sudoers
	whereis sudoers
	ls -l /etc/sudoers
	chmod -v u+w /etc/sudoers
	vi /etc/sudoers
	chmod -v u-w /etc/sudoers


	sudo  passwd -d username
	sudo -u username passwd

### install pg
	yum install postgresql-server
	initdb ~/pgsql -E utf8
	sudo service postgresql start

### centos7 install Xwindows
	yum update
	yum groupinstall "X Window System"
	yum install gnome-classic-session gnome-terminal nautilus-open-terminal control-center liberation-mono-fonts
	

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
	
	tar -jcpf $tar_name $project_name
	tar -jxpf ../$tar_name


### centos7 zip 
	yum install zip unzip

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

### docker postgresql

	docker run --name pg -v /etc/localtime:/etc/localtime --privileged=true -e POSTGRES_PASSWORD=josh -v ~/pgdb:/var/lib/postgresql/data -d -p 2345:5432 postgres

#### 修改postgresql 密码
	docker exec -it pg /bin/bash
	su postgres
	psql -U postgres
	ALTER USER postgres WITH PASSWORD 'josh';
	\q
	exit
	exit

	docker run \
	-p 8080:8080 \
	-d --name jenkins  jenkins

### docker mongo

	docker run -d --name temp -v ~/mongodata/pictureAir:/data/db --privileged=true mongo:3.2

	docker exec -it temp /bin/bash

	/usr/bin/mongorestore -d pictureAir /data/db 

	=============================

	export node1="192.168.8.114"
	export node2="192.168.8.115"
	export node3="192.168.8.116"

	docker run \
	--privileged=true -v /etc/localtime:/etc/localtime \
	-v ~/mongodata/pictureAir:/data/db \
	-p 27017:27017 \
	--hostname="mongo_116" \
	--add-host mongo_114:${node1} \
	--add-host mongo_115:${node2} \
	--add-host mongo_116:${node3} \
	--name mongo -d mongo:3.2 \
	--storageEngine wiredTiger \
	--smallfiles \
	--replSet "rs0"

	docker exec -it mongo /bin/bash
	mongo
	use admin



	docker run \
	--privileged=true -v /etc/localtime:/etc/localtime \
	-v ~/mongodata/slaver:/data/db \
	-p 27017:27017 \
	--hostname="mongo_115" \
	--add-host mongo_114:${node1} \
	--add-host mongo_115:${node2} \
	--add-host mongo_116:${node3} \
	--name mongo -d mongo:3.2 \
	--storageEngine wiredTiger \
	--smallfiles \
	--replSet "rs0"

	docker run \
	--privileged=true -v /etc/localtime:/etc/localtime \
	-v ~/mongodata/arbiter:/data/db \
	-p 27017:27017 \
	--hostname="mongo_114" \
	--add-host mongo_114:${node1} \
	--add-host mongo_115:${node2} \
	--add-host mongo_116:${node3} \
	--name mongo -d mongo:3.2 \
	--storageEngine wiredTiger \
	--smallfiles \
	--replSet "rs0"

	
	
{
	"_id" : "rs0",
	"version" : 1,
	"protocolVersion" : NumberLong(1),
	"members" : [
		{
			"_id" : 0,
			"host" : "mongo_116:27017",
			"arbiterOnly" : false,
			"buildIndexes" : true,
			"hidden" : false,
			"priority" : 2,
			"tags" : {
				
			},
			"slaveDelay" : NumberLong(0),
			"votes" : 1
		},
		{
			"_id" : 1,
			"host" : "mongo_115:27017",
			"arbiterOnly" : false,
			"buildIndexes" : true,
			"hidden" : false,
			"priority" : 1,
			"tags" : {
				
			},
			"slaveDelay" : NumberLong(0),
			"votes" : 1
		},
		{
			"_id" : 2,
			"host" : "mongo_114:27017",
			"arbiterOnly" : true,
			"buildIndexes" : true,
			"hidden" : false,
			"priority" : 1,
			"tags" : {
				
			},
			"slaveDelay" : NumberLong(0),
			"votes" : 1
		}
	],
	"settings" : {
		"chainingAllowed" : true,
		"heartbeatIntervalMillis" : 2000,
		"heartbeatTimeoutSecs" : 10,
		"electionTimeoutMillis" : 10000,
		"getLastErrorModes" : {
			
		},
		"getLastErrorDefaults" : {
			"w" : 1,
			"wtimeout" : 0
		},
		"replicaSetId" : ObjectId("590c022f6ee2f05df3cbd8d7")
	}
}
	

	cfg={_id:"rs1", members:[ {_id:2,host:'pw1:27017',priority:1}, {_id:1,host:'pw2:27017',priority:2}, {_id:0,host:'pwa:27017'}] };  
	rs.initiate(cfg)
	rs.conf()
	rs.status()

		rs.status()                                { replSetGetStatus : 1 } checks repl set status
        rs.initiate()                              { replSetInitiate : null } initiates set with default settings
        rs.initiate(cfg)                           { replSetInitiate : cfg } initiates set with configuration cfg
        rs.conf()                                  get the current configuration object from local.system.replset
        rs.reconfig(cfg)                           updates the configuration of a running replica set with cfg (disconnects)
        rs.add(hostportstr)                        add a new member to the set with default attributes (disconnects)
        rs.add(membercfgobj)                       add a new member to the set with extra attributes (disconnects)
        rs.addArb(hostportstr)                     add a new member which is arbiterOnly:true (disconnects)
        rs.stepDown([stepdownSecs, catchUpSecs])   step down as primary (disconnects)
        rs.syncFrom(hostportstr)                   make a secondary sync from the given member
        rs.freeze(secs)                            make a node ineligible to become primary for the time specified
        rs.remove(hostportstr)                     remove a host from the replica set (disconnects)
        rs.slaveOk()                               allow queries on secondary nodes

        rs.printReplicationInfo()                  check oplog size and time range
        rs.printSlaveReplicationInfo()             check replica set members and replication lag
        db.isMaster()                              check who is primary

        reconfiguration helpers disconnect from the database so the shell will display
        an error, even if the command succeeds.


### docker 维护
	docker ps -a | grep "Exited" | awk '{print $1 }'|xargs docker stop
	docker ps -a | grep "Exited" | awk '{print $1 }'|xargs docker rm
	docker images -a | grep none | awk '{print $3 }'|xargs docker rmi

	#stop all container
	docker ps | grep "Up" | awk '{print $1 }' | xargs docker stop || docker ps -a | grep Exited | awk '{print $1 }' | xargs docker rm

###docker run --help

	Usage:	docker run [OPTIONS] IMAGE [COMMAND] [ARG...]

	Run a command in a new container

	  -a, --attach=[]                 Attach to STDIN, STDOUT or STDERR
	  --add-host=[]                   Add a custom host-to-IP mapping (host:ip)
	  --blkio-weight=0                Block IO (relative weight), between 10 and 1000
	  --cpu-shares=0                  CPU shares (relative weight)
	  --cap-add=[]                    Add Linux capabilities
	  --cap-drop=[]                   Drop Linux capabilities
	  --cgroup-parent=                Optional parent cgroup for the container
	  --cidfile=                      Write the container ID to the file
	  --cpu-period=0                  Limit CPU CFS (Completely Fair Scheduler) period
	  --cpu-quota=0                   Limit CPU CFS (Completely Fair Scheduler) quota
	  --cpuset-cpus=                  CPUs in which to allow execution (0-3, 0,1)
	  --cpuset-mems=                  MEMs in which to allow execution (0-3, 0,1)
	  -d, --detach=false              Run container in background and print container ID
	  --device=[]                     Add a host device to the container
	  --disable-content-trust=true    Skip image verification
	  --dns=[]                        Set custom DNS servers
	  --dns-opt=[]                    Set DNS options
	  --dns-search=[]                 Set custom DNS search domains
	  -e, --env=[]                    Set environment variables
	  --entrypoint=                   Overwrite the default ENTRYPOINT of the image
	  --env-file=[]                   Read in a file of environment variables
	  --expose=[]                     Expose a port or a range of ports
	  --group-add=[]                  Add additional groups to join
	  -h, --hostname=                 Container host name
	  --help=false                    Print usage
	  -i, --interactive=false         Keep STDIN open even if not attached
	  --ipc=                          IPC namespace to use
	  --kernel-memory=                Kernel memory limit
	  -l, --label=[]                  Set meta data on a container
	  --label-file=[]                 Read in a line delimited file of labels
	  --link=[]                       Add link to another container
	  --log-driver=                   Logging driver for container
	  --log-opt=[]                    Log driver options
	  --lxc-conf=[]                   Add custom lxc options
	  -m, --memory=                   Memory limit
	  --mac-address=                  Container MAC address (e.g. 92:d0:c6:0a:29:33)
	  --memory-reservation=           Memory soft limit
	  --memory-swap=                  Total memory (memory + swap), '-1' to disable swap
	  --memory-swappiness=-1          Tuning container memory swappiness (0 to 100)
	  --name=                         Assign a name to the container
	  --net=default                   Set the Network for the container
	  --oom-kill-disable=false        Disable OOM Killer
	  -P, --publish-all=false         Publish all exposed ports to random ports
	  -p, --publish=[]                Publish a container's port(s) to the host
	  --pid=                          PID namespace to use
	  --privileged=false              Give extended privileges to this container
	  --read-only=false               Mount the container's root filesystem as read only
	  --restart=no                    Restart policy to apply when a container exits
	  --rm=false                      Automatically remove the container when it exits
	  --security-opt=[]               Security Options
	  --sig-proxy=true                Proxy received signals to the process
	  --stop-signal=SIGTERM           Signal to stop a container, SIGTERM by default
	  -t, --tty=false                 Allocate a pseudo-TTY
	  -u, --user=                     Username or UID (format: <name|uid>[:<group|gid>])
	  --ulimit=[]                     Ulimit options
	  --uts=                          UTS namespace to use
	  -v, --volume=[]                 Bind mount a volume
	  --volume-driver=                Optional volume driver for the container
	  --volumes-from=[]               Mount volumes from the specified container(s)

### use docker-compose

	curl -L https://github.com/docker/compose/releases/download/1.4.2/docker-compose-Linux-x86_64 > /usr/bin/docker-compose
	chmod  +x /usr/bin/docker-compose

打开和关闭防火墙
	systemctl stop/start firewalld.service
	firewall-cmd --zone=public --add-port=8080/tcp --permanent
	firewall-cmd --zone=public --add-service=http --permanent
	firewall-cmd --reload
	firewall-cmd --list-all



