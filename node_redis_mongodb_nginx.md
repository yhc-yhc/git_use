
### redis use
	docker run -d --name redis -p 6379:6379 redis

### use mongodb
	docker run -d -p 27017:27017 -v ~/db:/data/db --name mongodb tutum/mongodb

### express project

	cd ~/work
	express demo
	cd demo
	npm install
	docker run --link redis:redis --link mongodb:mongodb -v `pwd`:/src -v /etc/localtime:/etc/localtime -w /src -d -p 3000:3000  --name demo --privileged=true node:6.9 npm start



### build nginx config
	cd ~
	md conf
	cd conf
	md ngx_conf
	cd ngx_conf

	vi 80.conf
#### nginx 配置中的 127.0.0.1 最好都改成 localhost, localhost不经过网卡，而且当本机地址受限时配置成 127.0.0.1 会访问不到

demo: ngx_conf/*.conf


### build nginx start shell

demo: ngx_conf/ngx_start.sh

	git clone https://github.com/yhc-yhc/git_use.git && cd git_use && git pull && ./ngx_run.sh


### use jenkins 
	docker run --name jenkins -d -p 8080:8080 -v /var/jenkins_home jenkins
	./run_box.sh image=jenkins p=8080 v=/var/jenkins_home
	