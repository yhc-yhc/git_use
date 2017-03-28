
#start nginx in docker 	

### build nginx config
	cd ~/work
	md config
	cd config
	md config_ngx
	cd config_ngx
	touch server

	vi server

### express project

	cd ~/work
	express demo
	cd demo
	npm install
	docker run -d -p 3000:3000 --name demo -v `pwd`:/src -w /src --privileged=true node:6.9 npm start

### build nginx start shell
	cd ~/work
	touch nginx.sh
	chmod +x nginx.sh

	echo 'stop nginx container'
	docker stop nginx > /dev/null 2>&1
	echo 'remove nginx container'
	docker rm nginx > /dev/null 2>&1
	echo 'start nginx container'
	docker run --link demo:localhost -v /etc/localtime:/etc/localtime -v ~/logs/nginx:/var/log/nginx -v `pwd`/frontend:/www -v `pwd`/config/ngx_conf:/etc/nginx/conf.d -p 80:80 -d --name nginx --restart=always --privileged=true nginx