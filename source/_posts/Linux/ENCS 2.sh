#!/bin/bash
cat << EOF
+---------------------------------------------------------------------------+
|            ENCS实施部署脚本  -  版权所有：甘肃紫光                        |
|作者：车涛锋     chetaofeng@163.com                                        |
|时间：2017-04-15                                                           |
|适用系统：CentOS 6.5                                                       |
|说明：                                                                     |
|    本脚本适用于第一次安装系统之后的系统设置和ENCS配置及运行               |
|    使用过程中如果有问题或改进建议，请及时与我联系 QQ:183822908            |
+---------------------------------------------------------------------------+
EOF

##########################################################################
CWD=$(pwd) #获取当前工作目录
VERSION="GSUnis Version1.0   2017"
SERVICE=`which service`
CHKCONFIG=`which chkconfig`
BACK_DIR="/root/bak_dir"
TMP_DIR="/root/bak_dir/tmp"
DOWNLOAD_DIR="/usr/encs_download"
BASE_DIR="/home/GSUnis4.0/GSUnis.ENCS/"
MONIOTR_BASE_DIR="/home/GSUnis4.0/GSUnis.Monitor/"
test -d $BACK_DIR || mkdir  -p $BACK_DIR
test -d $TMP_DIR || mkdir  -p $TMP_DIR
IS_CENTOS7=0	#是否是CentOS7，默认不是
JDK_PATH=""
test -d $DOWNLOAD_DIR || mkdir  -p $DOWNLOAD_DIR
test -d $BASE_DIR || mkdir  -p $BASE_DIR
test -d $MONIOTR_BASE_DIR ||mkdir -p $MONIOTR_BASE_DIR 

############################function#########################################
version(){ 
	echo $VERSION
}

sysInfo(){
	echo ["$(uname -a)"]
}

isRoot(){
	if [[ "$(whoami)" != 'root' ]];then
		echo "请用管理员身份运行" 
		exit 1
	fi
}

isCentOS(){
	strA=["$(more /etc/redhat-release | grep CentOS)"]
	strB="CentOS"
	strC="CentOS7"
	if [[ $strA =~ $strB ]];then
	 	if [[ $strA =~ $strC ]];then
                	IS_CENTOS7=1 
		fi
	else
  		echo "当前系统不是CentOS系统！"
		exit 1
	fi
}

setConfig(){
	read -p "请输入节点类型，1-收费站   2-收费所／分中心  3-中心：" type
	read -p "请输入节点编号：" stationId 
}

download(){ 
	read -p "请输入升级服务器地址,使用默认地址，请直接回车确认：" upServerIp  
	tmpUpServerIp="192.168.1.108"
	upServerIp=${upServerIp:-$tmpUpServerIp}   
	pingCheck $upServerIp
	if [ $? -eq 0 ];then
	   echo "与升级服务器网络不通，无法下载"
	   exit 2
	fi
 
	cd $DOWNLOAD_DIR
	if [ -f "readme.md" ]; then     
		rm -rf $DOWNLOAD_DIR 
		mkdir $DOWNLOAD_DIR 
	fi    
	downloadUrl="http://"$upServerIp":8080/examples/encs_download/download_list.txt" 
	echo $downloadUrl
	wget -i  $downloadUrl
	if [ ! -f "readme.md" ]; then    
		echo "文件下载失败"
		exit 10
	fi   
	echo "=========================================文件已下载成功！"
}

pingCheck(){ 
	ping -c 3 $1 > /dev/null 2>&1    
	if [ $? -eq 0 ];then  
	    echo $1 网络正常  
	    return 1
	else  
	    echo $1 网络连接异常   
	    return 0
	fi  
}
 
network(){
	echo "---------------开始设置网络相关----------"
	read -p "请输入IP：" tmpIp 
	read -p "请输入子网掩码：" tmpMask 
	read -p "请输入网关：" tmpGateway
	
	cat > $TMP_DIR/ifcfg-eth0 <<-EOF
		DEVICE=eth0
		BOOTPROTO=static
		ONBOOT=yes
		IPADDR=$tmpIp
		NETMASK=$tmpMask
		GATEWAY=$tmpGateway
	EOF

	echo "写临时文件完毕"

	\cp /etc/sysconfig/network-scripts/ifcfg-eth0 $BACK_CONF/ifcfg-eth0.$(date +%F)
	cat $TMP_DIR/ifcfg-eth0 > /etc/sysconfig/network-scripts/ifcfg-eth0
	#使IP生效
	if ["$IS_CENTOS7" == "1"];then
		systemctl restart network.service
	else
		service network restart
	fi

	echo "----------ip设置完毕!---------"
}

