#centos7 use

###centos7 install nodejs

	yum install epel-release
	yum install nodejs 

### vim command
	
打开和关闭防火墙
	systemctl stop/start firewalld.service
	firewall-cmd --zone=public --add-port=8080/tcp --permanent
	firewall-cmd --zone=public --add-service=http --permanent
	firewall-cmd --reload
	firewall-cmd --list-all