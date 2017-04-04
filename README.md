
# commonly used git command
	git connfig --global user.name '{name}'
	git config --global user.email '{email}'
	ssh-keygen -t rsa -C '{email}'
	cat ~/.ssh/id_rsa.pub

生成git ssh key 并查看， 可以添加到远程的ssh key 中。

	git remote add origin {url}  
设置git远程仓库地址

	git remote set-url origin {url} 
修改远程仓库地址

	git push -u origin master 
首次把本地仓库同步到远程master

	git remote -v 
查看远程仓库地址

	git branch -r
查看远程分支

	git checkout -b {branchname} 
新建并切换到 分支 branchname

	git fetch
	git checkout -b {localBranchName} origin/{originBranchName}
拉取远程分支到本地分支

	git push origin develop:master -f 
把本志的develop分支强制推送到远程master

	git push origin master -f 
强制推送到远程master分支

	git checkout master && git reset --hard develop 
切换本地分支到master, 并且把master分支内容重置为develop分支内容
 
	git push origin :branch-name 
删除远程分支 

	git submodule add [--force] {url} {dirname} 
把另一个git仓库作为子模块加到当前项目的 dirname目录 

	git submodule update --init --recursive
初始化git子模块项目

	git rm {dirname}  && rm .gitmodules
删除git子模块

	git log --pretty=format:"%h" -n 1
提取最后n次提交的短commitId

	git rev-parse --short HEAD
提取最后一次提交的短commitId

	git rev-parse HEAD
提取最后一次提交的长commitId

{% include_relative centos.md %}

