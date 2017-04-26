#!/bin/bash
monitordir=./synctest
originip=172.16.20.107
user=josh.zhu
origindir=./synctest
cd $monitordir || { mkdir $monitordir; cd $monitordir; }

{
inotifywait -mrq --format '%e %w%f %T' --timefmt='%Y-%m-%d/%H:%M:%S' -e modify,create,delete,attrib,close_write,move . | \
while read INO_EVENT INO_FILE INO_TIME
do
	if [[ $INO_EVENT =~ 'CLOSE_WRITE' ]] || [[ $INO_EVENT =~ 'MOVED_TO' ]] || [[ $INO_EVENT =~ 'ATTRIB' ]]
    # || [[ $INO_EVENT =~ 'CREATE' ]] 
    # || [[ $INO_EVENT =~ 'MODIFY' ]] 
   	then
        #rsync -avzcR $(dirname ${INO_FILE}) ${BACKUP_MACHINE_USER}@${BACKUP_MACHINE_IP}:${BACKUP_MACHINE_PATH}
        echo ===$INO_TIME $INO_FILE $INO_EVENT : rsync -avzcR ${INO_FILE} ${user}@${originip}:${origindir}     
        rsync -avzcR ${INO_FILE} ${user}@${originip}:${origindir}          
   	fi
   	if [[ $INO_EVENT =~ 'MOVED_FROM' ]] || [[ $INO_EVENT =~ 'DELETE' ]]
   	then
   		echo ===$INO_TIME $INO_FILE $INO_EVENT : rsync -avzR --delete $(dirname ${INO_FILE}) ${user}@${originip}:${origindir}
      rsync -avzR --delete $(dirname ${INO_FILE}) ${user}@${originip}:${origindir} 
   	fi
done
}&
echo "PID of monitor: $!"


while :; do
  echo rsync -avzcR . ${user}@${originip}:${origindir}
  rsync -avzcR . ${user}@${originip}:${origindir}
  sleep 3600
done

##### this can be used for fily sync
