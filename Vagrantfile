Vagrant.configure("2") do |config|
    config.vm.box = "puppetlabs/centos-6.6-32-nocm"
    config.vm.define :web do |web_config|
        web_config.vm.host_name = "web"
        web_config.vm.network "private_network", ip:"192.168.100.10"
        web_config.vm.provider :virtualbox do |vb|
            vb.customize ["modifyvm", :id, "--memory", "256"]
            vb.customize ["modifyvm", :id, "--cpuexecutioncap", "8"]
        end
    end
    config.vm.define :app01 do |web_config|
        web_config.vm.host_name = "app01"
        web_config.vm.network "private_network", ip:"192.168.100.11"
        web_config.vm.provider :virtualbox do |vb|
            vb.customize ["modifyvm", :id, "--memory", "256"]
            vb.customize ["modifyvm", :id, "--cpuexecutioncap", "8"]
        end
    end
#    config.vm.define :app02 do |web_config|
#        web_config.vm.host_name = "app02"
#        web_config.vm.network "private_network", ip:"192.168.100.12"
#        web_config.vm.provider :virtualbox do |vb|
#            vb.customize ["modifyvm", :id, "--memory", "256"]
            #vb.customize ["modifyvm", :id, "--cpuexecutioncap", "10"]
#        end
#    end
#    config.vm.define :memcached01 do |web_config|
#        web_config.vm.host_name = "memcached01"
#        web_config.vm.network "private_network", ip:"192.168.100.13"
#        web_config.vm.provider :virtualbox do |vb|
#            vb.customize ["modifyvm", :id, "--memory", "256"]
            #vb.customize ["modifyvm", :id, "--cpuexecutioncap", "10"]
#        end
#    end
#    config.vm.define :mysql01 do |web_config|
#        web_config.vm.host_name = "mysql01"
#        web_config.vm.network "private_network", ip:"192.168.100.14"
#        web_config.vm.provider :virtualbox do |vb|
#            vb.customize ["modifyvm", :id, "--memory", "256"]
#            vb.customize ["modifyvm", :id, "--cpuexecutioncap", "10"]
#        end
#    end
    config.vm.provision :shell do |shell|
        shell.path = "vagrant/bootstrap.sh"
    end
    config.vm.provision "puppet", run: "always" do |puppet|
        puppet.manifests_path = "puppet/manifest"
        puppet.hiera_config_path = "puppet/hiera.yaml"
        puppet.manifest_file = "init.pp"
        puppet.options = "--verbose"
    end
end