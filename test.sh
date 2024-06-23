#!/bin/bash

# Install ZFS
yum install -y http://download.zfsonlinux.org/epel/zfs-release.el7_8.noarch.rpm
#import gpg key 
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-zfsonlinux
#install DKMS style packages for correct work ZFS
yum install -y epel-release kernel-devel zfs
#change ZFS repo
yum-config-manager --disable zfs
yum-config-manager --enable zfs-kmod
yum install -y zfs
#Add kernel module zfs
modprobe zfs
#install wget
yum install -y wget
# Load ZFS module
modprobe zfs
# Create ZFS pools with different compression types
sudo -i
zpool create otus1 /dev/sdb /dev/sdc
zfs set compression=lzjb otus1

zpool create otus2 /dev/sdd /dev/sde
zfs set compression=lz4 otus2

zpool create otus3 /dev/sdf /dev/sdg
zfs set compression=gzip-9 otus3

zpool create otus4 /dev/sdh /dev/sdi
zfs set compression=zle otus4