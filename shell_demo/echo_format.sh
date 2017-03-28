echo_info(){
	echo -e "\033[1;36m $* \033[0m"
}

echo_error(){
    echo -e "\033[1;31m $* \033[0m"
}

echo_fatal(){
    echo -e "\033[1;35m $* \033[0m"
}

echo_warn(){
    echo -e "\033[1;33m $* \033[0m"
}

echo_primary(){
    echo -e "\033[1;34m $* \033[0m"
}

echo_success(){
	echo -e "\033[1;32m $* \033[0m"
}

echo_tip(){
	echo -e "\033[43;31;5m $1 \033[0m \033[1;31;4m $2 \033[0m"
}

echo_time(){
	echo -e "\033[49;32;5m $* \033[0m"
}

# 编码    颜色/动作 
# 0       重新设置属性到缺省设置 
# 1       设置粗体 
# 2       设置一半亮度（模拟彩色显示器的颜色） 
# 4       设置下划线（模拟彩色显示器的颜色） 
# 5       设置闪烁 
# 7       设置反向图象 
# 22      设置一般密度 
# 24      关闭下划线 
# 25      关闭闪烁 
# 27      关闭反向图象 
# 30      设置黑色前景 
# 31      设置红色前景 
# 32      设置绿色前景 
# 33      设置棕色前景 
# 34      设置蓝色前景 
# 35      设置紫色前景 
# 36      设置青色前景 
# 37      设置白色前景 
# 38      在缺省的前景颜色上设置下划线 
# 39      在缺省的前景颜色上关闭下划线 
# 40      设置黑色背景 
# 41      设置红色背景 
# 42      设置绿色背景 
# 43      设置棕色背景 
# 44      设置蓝色背景 
# 45      设置紫色背景 
# 46      设置青色背景 
# 47      设置白色背景 
# 49      设置缺省黑色背景