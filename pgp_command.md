#gpg encrypt use

	gpg --list-keys
列出密钥

	gpg --import [密钥文件]
导入密钥文件到系统

	gpg --delete-key [用户ID]
	gpg --delete-key --always-trust --batch --yes [uid]
从密钥列表中删除某个密钥

	gpg --fingerprint [用户ID]
生成公钥指纹

	gpg --always-trust --yes --recipient [userId] --output {en.file.path}  --encrypt {file.paht}
加密{file.paht}到{en.file.path}

