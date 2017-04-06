# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  # we don't need secure vagrant key, since we are using our own in provisioning
  # phase
  config.ssh.insert_key = false


  config.vm.box = "minimal/xenial64"
  config.vm.box_check_update = false

  config.vm.network "private_network", ip: "192.168.56.102"

  config.vm.synced_folder "../data", "/vagrant_data", disabled: true

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true
    # Customize the amount of memory on the VM:
    vb.memory = "2048"
  end

  config.vm.provision "file", source: "./authorized_keys", destination: "~/.ssh/authorized_keys"

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
