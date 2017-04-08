#!/bin/bash -x

# use closer mirrors on nodes start
sed -i 's/\.us\./\.ua\./g' /etc/apt/sources.list

# update everything
sudo apt-get update && sudo DEBIAN_FRONTEND=noninteractive \
  apt-get -y -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" dist-upgrade

# install puppet stuff from puppetlabs
# wget https://apt.puppetlabs.com/puppetlabs-release-pc1-jessie.deb
# sudo dpkg -i puppetlabs-release-pc1-jessie.deb

# add backports repo
echo 'deb http://ftp.debian.org/debian jessie-backports main' | \
  sudo tee --append /etc/apt/sources.list

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y puppet -t jessie-backports

# clean-up a little
sudo apt-get autoremove -y

# add server to config
sed -i '/ssldir/a \server=puppetmaster.test.local' /etc/puppet/puppet.conf

sudo tee -a /etc/hosts <<EOF

192.168.56.102 puppetmaster.test.local puppetmaster
192.168.50.103 node-01.test.local node-01
192.168.50.104 node-02.test.local node-02
192.168.50.105 node-03.test.local node-03
192.168.50.106 node-04.test.local node-04
192.168.50.107 node-05.test.local node-05

EOF

if grep "^puppetmaster" /etc/hostname; then
  # install apt-transport-https
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https

  # create dir for
  # sudo mkdir -p /var/lib/hiera
  # sudo chown root:root -R /var/lib/hiera

  # install puppet master
  # FACTER_LOCATION="${LOCATION}" sudo /etc/puppet/bin/install_puppet_master.sh
else
  # we are working with nodes
  sudo tail /var/log/syslog
  # let's wait a little
  sleep 3
  # sudo puppet agent --enable
  # sudo FACTER_LOCATION="${LOCATION}" FACTER_ROLE=$1 puppet agent -tvd
fi
