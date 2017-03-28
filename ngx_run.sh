
cd ~
if [ -d work ]
then
	echo 'work dir exists'
else
	mkdir work
fi

cd work
echo `pwd`

if [ -d git_use ] 
then
	echo 'update ...'
	cd git_use;
	git pull origin master;
	cd ../;
else 
	echo 'clone ...';
	git clone https://github.com/yhc-yhc/git_use.git;
fi


if [ -d ~/conf ]
then
	echo 'conf dir exists'
else
	cd ~
	mkdir conf
	cd -
fi

cp -r git_use/ngx_conf ~/conf/
mv ~/conf/ngx_conf/ngx_start.sh ./
echo nginx config file: `ls ~/conf/ngx_conf`
./ngx_start.sh