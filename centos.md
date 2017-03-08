#centos7 use

###centos7 install nodejs

	yum install epel-release
	yum install nodejs 


#webhook tes
###在centos7上安装Jenkins
####安装
添加yum repos，然后安装

	sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
	sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
	sudo yum install jenkins

如果没有java的话要安装java
	sudo yum install java

启动和停止
	sudo service jenkins start/stop/restart
	sudo chkconfig jenkins on

jenkins的默认设置
Jenkins会随系统启动而启动。详情参照/etc/init.d/jenkins
Jenkins会创建一个用户叫做jenkins, 如果你修改了user，则要修修改所属者：/var/log/jenkins,/var/lib/jenkins,/var/cache/jenkins
如果遇到问题，查看日志/var/log/jenkins/jenkins.log
配置文件/etc/sysconfig/jenkins
默认启用8080

打开和关闭防火墙
	systemctl stop/start firewalld.service
	firewall-cmd --zone=public --add-port=8080/tcp --permanent
	firewall-cmd --zone=public --add-service=http --permanent
	firewall-cmd --reload
	firewall-cmd --list-all

关于centos上的java

Jenkins不支持在centos的默认的jdk上工作。如果如下所示，则需要remove：

	java -version
	java version "1.5.0"
	gij (GNU libgcj) version 4.4.6 20110731 (Red Hat 4.4.6-3)

为了正确使用Jenkins：
	yum remove java

然后可以安装openjdk
	yum install java-1.7.0-openjdk

正确如下：
	java -version
	java version "1.7.0_79"
	OpenJDK Runtime Environment (rhel-2.5.5.1.el6_6-x86_64 u79-b14)
	OpenJDK 64-Bit Server VM (build 24.79-b02, mixed mode)
配置端口
修改/etc/sysconfig/jenkins:

	JENKINS_PORT="8080"

配置java路径
直接启动：
	sudo service jenkins start

但是发现启动失败，于是需要配置java位置：

	vi /etc/init.d/jenkins
在启动加入本机的java：
	vim /etc/init.d/jenkins 

# Set up environment accordingly to the configuration settings
[ -n "$JENKINS_HOME" ] || { echo "JENKINS_HOME not configured in $JENKINS_CONFIG";
        if [ "$1" = "stop" ]; then exit 0;
        else exit 6; fi; }
[ -d "$JENKINS_HOME" ] || { echo "JENKINS_HOME directory does not exist: $JENKINS_HOME";
        if [ "$1" = "stop" ]; then exit 0;
        else exit 1; fi; }

# Search usable Java as /usr/bin/java might not point to minimal version required by Jenkins.
# see http://www.nabble.com/guinea-pigs-wanted-----Hudson-RPM-for-RedHat-Linux-td25673707.html
candidates="
/etc/alternatives/java
/usr/lib/jvm/java-1.8.0/bin/java
/usr/lib/jvm/jre-1.8.0/bin/java
/usr/lib/jvm/java-1.7.0/bin/java
/usr/lib/jvm/jre-1.7.0/bin/java
/usr/bin/java
/usr/java/jdk1.7.0_80/bin/java
"
上述最后一行是我添加的。

重启，可以正常运行了。

启动
浏览器输入ip和端口访问，第一个页面是正在启动，启动结束后会让输入一串密码，然后进入插件安装界面，选择默认，这时候会报错：
An error occurred during installation: Forbidden

解决办法：
I "fixed it" by restarting Jenkins http://localhost:8080/restart。即重启就可以继续了。