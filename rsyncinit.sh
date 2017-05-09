
rsync josh.zhu@172.16.20.107:~/work/git_use/rsync.sh ./
rsync josh.zhu@172.16.20.107:~/work/git_use/rsync_test.sh ./

rsync josh.zhu@172.16.20.107:~/work/git_use/pre.JPG ./
rsync josh.zhu@172.16.20.107:~/work/git_use/x128.JPG ./
rsync josh.zhu@172.16.20.107:~/work/git_use/x512.JPG ./
rsync josh.zhu@172.16.20.107:~/work/git_use/x1024.JPG ./

rm -rf synctest

rsync ./inotify.log.txt josh.zhu@172.16.20.107:~/work/git_use/synclog
rsync ./total_sync.log.txt josh.zhu@172.16.20.107:~/work/git_use/synclog/

rm *.log.txt
