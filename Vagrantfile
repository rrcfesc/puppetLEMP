Vagrant.configure("2") do |config|    
    config.vm.define :app01 do |app01|
        app01.vm.box = "puppetlabs/centos-6.6-64-nocm"
        app01.vm.host_name = "app01"
        app01.vm.network "private_network", ip:"192.168.100.11"
        app01.vm.provider :virtualbox do |vbapp01|
            vbapp01.customize ["modifyvm", :id, "--memory", "256"]
            vbapp01.customize ["modifyvm", :id, "--cpuexecutioncap", "10"]
        end
        app01.vm.synced_folder "../proyecto", "/www/www.proyecto.local.com", disabled: (not FileTest::directory?("../proyecto"))
        app01.vm.provision :shell do |shell|
            shell.path = "vagrant/bootstrap.sh"
        end
        app01.vm.provision "puppet", run: "always" do |puppet|
            puppet.manifests_path = "puppet/manifest"
            puppet.hiera_config_path = "puppet/hiera.yaml"
            puppet.manifest_file = "init.pp"
            puppet.options = "--verbose"
        end
        app01.vm.provision "puppet", run: "always" do |puppetapp01|
            puppetapp01.manifests_path      = "puppet/manifest"
            puppetapp01.hiera_config_path   = "puppet/hiera.yaml"
            puppetapp01.manifest_file       = "init.pp"
            puppetapp01.options             = "--verbose"
        end
    end
    config.vm.define :app02 do |app02|
        app02.vm.host_name = "app02"
        app02.vm.box = "puppetlabs/centos-6.6-64-nocm"
        app02.vm.network "private_network", ip:"192.168.100.12"
        app02.vm.provider :virtualbox do |vbapp02|
            vbapp02.customize ["modifyvm", :id, "--memory", "256"]
            vbapp02.customize ["modifyvm", :id, "--cpuexecutioncap", "7"]
        end
        app02.vm.synced_folder "../proyecto", "/www/www.proyecto.local.com", disabled: (not FileTest::directory?("../proyecto"))
        app02.vm.provision :shell do |shell|
            shell.path = "vagrant/bootstrap.sh"
        end
        app02.vm.provision "puppet", run: "always" do |puppetapp02|
            puppetapp02.manifests_path      = "puppet/manifest"
            puppetapp02.hiera_config_path   = "puppet/hiera.yaml"
            puppetapp02.manifest_file       = "init.pp"
            puppetapp02.options             = "--verbose"
        end
    end
    config.vm.define :web01 do |web01|
        web01.vm.host_name = "web01"
        web01.vm.box = "puppetlabs/centos-6.6-64-nocm"
        web01.vm.network "private_network", ip:"192.168.100.10"
        web01.vm.provider :virtualbox do |vbweb01|
            vbweb01.customize ["modifyvm", :id, "--memory", "256"]
            vbweb01.customize ["modifyvm", :id, "--cpuexecutioncap", "7"]
        end
        web01.vm.synced_folder "../proyecto", "/www/www.proyecto.local.com", disabled: (not FileTest::directory?("../proyecto"))
        web01.vm.provision :shell do |shell|
            shell.path = "vagrant/bootstrap.sh"
        end
        web01.vm.provision "puppet", run: "always" do |puppetweb01|
            puppetweb01.manifests_path      = "puppet/manifest"
            puppetweb01.hiera_config_path   = "puppet/hiera.yaml"
            puppetweb01.manifest_file       = "init.pp"
            puppetweb01.options             = "--verbose"
        end
    end
    config.vm.define :mem01 do |mem01|
        mem01.vm.host_name = "mem01"
        mem01.vm.box = "puppetlabs/centos-6.6-64-nocm"
        mem01.vm.network "private_network", ip:"192.168.100.13"
        mem01.vm.provider :virtualbox do |vbmem01|
            vbmem01.customize ["modifyvm", :id, "--memory", "256"]
            vbmem01.customize ["modifyvm", :id, "--cpuexecutioncap", "10"]
        end
        mem01.vm.provision :shell do |shell|
            shell.path = "vagrant/bootstrap.sh"
        end
        mem01.vm.provision "puppet", run: "always" do |puppetmem01|
            puppetmem01.manifests_path      = "puppet/manifest"
            puppetmem01.hiera_config_path   = "puppet/hiera.yaml"
            puppetmem01.manifest_file       = "init.pp"
            puppetmem01.options             = "--verbose"
        end
    end
    config.vm.define :dat01 do |dat01|
        dat01.vm.host_name = "dat01"
        dat01.vm.box = "puppetlabs/centos-6.6-64-nocm"
        dat01.vm.network "private_network", ip:"192.168.100.14"
        dat01.vm.provider :virtualbox do |vbdat01|
            vbdat01.customize ["modifyvm", :id, "--memory", "256"]
            vbdat01.customize ["modifyvm", :id, "--cpuexecutioncap", "10"]
        end
        dat01.vm.provision :shell do |shell|
            shell.path = "vagrant/bootstrap.sh"
        end
        dat01.vm.provision "puppet", run: "always" do |puppetdat01|
            puppetdat01.manifests_path      = "puppet/manifest"
            puppetdat01.hiera_config_path   = "puppet/hiera.yaml"
            puppetdat01.manifest_file       = "init.pp"
            puppetdat01.options             = "--verbose"
        end
    end
end