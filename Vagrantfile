# -*- mode: ruby -*-
# vi: set ft=ruby :

# The "2" is Vagrant API/syntax version. Don't touch.
Vagrant.configure(2) do |config|
  # https://atlas.hashicorp.com/search.
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  #config.vm.network :public_network
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "vagrant.yml"
    ansible.sudo = true
  end

end
