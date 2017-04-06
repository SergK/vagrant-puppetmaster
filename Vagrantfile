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

  config.vm.define "puppetmaster", primary: true do |puppetmaster|
    #puppetmaster.vm.network "forwarded_port", guest: 80, host: 8888
    puppetmaster.vm.box = "minimal/jessie64"
    puppetmaster.vm.host_name = "puppetmaster.test.local"
    puppetmaster.vm.network "private_network", ip: "192.168.56.102"

    # puppetmaster.vm.synced_folder "../puppet-manifests/hiera/", "/var/lib/hiera", owner: "root", group: "root"
    # puppetmaster.vm.synced_folder "../puppet-manifests/modules/", "/usr/share/puppet/modules", owner: "root", group: "root"
    # puppetmaster.vm.synced_folder "../puppet-manifests/manifests/", "/etc/puppet/manifests", owner: "root", group: "root"
    # puppetmaster.vm.synced_folder "../puppet-manifests/bin", "/etc/puppet/bin", owner: "root", group: "root"

      puppetmaster.vm.provider "virtualbox" do |v|
        v.customize ["modifyvm", :id, "--name", "puppetmaster"]
        v.customize ["modifyvm", :id, "--memory", "1024"]
        v.customize ["modifyvm", :id, "--cpus", "1"]
        v.customize ["modifyvm", :id, "--ioapic", "on"]
        v.gui = false
      end
  end

  config.vm.provision "file", source: "./authorized_keys", destination: "~/.ssh/authorized_keys"

  config.vm.provision :shell, path: "./bootstrap.sh"

end
