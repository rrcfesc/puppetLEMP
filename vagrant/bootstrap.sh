sudo yum install -y ruby;
sudo yum install -y ruby-rdoc ruby-devel;
#Instalacion de puppet en la maquina virtual
sudo rpm --import http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs;
sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6
sudo rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm;
sudo rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm;
sudo yum -y install puppet;
#Instalacion de los modulos de puppet

sudo puppet module install jfryman-nginx;
sudo puppet module install thias-php;
sudo puppet module install puppetlabs-stdlib;
sudo puppet module install puppetlabs-apt;
sudo puppet module install puppetlabs-concat;
sudo puppet module install stahnma-epel;
#causa un error en maquinas no windows 
#lo elimino por eso pero en realidad no servia de nada
#sudo puppet module install chocolatey-chocolatey;
sudo puppet module install treydock-gpg_key;
sudo puppet module install example42-yum;
sudo puppet module install puppetlabs-mysql;
sudo puppet module install puppetlabs-nodejs;
sudo puppet module install willdurand/composer;
sudo puppet module install thias-memcached;
sudo puppet module install puppet/staging;
sudo puppet module install puppet/archive;
sudo puppet module install puppetlabs/firewall;
sudo puppet module upgrade puppetlabs-stdlib --force;
sudo puppet module install aco-tomcat --version 1.6.1;
