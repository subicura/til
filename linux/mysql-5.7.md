# mysql 5.7

install mysql 5.7 ubuntu 14.04

install.sh

```
#!/bin/sh

export LC_ALL="en_US.UTF-8"
export DEBIAN_FRONTEND=noninteractive

wget http://dev.mysql.com/get/mysql-apt-config_0.6.0-1_all.deb
echo mysql-apt-config mysql-apt-config/repo-distro select ubuntu | debconf-set-selections
echo mysql-apt-config mysql-apt-config/repo-codename select trusty | debconf-set-selections
echo mysql-apt-config mysql-apt-config/select-server select mysql-5.7 | debconf-set-selections
echo mysql-community-server mysql-community-server/root-pass password "" | debconf-set-selections
echo mysql-community-server mysql-community-server/re-root-pass password "" | debconf-set-selections
dpkg -i mysql-apt-config_0.6.0-1_all.deb
apt-get update
apt-get install -y mysql-server
```
