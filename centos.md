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

打开和关闭防火墙
	systemctl stop/start firewalld.service
	firewall-cmd --zone=public --add-port=8080/tcp --permanent
	firewall-cmd --zone=public --add-service=http --permanent
	firewall-cmd --reload
	firewall-cmd --list-all



