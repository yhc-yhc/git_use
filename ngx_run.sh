
if [ -d git_use ] then
	cd git_use;
	git pull origin master;
	cd ../
else
	git clone https://github.com/yhc-yhc/git_use.git

cp -r git_use/ngx_conf conf/
cp git_use/ngx_conf/ngx_start.sh ./
./ngx_start.sh