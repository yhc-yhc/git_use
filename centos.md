#centos7 use

###centos7 install nodejs

	yum install epel-release 设置安装源
	yum install nodejs

centos install zsh & oh-my-zsh
	yum install zsh
	curl方式
		curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
		
	wget方式
		wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh
	
	zsh alias help
		cat ~/.oh-my-zsh/plugins/git/git.plugin.zsh >> zsh_help.txt
### vim command
	
打开和关闭防火墙
	systemctl stop/start firewalld.service
	firewall-cmd --zone=public --add-port=8080/tcp --permanent
	firewall-cmd --zone=public --add-service=http --permanent
	firewall-cmd --reload
	firewall-cmd --list-all