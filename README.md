commonly used git command

git connfig --global user.name 'josh'
git config --global user.email 'zhujingli_yhc@163.com'

ssh-keygen -t rsa -C 'zhujingli_yhc@163.com'

cat ~/.ssh/id_rsa.pub

生成git ssh key 并查看， 可以添加到远程的ssh key 中。

git remote -v 查看远程仓库地址
git remote add origin {url}  设置git远程仓库地址
git push -u origin master 首次把本地仓库同步到远程master
git remote set-url origin {url} 修改远程仓库地址

git submodule add {url} {dirname} 把另一个git仓库作为子模块加到当前项目的 dirname目录下。