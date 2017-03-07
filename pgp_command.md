	gpg --list-keys
##列出密钥
	gpg --import [密钥文件]
##输入密钥
	gpg --always-trust --yes --recipient [userId] --output {en.file.path}  --encrypt {file.paht}
##加密{file.paht}到{en.file.path}
