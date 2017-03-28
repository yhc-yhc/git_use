
cd ~/work
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

rm -rf conf
md conf
cp -r git_use/ngx_conf conf/
mv conf/ngx_conf/ngx_start.sh ./
./ngx_start.sh