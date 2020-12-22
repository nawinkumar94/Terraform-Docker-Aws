# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version 
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "generic/ubuntu2004"
  config.vm.hostname = "devbox"

  config.vm.provider "virtualbox" do |v|
       v.name = "Dev Box"
       v.customize ["modifyvm", :id, "--cpus", '2']
       v.customize ["modifyvm", :id, "--memory", '1024']
  end

  config.ssh.forward_agent = true
 
end
