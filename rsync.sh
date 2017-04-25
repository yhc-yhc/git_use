#!/bin/bash
monitordir=./test
originip=172.16.20.107
user=josh.zhu
origindir=./test

cd $monitordir || { echo $monitordir not exists && exit 1; }
inotifywait -mrq --format '%e %w%f %T' --timefmt='%Y-%m-%d/%H:%M:%S' -e modify,create,delete,attrib,close_write,move . | \
while read INO_EVENT INO_FILE INO_TIME
do
	echo ============$INO_TIME $INO_FILE $INO_EVENT
	if [[ $INO_EVENT =~ 'CREATE' ]] || [[ $INO_EVENT =~ 'MODIFY' ]] || 
      [[ $INO_EVENT =~ 'CLOSE_WRITE' ]] || [[ $INO_EVENT =~ 'MOVED_TO' ]] || 
      [[ $INO_EVENT =~ 'ATTRIB' ]]
   	then
        #rsync -avzcR $(dirname ${INO_FILE}) ${BACKUP_MACHINE_USER}@${BACKUP_MACHINE_IP}:${BACKUP_MACHINE_PATH}
        echo rsync -avzcR ${INO_FILE} ${user}@${originip}:${origindir}     
        rsync -avzcR ${INO_FILE} ${user}@${originip}:${origindir}          
   	fi
   	if [[ $INO_EVENT =~ 'DELETE' ]] || [[ $INO_EVENT =~ 'MOVED_FROM' ]]
   	then
   		echo rsync -avzR --delete $(dirname ${INO_FILE}) ${user}@${originip}:${origindir}
      rsync -avzR --delete $(dirname ${INO_FILE}) ${user}@${originip}:${origindir} 
   	fi
done

##### this can be used for fily sync
