Veewee::Session.declare({
  :cpu_count => '1', :memory_size=> '384',
  :disk_size => '10140', :disk_format => 'VDI', :hostiocache => 'off',
  :os_type_id => 'RedHat_64',
  :iso_file => "CentOS-5.7-x86_64-bin-DVD-1of2.iso",
  :iso_src => "http://be.mirror.eurid.eu/centos/5.7/isos/x86_64/CentOS-5.7-x86_64-bin-DVD-1of2.iso",
  :iso_md5 => "55eadec0a6e87c5f2883f734d43fdb58",
  :iso_download_timeout => 1000,
  :iso_download_instructions => "We can not download the ISO , you need to download it yourself and put it in the iso directory\n"+
  "- URL: http://isoredirect.centos.org/centos/5/isos/x86_64/ ",
  :boot_wait => "10", :boot_cmd_sequence => [
    '<Tab> text ks=http://%IP%:%PORT%/ks.cfg<Enter>'
  ],
  :kickstart_port => "7122", :kickstart_timeout => 10000, :kickstart_file => "ks.cfg",
  :ssh_login_timeout => "100", :ssh_user => "vagrant", :ssh_password => "vagrant", :ssh_key => "",
  :ssh_host_port => "7222", :ssh_guest_port => "22",
  :sudo_cmd => "echo '%p'|sudo -S sh '%f'",
  :shutdown_cmd => "/sbin/halt -h -p",
  :postinstall_files => [ "postinstall.sh"], :postinstall_timeout => 10000
})
