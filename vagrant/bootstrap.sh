sudo yum install -y ruby;
sudo yum install -y ruby-rdoc ruby-devel;
sudo systemctl stop firewalld;
sudo yum install epel-release;
#sudo service iptables stop;
#Instalacion de puppet en la maquina virtual
sudo rpm --import http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs;
#sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6;
sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm;
sudo yum clean expire-cache;
#sudo rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm;
#pwd;
#ls -al;
#wget ftp://rpmfind.net/linux/remi/enterprise/6/remi/x86_64/libzip-last-1.1.3-1.el6.remi.x86_64.rpm;
#sudo rpm -Uvh libzip-*.rpm;
#pwd;
#ls -al;
sudo yum -y install puppet-agent;
source ~/.bashrc

#sudo yum -y install epel-release;
#Instalacion de los modulos de puppet

 puppet module install puppet-nginx --version 0.5.0;
 puppet module install thias-php;
 puppet module install puppetlabs-stdlib;
 puppet module install puppetlabs-apt;
 puppet module install puppetlabs-concat;
 puppet module install stahnma-epel;
#causa un error en maquinas no windows 
#lo elimino por eso pero en realidad no servia de nada
#sudo puppet module install chocolatey-chocolatey;
 puppet module install treydock-gpg_key;
 puppet module install example42-yum;
 puppet module install puppetlabs-mysql;
 puppet module install puppetlabs-nodejs;
 puppet module install willdurand/composer;
 puppet module install thias-memcached;
 puppet module install puppet/staging;
 puppet module install puppet/archive;
 puppet module install puppetlabs/firewall;
#sudo puppet module upgrade puppetlabs-stdlib --force;
 puppet module install puppetlabs-ntp --version 6.0.0;
