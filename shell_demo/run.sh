. shell/echo_format.sh
git pull origin master
if [ $# -eq 0 ]
then
	read -p 'is this run for dev/test/product?(d/t/p): ' env
	case $env in
	    d | D)  
			echo_info 'build for dev';
			env="dev";
	    ;;
	    t | T)  
			echo_info 'build for test';
			env="test";
	    ;;
	    p | P)  
			echo_info 'build for product';
			env="product";
	    ;;
	    *)  
			echo_error 'error select, projetc will build for dev';
			env="dev";
	    ;;
	esac
else
	env=$1
fi
. shell/start.sh $*
