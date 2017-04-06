#!/bin/bash -x

export DEBIAN_FRONTEND=noninteractive

# use closer mirrors on nodes start
sed -i 's/\.us\./\.ua\./g' /etc/apt/sources.list

# update everything
sudo apt-get update
# run dist-upgrade
sudo DEBIAN_FRONTEND=noninteractive \
  apt-get -y -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" dist-upgrade

# install packages
sudo apt-get install -y puppet

# add server to config
sed -i '/ssldir/a \server=puppetmaster.test.local' /etc/puppet/puppet.conf

sudo tee -a /etc/hosts <<EOF

192.168.56.102 puppetmaster.test.local puppetmaster
192.168.50.103 slave-01.test.local slave-01
192.168.50.104 slave-02.test.local slave-02
192.168.50.105 slave-03.test.local slave-03
192.168.50.106 slave-04.test.local slave-04
192.168.50.107 slave-05.test.local slave-05

EOF

# if grep "^puppetmaster" /etc/hostname; then
#   # install git
#   sudo apt-get install -y git
#
#   # create dir for
#   sudo mkdir -p /var/lib/hiera
#   sudo chown root:root -R /var/lib/hiera
#
#   # install puppet master
#   FACTER_LOCATION="${LOCATION}" sudo /etc/puppet/bin/install_puppet_master.sh
# else
#   # we are working with slaves
#   sudo tail /var/log/syslog
#   # let's wait a little
#   sleep 3
#   sudo puppet agent --enable
#   sudo FACTER_LOCATION="${LOCATION}" FACTER_ROLE=$1 puppet agent -tvd
# fi
