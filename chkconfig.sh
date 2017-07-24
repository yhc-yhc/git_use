#!/bin/bash  
  
#description: hello.sh  
#chkconfig: 2345 20 81  
  
EXEC_PATH=/usr/local/  
EXEC=hello.sh  
DAEMON=/usr/local/hello.sh  
PID_FILE=/var/run/hello.sh.pid  
  
. /etc/rc.d/init.d/functions  
  
if [ ! -x $EXEC_PATH/$EXEC ] ; then  
       echo "ERROR: $DAEMON not found"  
       exit 1  
fi  
  
stop()  
{  
       echo "Stoping $EXEC ..."  
       ps aux | grep "$DAEMON" | kill -9 `awk '{print $2}'` >/dev/null 2>&1  
       rm -f $PID_FILE  
       usleep 100  
       echo "Shutting down $EXEC: [  OK  ]"      
}  
  
start()  
{  
       echo "Starting $EXEC ..."  
       $DAEMON > /dev/null &  
       pidof $EXEC > $PID_FILE  
       usleep 100  
       echo "Starting $EXEC: [  OK  ]"          
}  
  
restart()  
{  
    stop  
    start  
}  
  
case "$1" in  
    start)  
        start  
        ;;  
    stop)  
        stop  
        ;;  
    restart)  
        restart  
        ;;  
    status)  
        status -p $PID_FILE $DAEMON  
        ;;  
    *)  
        echo "Usage: service $EXEC {start|stop|restart|status}"  
        exit 1  
esac  
  
exit $?  

# chmod 700 test.sh
# cp test.sh /etc/init.d/
# chkconfig --add test.sh
# chkconfig --list
# chkconfig  --del test.sh