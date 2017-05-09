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

while :; do
  command="rsync -avzcR --delete . ${user}@${originip}:${origindir}"
  echo command: $command >> ../total_sync.log.txt
  echo ==》`date +%Y/%m/%d_%H%M%S` >> ../total_sync.log.txt
  eval $command >> ../total_sync.log.txt
  echo 《==`date +%Y/%m/%d_%H%M%S` >> ../total_sync.log.txt
  sleep 600
done

##### this can be used for fily sync
