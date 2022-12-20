#!/usr/bin/env bash


release_id=`grep "CENTOS_MANTISBT_PROJECT_VERSION" /etc/os-release | cut -d '"' -f 2`

rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org

yum install -y https://www.elrepo.org/elrepo-release-${release_id}.el${release_id}.elrepo.noarch.rpm

sed -i 's/^mirrorlist=/# &/g' /etc/yum.repos.d/elrepo.repo
sed -i 's#elrepo.org/linux#mirrors.tuna.tsinghua.edu.cn/elrepo#g' /etc/yum.repos.d/elrepo.repo

yum makecache

yum --enablerepo=elrepo-kernel install kernel-lt -y

grub2-set-default 0

grub2-mkconfig -o /boot/grub2/grub.cfg

reboot