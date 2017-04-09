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

    # let's use minimal/jessie64 image which has all the required vbox ext
    # debian/jessie64 a little bit buggy and requires additional configrations
    # and plugins
    puppetmaster.vm.box = "sergk/jessie64"
    puppetmaster.vm.host_name = "puppetmaster.test.local"

    # disable default vagrant folder mounting
    puppetmaster.vm.synced_folder "./", "/vagrant", disabled: true

    puppetmaster.vm.provider "virtualbox" do |v, vboxoverride|
      vboxoverride.vm.network "private_network", ip: "192.168.56.102"
      # inject puppet stuff
      vboxoverride.vm.synced_folder "../puppet-manifests/hiera/", "/var/lib/hiera", owner: "root", group: "root"
      vboxoverride.vm.synced_folder "../puppet-manifests/modules/", "/usr/share/puppet/modules", owner: "root", group: "root"
      vboxoverride.vm.synced_folder "../puppet-manifests/manifests/", "/etc/puppet/manifests", owner: "root", group: "root"
      vboxoverride.vm.synced_folder "../puppet-manifests/bin", "/etc/puppet/bin", owner: "root", group: "root"

      v.customize ["modifyvm", :id, "--name", "puppetmaster"]
      v.customize ["modifyvm", :id, "--memory", "1024"]
      v.customize ["modifyvm", :id, "--cpus", "1"]
      v.customize ["modifyvm", :id, "--ioapic", "on"]
      v.gui = false
    end

    puppetmaster.vm.provider "libvirt" do |lv, override|
      override.vm.box = "debian/jessie64"
      override.vm.network :private_network,
                        libvirt__ip: "192.168.56.102",
                        libvirt__dhcp_enabled: false

      # inject puppet stuff
      override.vm.synced_folder "../puppet-manifests/hiera/", "/var/lib/hiera", type: "nfs"
      override.vm.synced_folder "../puppet-manifests/modules/", "/usr/share/puppet/modules", type: "nfs"
      override.vm.synced_folder "../puppet-manifests/manifests/", "/etc/puppet/manifests", type: "nfs"
      override.vm.synced_folder "../puppet-manifests/bin", "/etc/puppet/bin", type: "nfs"

      lv.memory = 2048
      lv.cpus = 1
      lv.nested = true
      lv.volume_cache = 'unsafe'
    end

  end

  config.vm.provision "file", source: "./authorized_keys", destination: "~/.ssh/authorized_keys"

  config.vm.provision :shell, path: "./bootstrap.sh"

end
