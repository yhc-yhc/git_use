. ./shell/echo_format.sh
echo_info "env: $1"
if [ 'dev' = "${1}" ]
	then
	gpg --help > /dev/null 2>&1
	if [ $? -eq 0 ]
	then
		echo_primary 'gpg already install on this computer'
		echo_info 'delete old keys'
		gpg --delete-key --always-trust --batch --yes PICWORKS-HKDL-2017
		gpg --delete-key --always-trust --batch --yes PICWORKS-HKDL-Test-2017
		gpg --delete-key --always-trust --batch --yes HKDL-PicWorks-TEST
	else
		echo_error 'gpg has none install on this computer, install now ...'
		brew --help > /dev/null 2>&1
		if [ $? -eq 0 ]
		then
			brew install gpg > /dev/null
		else
			echo_error 'not mac os, now only adapt mac os'
		fi
	fi
fi
gpg --import ./keys/PICWORKS-HKDL-2017.asc
gpg --import ./keys/PICWORKS-HKDL-Test-2017.asc
gpg --import ./keys/HKDL-PicWorks-TEST.asc

if [ $? -eq 0 ]
then
	echo_success 'success import gpg keys'
else
	echo_error 'gpg keys not correctly import to os, please check, the project can not encryt files'
fi

npm install

echo_time `date`

if [ 'dev' = "${1}" ]
	then
	
	read -p 'run cmr/sap/ma?(c/s/m): ' project
	case $project in
	    c)  
			echo_info 'run cmr';
			read -p 'run ma for hk/sh/49 database?(hk/sh/49): ' db
			case $db in
				hk)
					db="hk";
				;;
				sh)
					db="sh";
				;;
				49)
					db="test";
				;;
				*)
					echo_error 'error select db, auto select 49 database';
					db="test";
				;;
			esac
			npm run "${db}"_cmr
	    ;;
	    s)  
			echo_info 'run sap';
			read -p 'run ma for hk/sh/49 database?(hk/sh/49): ' db
			case $db in
				hk)
					db="hk";
				;;
				sh)
					db="sh";
				;;
				49)
					db="test";
				;;
				*)
					echo_error 'error select db, auto select 49 database';
					db="test";
				;;
			esac
			npm run "${db}"_sap
	    ;;
	    m)  
			echo_info 'run ma';
			read -p 'run ma for hk/sh/49 database?(hk/sh/49): ' db
			case $db in
				hk)
					db="hk";
				;;
				sh)
					db="sh";
				;;
				49)
					db="test";
				;;
				*)
					echo_error 'error select db, auto select 49 database';
					db="test";
				;;
			esac
			npm run "${db}"_ma
	    ;;
	    *)  
			echo_error 'error select, close!';
	    ;;
	esac
fi
