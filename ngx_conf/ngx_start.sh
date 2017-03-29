
echo 'stop nginx container'
docker stop nginx > /dev/null 2>&1
echo 'remove nginx container'
docker rm nginx > /dev/null 2>&1
echo 'start nginx container'
./run_box.sh image=nginx p=80 l=localhost:demo v=~/logs/nginx:/var/log/nginx v=`pwd`/local:/www v=~/conf/ngx_conf:/etc/nginx/conf.d