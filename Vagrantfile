# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "apopa/focal64"
  config.vm.hostname = "opa"
  config.vm.provision "shell", path: "boot/pkg.sh"
  config.vm.provision "shell", path: "boot/env.sh", privileged: false
  config.vm.provision "shell", path: "https://raw.githubusercontent.com/andrewpopa/bash-provisioning/main/terraform/latest.sh"
  config.vm.network "public_network", ip: "192.168.178.61", bridge: "en8: USB 10/100/1000 LAN" # need to be changed according to local env
end
