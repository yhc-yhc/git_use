#!/bin/bash
monitordir=./synctest
originip=172.16.20.107
user=josh.zhu
origindir=./synctest
cd $monitordir > /dev/null 2>&1 || { mkdir $monitordir; cd $monitordir; }

{
inotifywait -mrq --format '%e %w%f %T' --timefmt='%Y-%m-%d/%H:%M:%S' -e modify,create,delete,attrib,close_write,move . | \
while read INO_EVENT INO_FILE INO_TIME
do
  # echo --- $INO_EVENT $INO_FILE ---
	if [[ $INO_EVENT == 'CLOSE_WRITE,CLOSE' ]];
  # if [[ $INO_EVENT == 'CREATE,ISDIR' ]];
 	then
    notify_sync="rsync -avzcR ${INO_FILE} ${user}@${originip}:${origindir}"
    echo $INO_TIME $INO_EVENT $INO_FILE == command: $notify_sync   >> ../inotify.log.txt 
    echo --》`date +%Y/%m/%d_%H%M%S` >> ../inotify.log.txt

    eval $notify_sync >> ../inotify.log.txt 
    echo 《--`date +%Y/%m/%d_%H%M%S` >> ../inotify.log.txt
 	fi
done
}&
# echo "PID of monitor: $!"  # $! get the child process pid

# while :; do
#   command="rsync -avzcR --delete . ${user}@${originip}:${origindir}"
#   echo command: $command >> ../total_sync.log.txt
#   echo ==》`date +%Y/%m/%d_%H%M%S` >> ../total_sync.log.txt
#   eval $command >> ../total_sync.log.txt
#   echo 《==`date +%Y/%m/%d_%H%M%S` >> ../total_sync.log.txt
#   sleep 600
# done

##### this can be used for fily sync

user=pictureworks
origindir=$3
echo "uploaddir:$1 IP:$2 remoteDir:$3";
mkdir logs > /dev/null 2>&1 || { echo logs exists; }
cd logs;
mkdir fileupload > /dev/null 2>&1 || { echo fileupload exists; }
logfile="/var/pictureworks/logs/fileupload/";
cd /var/upload/
mkdir backup > /dev/null 2>&1 || { echo backup exists; }
backup="/var/upload/backup/";
cd $monitordir > /dev/null 2>&1 || { mkdir $monitordir; cd $monitordir; }
inotifywait -mrq --format '%e %w%f %T' --timefmt='%Y-%m-%d/%H:%M:%S' -e modify,create,delete,attrib,close_write,move . | \
while read INO_EVENT INO_FILE INO_TIME
do
        if [[ $INO_EVENT == 'CLOSE_WRITE,CLOSE' ]];
        then
                notify_sync="rsync ${INO_FILE} ${user}@${ip}:${origindir}"
                echo $INO_TIME $INO_EVENT $INO_FILE == command: $notify_sync   >> $logfile`date +%Y%m%d`.upload.log

                eval $notify_sync
                cd $backup;
                mkdir `date +%Y%m%d` > /dev/null 2>&1;
                cd -;
                mv ${INO_FILE} $backup`date +%Y%m%d`/
        fi
done

./fileupload.sh /var/upload/source/ 172.16.10.63 /var/upload/source/