ntp(){
	pingCheck 10.62.0.2
	if [ $? -eq 0 ];then
	   echo "与时钟同步服务器10.62.0.2网络不通，时钟同步失败"
	   exit 2
	fi
	
	ntpdate -u 10.62.0.2
	echo "ntp"
}

timezone(){
	if [ 'ZONE="Asia/Shanghai' == `cat /etc/sysconfig/clock`  ];then
		\cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
		echo 'ZONE="Asia/Shanghai"' > /etc/sysconfig/clock
	fi
	echo "=========================================时区已设置成功"
	date -R
}
  
iptables(){
	echo "正在关闭防火墙..."
	service iptables stop &> /dev/null
	chkconfig --level 235 iptables off
	echo "iptables is disabled!" 
}

ipv6Disabled(){
	echo "alias net-pf-10 off" >> /etc/modprobe.conf
	echo "alias ipv6 off" >> /etc/modprobe.conf
	/sbin/chkconfig ip6tables off
	echo "ipv6 is disabled!"  
}

selinuxDisabled(){
	sed -i '/SELINUX/s/enforcing/disabled/' /etc/selinux/config
	setenforce 0
	echo "selinux is disabled!" 
}
#########################################################业务系统配置################
mysql(){
	tmpPassWordStr=$(cat /root/.mysql_secret) 
	initPassWord=${tmpPassWordStr#*):}
	echo $initPassWord
 
	service mysql stop
	\rm -rf /var/lib/mysql/*
	mysql_install_db
	chown -R mysql:mysql /var/lib/mysql/
	service mysql start
	/usr/bin/mysqladmin password unistolllink
	
	exit 1

	if [ "$IS_CENTOS7" == "1" ];then
		tmpMysql=`rpm -qa | grep -i mariadb`
		if [ "${tmpMysql}" != "" ];then
			rpm -e --nodeps $tmpMysql
		fi 	 
	fi

	tmpMysql=`rpm -qa | grep -i mysql`
	if [ "${tmpMysql}" != "" ];then  
		read -p "系统检测到已安装MySQL,CentOS系统默认会安装MySQL,是否需要覆盖安装? [Y/N]:" answer  
		answer=`echo $answer | tr '[a-z]' '[A-Z]'` 
		if [ "${answer}" != "Y" ];then  
			echo "MySQL安装已终止!!!"
			exit 2
		fi 
		for i in $tmpMysql;
		do  
			rpm -e --nodeps $i   
		done  
	fi   
	cd /usr/local/
	if [ ! -d "mysql" ]; then 
		mkdir mysql
	fi 
	cd /usr/local/mysql/ 
	mysqlName=`ls ${DOWNLOAD_DIR}|grep MySQL` 
	if [ -f  "$mysqlName" ]; then   
	 　　rm -rf ${mysqlName}
	fi  
	\cp ${DOWNLOAD_DIR}"/"${mysqlName}  ${mysqlName}  
	tar -xvf ${mysqlName} &> /dev/null 
	rm -rf ${mysqlName} 
	
	 
	rpm -ivh `ls /usr/local/mysql | grep server`
	rpm -ivh `ls /usr/local/mysql | grep client`  
	 
	service mysql restart
	netstat -ant|grep 3306 
}

tomcat(){
	if [ "${JDK_PATH}" == "" ];then
		echo "请先安装JDK"
		exit 1
	fi 

	cd ${BASE_DIR} 
	tomcatName=`ls ${DOWNLOAD_DIR}|grep apache-tomcat` 
	if [ -f  "$tomcatName" ]; then  
	 　　rm -rf ${tomcatName}
	fi  
	\cp ${DOWNLOAD_DIR}"/"${tomcatName}  ${tomcatName}  
	tar -zxvf ${tomcatName}
	rm -rf ${tomcatName}  
	tomcatName=`ls ${BASE_DIR}|grep apache-tomcat`
	cd $tomcatName"/bin/" 
	if [ -f  /etc/init.d/ENCS ]; then  
		rm -rf /etc/init.d/ENCS
	fi  
	cp catalina.sh /etc/init.d/ENCS  
	sed -i '/#!\/bin\/sh/a\# chkconfig: 2345 10 90\n# description:apache-tomcat' /etc/init.d/ENCS 
	CATALINA_HOME="export CATALINA_HOME="${BASE_DIR}${tomcatName} 
	sed "29 i$CATALINA_HOME" -i /etc/init.d/ENCS 
	JAVA_HOME="export JAVA_HOME="${JDK_PATH} 
	sed "30 i$JAVA_HOME" -i /etc/init.d/ENCS  
	chmod a+x /etc/init.d/ENCS
	chkconfig --add ENCS
	chkconfig --list ENCS
} 

jdk(){ 
	cd /usr/ 
	if [ ! -d "java" ]; then 
		mkdir java
	fi 
	cd /usr/java/ 
	jdkName=`ls ${DOWNLOAD_DIR}|grep jdk` 
	if [ -f  "$jdkName" ]; then   
	 　　rm -rf ${jdkName}
	fi  
	\cp ${DOWNLOAD_DIR}"/"${jdkName}  ${jdkName}  
	tar -zxvf ${jdkName} &> /dev/null
	rm -rf ${jdkName} 
	jdkName=`ls ${JDK_PATH}|grep jdk`   
	JDK_PATH="/usr/java/"$jdkName  

	sed -i '$a\export JAVA_HOME='$JDK_PATH /etc/profile
	sed -i '$a\export PATH=\${JAVA_HOME}/bin:\$PATH' /etc/profile 
	source  /etc/profile 
}

encs(){
	echo "encs"
}

monitor(){
	if [ "${JDK_PATH}" == "" ];then
		echo "请先安装JDK"
		exit 1
	fi 
 
	cd $MONIOTR_BASE_DIR

	monitorName =`ls ${DOWNLOAD_DIR}|grep monitor` 
	if [ -f  "$monitorName" ]; then   
	 　　rm -rf ${monitorName}
	fi  
  
	\cp ${DOWNLOAD_DIR}"/"${monitorName}  ${monitorName}  	
	tar -zxvf ${monitorName} &> /dev/null
	rm -rf ${monitorName} 
	monitorName =`ls ${MONIOTR_BASE_DIR}|grep monitor `    

	cd $monitorName”/bin/“
	chmod a+x $monitorName
	./$monitorName install

	\cp ${monitorName}“.jar”  ${monitorName}”/lib/“${monitorName}“.jar”
	\cp ${DOWNLOAD_DIR}”/libsigar-amd64-linux.so“  ${monitorName}”/lib/libsigar-amd64-linux.so”
	
	service ${monitorName} restart

	echo “monitor”
}

power(){
	#init done,and reboot system  
	echo -e "是否重启电脑? [Y/N]:\t " 
	read REPLY 
	case $REPLY in  
	    Y|y) 
		echo "系统正在重启 ..." 
		shutdown -r now  
		;; 
	    N|n) 
		echo "请稍后自行启动..." 
		source /etc/profile  
		;; 
	    *) 
		echo "请输入[Y/N]." 
		source /etc/profile  
		;; 
	esac 
}
 
status(){
	echo "正在编写脚本中。。。"
}

###############################优先执行检测###############################
isRoot
isCentOS 

###############################Main方法###################################
case "$1" in
  version)
	version
	;;
  setConfig)
	setConfig
	;;
  pingCheck)
	pingCheck $2
	;;
  sysInfo)
	sysInfo
	;; 
  download)
	download
	;;
  network)
	 network
        ;;
  ntp)
	ntp
	;;
  timezone)
	timezone
	;;
  ipv6Disabled)
	ipv6Disabled
	;;
  selinuxDisabled)
	selinuxDisabled
	;;
  iptables)
	iptables
	;;
  mysql)
	mysql
	;;
  jdk)
	jdk
	;;
  tomcat)
	tomcat
	;;
  encs)
	encs
	;;
  monitor)
	monitor
	;;
  status)
	status
	;;
  all) 
	version
	setConfig
	network
	ntp
	iptables
	optimization
	mysql
	jdk
	tomcat
	encs
	monitor
	status 
	power
	;;
  *)
      echo "请输入操作参数"
      echo "用法:$0 {version|setConfig|download|network|ipv6Disabled|selinuxDisabled|ntp|iptables|mysql|jdk|tomcat|encs|monitor|status}"
      exit 2
esac
