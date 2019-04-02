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
wget https://download3.vmware.com/software/wkst/file/VMware-Workstation-Full-14.1.1-7528167.x86_64.bundle?HashKey=f3ad3d428a423174c01d8d6c375b1d70&params=%7B%22custnumber%22%3A%22JXBAdHclanRkdA%3D%3D%22%2C%22sourcefilesize%22%3A%22439.42+MB%22%2C%22dlgcode%22%3A%22WKST-1411-LX%22%2C%22languagecode%22%3A%22en%22%2C%22source%22%3A%22DOWNLOADS%22%2C%22downloadtype%22%3A%22manual%22%2C%22eula%22%3A%22Y%22%2C%22downloaduuid%22%3A%223a72b7bd-44a3-4d70-a4c5-3f8c7a20d33d%22%2C%22purchased%22%3A%22N%22%2C%22dlgtype%22%3A%22Product+Binaries%22%2C%22productversion%22%3A%2214.1.1%22%2C%22productfamily%22%3A%22VMware+Workstation+Pro%22%7D&AuthKey=1554166233_a4747eb3269332425433104bf3c8f5af
chmod +x VMware-Workstation-Full-14.1.1-7528167.x86_64.bundle
sh VMware-Workstation-Full-14.1.1-7528167.x86_64.bundle

#导入密匙
sudo /usr/lib/vmware/bin/vmware-vmx --new-sn FF31K-AHZD1-H8ETZ-8WWEZ-WUUVA

#卸载使用命令
#vmware-installer -u vmware-workstation 

