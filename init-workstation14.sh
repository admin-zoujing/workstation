#!/bin/bash
#centos7.4安装workstation14脚本

chmod -R 777 /usr/local/src/workstation14
#1、时间时区同步，修改主机名
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ntpdate cn.pool.ntp.org
hwclock --systohc
echo "*/30 * * * * root ntpdate -s 3.cn.poop.ntp.org" >> /etc/crontab

sed -i 's|SELINUX=.*|SELINUX=disabled|' /etc/selinux/config
sed -i 's|SELINUXTYPE=.*|#SELINUXTYPE=targeted|' /etc/selinux/config
sed -i 's|SELINUX=.*|SELINUX=disabled|' /etc/sysconfig/selinux 
sed -i 's|SELINUXTYPE=.*|#SELINUXTYPE=targeted|' /etc/sysconfig/selinux
setenforce 0 && systemctl stop firewalld && systemctl disable firewalld 

rm -rf /var/run/yum.pid 
rm -rf /var/run/yum.pid

#yum -y groupinstall "Server with GUI" 
cd /usr/local/src/workstation14
chmod +x kernel-devel-3.10.0-693.el7.x86_64.rpm
yum -y install kernel-devel-3.10.0-693.el7.x86_64.rpm gcc

#加载modules路径
locate  libpk-gtk-module.so
cat >> /etc/ld.so.conf.d/gtk-2.0.conf <<EOF
/usr/lib64/gtk-2.0/modules
EOF

#重新加载
ldconfig

#给权限安装
cd /usr/local/src/workstation14
chmod +x VMware-Workstation-Full-14.1.1-7528167.x86_64.bundle
sh VMware-Workstation-Full-14.1.1-7528167.x86_64.bundle

#导入密匙
sudo /usr/lib/vmware/bin/vmware-vmx --new-sn FF31K-AHZD1-H8ETZ-8WWEZ-WUUVA

#卸载使用命令
#vmware-installer -u vmware-workstation 

