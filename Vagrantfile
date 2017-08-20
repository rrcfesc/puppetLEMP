# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box               = "geerlingguy/centos7"
    config.ssh.insert_key       = false
    config.vm.box_check_update  = false
    config.ssh.forward_agent    = true
    config.vm.boot_timeout      = 900
    config.vm.network "private_network", ip: "192.168.100.11"
    config.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--cpuexecutioncap", "20"]
        # Display the VirtualBox GUI when booting the machine
        vb.gui = false
        # Customize the amount of memory on the VM:
        vb.memory       = "300"
    end
    #Proyetco Proncipal
    config.vm.synced_folder "../proyecto", "/www/www.proyecto.local.com", disabled: (not FileTest::directory?("../proyecto"))
    #Core del Proyecto
    config.vm.synced_folder "../coreproyecto", "/www/www.coreproyecto.local.com",disabled: (not FileTest::directory?("../coreproyecto"))
    #Maqueta
    config.vm.synced_folder "../maqueta", "/www/www.maqueta.local.com",disabled: (not FileTest::directory?("../maqueta"))

    #Aprovisionamiento
    config.vm.provision :shell do |shell|
        shell.path      = "vagrant/bootstrap.sh"
    end
    #Configuración de Puppet
    config.vm.provision "puppet", run: "always" do |puppet|
        puppet.manifests_path           = "puppet/manifest"
        puppet.hiera_config_path        = "puppet/hiera.yaml"
        puppet.manifest_file            = "site.pp"
        puppet.options                  = "--verbose"
    end
end