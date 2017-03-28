
cd ~/work
echo `pwd`

if [ -d git_use ] then
	echo 'update ...'
	cd git_use;
	git pull origin master;
	cd ../;
else 
	echo 'clone ...';
	# git clone https://github.com/yhc-yhc/git_use.git;
fi

cp -r git_use/ngx_conf conf/
cp git_use/ngx_conf/ngx_start.sh ./
./ngx_start.sh