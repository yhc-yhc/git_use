
echo 'stop nginx container'
docker stop nginx > /dev/null 2>&1
echo 'remove nginx container'
docker rm nginx > /dev/null 2>&1
echo 'start nginx container'
docker run --link demo:localhost -v /etc/localtime:/etc/localtime -v ~/logs/nginx:/var/log/nginx -v `pwd`/frontend:/www -v ~/conf/ngx_conf:/etc/nginx/conf.d -p 80:80 -d --name nginx --restart=always --privileged=true nginx