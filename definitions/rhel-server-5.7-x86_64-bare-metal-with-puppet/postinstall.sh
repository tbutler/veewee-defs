#http://chrisadams.me.uk/2010/05/10/setting-up-a-centos-base-box-for-development-and-testing-with-vagrant/

date > /etc/vagrant_box_build_time

fail()
{
  echo "FATAL: $*"
  exit 1
}

#kernel source is needed for vbox additions
yum -y install gcc bzip2 make kernel-devel-`uname -r`
#yum -y update
#yum -y upgrade

yum -y install gcc-c++ zlib-devel openssl-devel readline-devel sqlite3-devel
yum -y erase gtk2 libX11 hicolor-icon-theme avahi freetype bitstream-vera-fonts
yum -y clean all

#Installing ruby
#TB cd /tmp
#TB wget http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p194.tar.gz || fail "Could not download Ruby source"
#TB tar xzvf ruby-1.9.3-p194.tar.gz 
#TB cd ruby-1.9.3-p194
#TB ./configure
#TB make && make install
#TB cd /tmp
#TB rm -rf /tmp/ruby-1.9.3-p194
#TB rm /tmp/ruby-1.9.3-p194
#TB ln -s /usr/local/bin/ruby /usr/bin/ruby # Create a sym link for the same path
#TB ln -s /usr/local/bin/gem /usr/bin/gem # Create a sym link for the same path

#Installing chef & Puppet
echo "Installing puppet"
#TB#/usr/local/bin/gem install chef --no-ri --no-rdoc || fail "Could not install chef"
#TB#/usr/local/bin/gem install puppet --no-ri --no-rdoc || fail "Could not install puppet"
export http_proxy="http://Illustrious:8080"
chmod +w /etc/profile
echo 'export http_proxy="http://Illustrious:8080"' >> /etc/profile
chmod -w /etc/profile
export https_proxy="https://Illustrious:8080"
chmod +w /etc/profile
echo 'export https_proxy="https://Illustrious:8080"' >> /etc/profile
chmod -w /etc/profile
cd /tmp
wget http://download.fedoraproject.org/pub/epel/5/x86_64/epel-release-5-4.noarch.rpm
rpm -Uhv epel-release-5-4.noarch.rpm 
rm -f epel-release-5-4.noarch.rpm
yum -y install puppet puppet-server facter

#Installing vagrant keys
mkdir /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
cd /home/vagrant/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O authorized_keys
chown -R vagrant /home/vagrant/.ssh

#Installing the virtualbox guest additions
VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
cd /tmp
wget http://download.virtualbox.org/virtualbox/$VBOX_VERSION/VBoxGuestAdditions_$VBOX_VERSION.iso
mount -o loop VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt

rm VBoxGuestAdditions_$VBOX_VERSION.iso

sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
sed -i "s/^\(.*env_keep = \"\)/\1PATH /" /etc/sudoers

#poweroff -h

exit
